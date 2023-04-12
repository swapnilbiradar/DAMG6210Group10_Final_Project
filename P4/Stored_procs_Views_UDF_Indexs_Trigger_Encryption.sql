

----------- UpdateProductPriceByPercentage Stored Procedure --------------------------
GO
CREATE PROCEDURE sp_UpdateProductPriceByPercentage
    @ProductID INT,
    @Percentage DECIMAL(10,2),
    @NewPrice DECIMAL(10,2) OUTPUT
AS
BEGIN
    DECLARE @OldPrice DECIMAL(10,2)

    SELECT @OldPrice = Product_Price
    FROM Product
    WHERE Product_ID = @ProductID

    SET @NewPrice = @OldPrice + (@OldPrice * @Percentage / 100)

    UPDATE Product
    SET Product_Price = @NewPrice
    WHERE Product_ID = @ProductID
END

GO
----------- Execute UpdateProductPriceByPercentage Stored Procedure -----------------
DECLARE @NewPrice DECIMAL(10,2)

EXEC dbo.sp_UpdateProductPriceByPercentage 
     @ProductID = 1,
     @Percentage = 10.00,
     @NewPrice = @NewPrice OUTPUT
SELECT @NewPrice as NewPrice

----------- UpdateOrderStatus Stored Procedure ------------------------------

GO
CREATE PROCEDURE sp_UpdateOrderStatus
    @order_id INT,
    @payment_status VARCHAR(50),
    @shipment_status VARCHAR(50)

AS
BEGIN
    UPDATE Payment
    SET Payment_Status = @payment_status
    WHERE Payment_ID = (SELECT Payment_ID FROM [Order] WHERE Order_ID = @order_id)
    
    UPDATE Shipment
    SET Shipment_Status = @shipment_status
    WHERE Shipment_ID = (SELECT Shipment_ID FROM OrderItems WHERE Order_ID = @order_id)
END

----------- Executing UpdateOrderStatus Stored Procedure -----------------------------
GO
EXEC dbo.sp_UpdateOrderStatus @order_id = 3, @payment_status = 'Processed', @shipment_status ='Delivered'


----------- GetProductsWithReviews  Stored Procedure -----------------------------

GO
CREATE PROCEDURE sp_GetProductsWithReviews
    @categoryID INT,
    @avgRating FLOAT OUTPUT,
    @reviewCount INT OUTPUT
AS
BEGIN
    SELECT 
        p.Product_ID,
        p.Product_Name,
        AVG(r.Rating) AS AvgRating,
        COUNT(r.Review_ID) AS ReviewCount
    FROM Product p
    JOIN Review r ON p.Product_ID = r.Product_ID
    WHERE p.Category_ID = @categoryID
    GROUP BY p.Product_ID, p.Product_Name

    SELECT @avgRating = AVG(r.Rating), @reviewCount = COUNT(r.Review_ID)
    FROM Product p
    JOIN Review r ON p.Product_ID = r.Product_ID
    WHERE p.Category_ID = @categoryID
END



---------- Executing GetProductsWithReviews Stored Procedure -----------------------------
GO
DECLARE @avgRating FLOAT, @reviewCount INT
EXEC sp_GetProductsWithReviews @categoryID = 1, @avgRating = @avgRating OUTPUT, @reviewCount = @reviewCount OUTPUT
SELECT @avgRating AS AvgRating, @reviewCount AS ReviewCount


















----------- ProductDetails  View --------------------------
GO
CREATE VIEW ProductDetails AS
SELECT p.Product_ID, p.Product_Name, p.Product_Price, c.Category_Name, b.Brand_Name,
       (SELECT AVG(Rating) FROM Review r WHERE r.Product_ID = p.Product_ID) AS Avg_Rating
FROM Product p
JOIN Category c ON p.Category_ID = c.Category_ID
JOIN Brand b ON p.Brand_ID = b.Brand_ID;



----------- OrderShipmentView View --------------------------
GO
CREATE VIEW OrderShipmentView AS
SELECT Order_Date, Cust_FirstName + ' ' + Cust_LastName AS CustomerName, Product_Name, Quantity, Shipment_Status
FROM [Order]
INNER JOIN Customer
ON [Order].Customer_ID = Customer.Cust_ID
INNER JOIN OrderItems
ON [Order].Order_ID = OrderItems.Order_ID
INNER JOIN Product
ON OrderItems.Product_ID = Product.Product_ID
INNER JOIN Shipment
ON OrderItems.Shipment_ID = Shipment.Shipment_ID;

----------- CustomerOrderView View --------------------------
GO
CREATE VIEW CustomerOrderView AS
SELECT Cust_FirstName + ' ' + Cust_LastName AS CustomerName, Order_Date, Total_Amount, Payment_Type, Payment_Status
FROM Customer
INNER JOIN [Order]
ON Customer.Cust_ID = [Order].Customer_ID
INNER JOIN Payment
ON [Order].Payment_ID = Payment.Payment_ID;



-------------------------------------for decrypting data--------------------------------------------------------------
GO
OPEN SYMMETRIC KEY EmpBdate_SK
DECRYPTION BY CERTIFICATE Emp_Bdate;
GO
Create view ShowEmpData2 AS
(
select Emp_ID,Emp_FirstName, Emp_LastName,convert(varchar,DecryptByKey(Emp_DOB)) as Emp_DOB from Employee
)
GO
--query to view ther birthdates for employee
select * from ShowEmpData2
----------------------------------------------------------------------------------------------------------------------









----------- Get_Order_Lead_Time Function --------------------------
GO
CREATE FUNCTION GetOrderLeadTime (@Order_ID FLOAT)
RETURNS INT
AS
BEGIN
DECLARE @temp INT
SELECT @temp=DATEDIFF(DAY, od.Order_Date, s.Shipment_Date)
FROM [Order] od
inner join OrderItems oi on od.Order_ID = oi.Order_ID
inner join Shipment s on oi.Shipment_ID = s.Shipment_ID
WHERE od.Order_ID=@Order_ID
RETURN @temp
END;


------ Get_Order_Lead_Time Function execution----

GO

SELECT od.Order_ID, od.Order_Date, s.Shipment_Date, dbo.GetOrderLeadTime(od.Order_ID) AS [Days] 
FROM [Order] od
INNER JOIN OrderItems oi ON od.Order_ID = oi.Order_ID
INNER JOIN Shipment s ON oi.Shipment_ID = s.Shipment_ID
WHERE od.Order_ID = 3;



----------- CalculateTotalAmount Function --------------------------
GO
CREATE FUNCTION CalculateTotalAmount (@order_id INT)
RETURNS INT
AS
BEGIN
    DECLARE @total_amount INT
    SET @total_amount = (
        SELECT SUM(Product.Product_Price * OrderItems.Quantity)
        FROM OrderItems
        INNER JOIN Product ON OrderItems.Product_ID = Product.Product_ID
        WHERE OrderItems.Order_ID = @order_id
    )
    RETURN @total_amount
END


------ CalculateTotalAmount Function execution----
GO

INSERT INTO [Order] (Order_ID, Customer_ID, Payment_ID, Order_Date, Total_Amount)
VALUES
(100, 1, 1, '2023-04-08',dbo.CalculateTotalAmount(1 ))
go








------------- NON CLUSTERED INDEXS--------------------------------------
GO
CREATE NONCLUSTERED INDEX IX_Payment_PaymentType_PaymentStatus
ON Payment (Payment_Type, Payment_Status);

GO

CREATE NONCLUSTERED INDEX IX_Employee_ManagerID_City_State
ON Employee (Emp_ManagerID, Emp_City, Emp_State);

GO

CREATE NONCLUSTERED INDEX IX_Customer_Location
ON Customer(Cust_City, Cust_State, Cust_Zip);

GO

CREATE NONCLUSTERED INDEX IX_Vendor_City_State 
ON Vendor (Vendor_City, Vendor_State)



----------- Trigger --------------------------
go
CREATE TRIGGER RepeatCustomerTrigger1
ON [order]
AFTER INSERT
AS
BEGIN
  DECLARE @last_order_date DATE;
  DECLARE @customer_email VARCHAR(255);
  

  SELECT @customer_email = cust_email
  FROM customer
  WHERE cust_id = (SELECT customer_id FROM inserted);
  

  SELECT TOP 1 @last_order_date = order_date
  FROM [order]
  WHERE customer_id = (SELECT customer_id FROM inserted)
  ORDER BY order_date DESC;
  
 
  IF @last_order_date IS NOT NULL AND @last_order_date >= DATEADD(DAY, -30, (SELECT order_date FROM inserted)) 
  BEGIN
 
    UPDATE customer
    SET repeat_customer = 1
    WHERE cust_email = @customer_email;
  END
END;



------trigger execution----
GO

INSERT INTO [Order]( order_id,customer_id, payment_id,order_date, total_amount) VALUES (1212,1,1, '2023-04-22', 100.00);


SELECT repeat_customer FROM customer WHERE cust_id = 1;









