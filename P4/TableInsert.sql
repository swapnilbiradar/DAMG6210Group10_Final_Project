OPEN SYMMETRIC KEY EmpBdate_SK
DECRYPTION BY CERTIFICATE Emp_Bdate;
GO


----------------------- Insert in Customer Table-------------------------------------
INSERT INTO Customer(Cust_ID, Cust_FirstName, Cust_LastName, Cust_Email, Cust_PhoneNo,
Cust_StreetAddress, Cust_City, Cust_State, Cust_Zip)
VALUES
(1, 'Sachin', 'Tendulkar', 'Sachin@gmail.com', 1234567890, '123 Main St', 'New York', 'NY', 12345),
(2, 'Virendra', 'Shewag', 'Virendra@gmail.com', 2345678901, '456 Park Ave', 'Los Angeles', 'CA', 23456),
(3, 'Gautam', 'Gambhir', 'Gautam@gmail.com', 3456789012, '789 Elm St', 'Chicago', 'IL', 34567),
(4, 'Virat', 'Kohli', 'Virat@gmail.com', 4567890123, '321 Oak Rd', 'Houston', 'TX', 45678),
(5, 'Yuvraj', 'Singh', 'Yuvraj@gmail.com', 5678901234, '654 Pine St', 'San Francisco', 'CA', 56789),
(6, 'Mahi', 'Dhoni', 'Mahi@gmail.com', 6789012345, '987 Maple Dr', 'Seattle', 'WA', 67890),
(7, 'Suresh', 'Raina', 'Suresh@gmail.com', 7890123456, '369 Broadway', 'Boston', 'MA', 78901),
(8, 'Harbhajan', 'Singh', 'Harbhajan@gmail.com', 8901234567, '852 Lincoln Ave', 'Dallas', 'TX', 89012),
(9, 'Zaheer', 'Khan', 'Zaheer@gmail.com', 9012345678, '753 Washington St', 'Miami', 'FL', 90123),
(10, 'Munaf', 'Patel', 'Munaf@gmail.com', 1234509876, '159 Chestnut St', 'Atlanta', 'GA', 01234);
----------------------- Insert in Employee Table-------------------------------------
INSERT INTO Employee (Emp_ID, Emp_FirstName, Emp_LastName, Emp_DOB, Emp_DOJ, Emp_Address,
Emp_City, Emp_State, Emp_Zip, Emp_ContactNo, Emp_ManagerID)
VALUES
(1, 'Rohit', 'Sharma', EncryptByKey(Key_GUID('EmpBdate_SK'), convert(varbinary,'1990-01-01')), '2015-01-01', '123 Main St', 'Anytown', 'CA', 12345, 5555555555, 2),
(2, 'Ishan', 'Kisan', EncryptByKey(Key_GUID('EmpBdate_SK'), convert(varbinary,'1985-03-15')), '2010-05-01', '456 Oak St', 'Somewhere', 'NY', 67890, 6667778888, 3),
(3, 'Surya', 'Yadav', EncryptByKey(Key_GUID('EmpBdate_SK'), convert(varbinary,'1978-07-20')), '2005-12-15', '789 Maple Ave', 'Nowhere', 'TX', 54321, 9998887777, 2),
(4, 'Hardik', 'Pandya', EncryptByKey(Key_GUID('EmpBdate_SK'), convert(varbinary,'1992-05-10')), '2018-04-01', '567 Elm St', 'Everytown', 'FL', 98765, 7776665555, 3),
(5, 'Krunal', 'Pandya', EncryptByKey(Key_GUID('EmpBdate_SK'), convert(varbinary,'1983-11-30')), '2013-08-15', '432 Pine St', 'Anytown', 'CA', 13579, 8889990000, 2),
(6, 'Kieron', 'Pollard', EncryptByKey(Key_GUID('EmpBdate_SK'), convert(varbinary,'1980-09-05')), '2008-02-01', '678 Cedar St', 'Somewhere', 'NY', 86420, 4443332222, 3),
(7, 'Tim', 'David', EncryptByKey(Key_GUID('EmpBdate_SK'), convert(varbinary,'1975-12-25')), '2002-06-15', '345 Oak St', 'Nowhere', 'TX', 97531, 2221110000, 2),
(8, 'Jasprit', 'Bumrah', EncryptByKey(Key_GUID('EmpBdate_SK'), convert(varbinary,'1995-08-20')), '2020-03-01', '789 Birch Ave', 'Everytown', 'FL', 32167, 1112223333, 3),
(9, 'Lashit', 'Malinga', EncryptByKey(Key_GUID('EmpBdate_SK'), convert(varbinary,'1988-04-02')), '2012-01-15', '234 Maple Ave', 'Anytown', 'CA', 65432, 4445556666, 2),
(10, 'Trent', 'Boult', EncryptByKey(Key_GUID('EmpBdate_SK'), convert(varbinary,'1991-02-14')), '2016-09-01', '876 Pine St', 'Somewhere', 'NY', 54321, 7778889999, 3);
----------------------- Insert in Payment Table-------------------------------------
INSERT INTO Payment (Payment_ID, Order_ID, Payment_Date, Payment_Type, Billing_Address, Billing_City,
Billing_State, Billing_Zip, Amount, Payment_Status)
VALUES
(1, 1, '2023-04-08', 'Credit Card', '123 Main St', 'Anytown', 'NY', 12345, 50, 'Processed'),
(2, 2, '2023-04-08', 'PayPal', '456 Oak Ave', 'Someville', 'CA', 67890, 25, 'Pending'),
(3, 3, '2023-04-07', 'Credit Card', '789 Pine St', 'Othertown', 'TX', 23456, 75, 'Pending'),
(4, 4, '2023-04-06', 'Cash', '321 Elm St', 'Anycity', 'NY', 45678, 100, 'Processed'),
(5, 5, '2023-04-05', 'Credit Card', '654 Birch Ln', 'Sometown', 'CA', 78901, 200, 'Pending'),
(6, 6, '2023-04-04', 'PayPal', '987 Maple Ave', 'Anystate', 'TX', 34567, 150, 'Processed'),
(7, 7, '2023-04-03', 'Credit Card', '246 Cedar St', 'Otherville', 'NY', 89012, 300, 'Processed'),
(8, 8, '2023-04-02', 'Cash', '135 Oakwood Dr', 'Othercity', 'CA', 12345, 50, 'Processed'),
(9, 9, '2023-04-01', 'Credit Card', '864 Pine Ln', 'Anyplace', 'TX', 67890, 75, 'Pending'),
(10,10, '2022-12-31', 'PayPal', '975 Elm Ave', 'Somewhere', 'NY', 23456, 125, 'Processed');
----------------------- Insert in Order Table-------------------------------------
INSERT INTO [Order] (Order_ID, Customer_ID, Payment_ID, Order_Date, Total_Amount)
VALUES
(1, 1, 1, '2023-04-12', 50),
(2, 2, 2, '2023-04-23', 25),
(3, 3, 3, '2023-04-16', 75),
(4, 4, 4, '2023-04-08', 100),
(5, 5, 5, '2023-04-03', 200),
(6, 6, 6, '2023-04-17', 150),
(7, 7, 7, '2023-04-09', 300),
(8, 8, 8, '2023-04-27', 50),
(9, 9, 9, '2023-04-29', 75),
(10, 10, 10, '2023-04-30', 125)
----------------------- Insert in Category Table-------------------------------------
INSERT INTO Category (Category_ID, Category_Name, Category_Description)
VALUES
(1, 'Electronics', 'Electronic devices and accessories'),
(2, 'Books', 'Fiction and non-fiction books'),
(3, 'Clothing', 'Apparel and accessories'),
(4, 'Home and Garden', 'Home improvement and gardening items'),
(5, 'Toys and Games', 'Toys, games, and puzzles for all ages'),
(6, 'Health and Beauty', 'Health and beauty products'),
(7, 'Sports and Outdoors', 'Sports equipment and outdoor gear'),
(8, 'Pet Supplies', 'Pet food, toys, and accessories'),
(9, 'Food and Beverage', 'Food, drinks, and snacks'),
(10, 'Automotive', 'Car parts and accessories');
----------------------- Insert in Brand Table-------------------------------------
INSERT INTO Brand (Brand_ID, Brand_Name, Brand_Description)
VALUES
(1, 'Sony', 'Consumer electronics company'),
(2, 'Samsung', 'Electronics and appliances manufacturer'),
(3, 'Penguin Random House', 'Publisher of books and literature'),
(4, 'Hachette Livre', 'Publisher of books and literature'),
(5, 'H&M', 'Clothing and fashion company'),
(6, 'Zara', 'Clothing and fashion company'),
(7, 'Home Depot', 'Home improvement store'),
(8, 'LEGO', 'Toy construction set company'),
(9, 'Hasbro', 'Toy and board game company'),
(10, 'Procter & Gamble', 'Consumer goods company'),
(11, 'Nike', 'Sportswear and accessories company'),
(12, 'Adidas', 'Sportswear and accessories company'),
(13, 'Chewy', 'Pet food and supplies company'),
(14, 'Coca-Cola', 'Beverage company'),
(15, 'Nestle', 'Food and beverage company'),
(16, 'AutoZone', 'Automotive parts and accessories retailer');
----------------------- Insert in Product Table-------------------------------------
INSERT INTO Product (Product_ID, Category_ID, Brand_ID, Product_Name, Product_Price, Product_Description)
VALUES
(1, 1, 1, 'Sony PlayStation 5', 499.99, 'Next-generation video game console'),
(2, 1, 2, 'Samsung Galaxy S21 Ultra', 1199.99, 'Flagship Android smartphone'),
(3, 2, 3, '1984 by George Orwell', 12.99, 'Dystopian novel'),
(4, 2, 4, 'The Girl on the Train', 9.99, 'Thriller novel'),
(5, 3, 5, 'H&M Knit Sweater', 39.99, 'Cozy knit sweater for colder weather'),
(6, 3, 6, 'Zara Skinny Jeans', 49.99, 'Trendy skinny jeans for women'),
(7, 4, 7, 'Husky 20 ft. Ladder', 189.00, 'Multipurpose aluminum ladder'),
(8, 5, 8, 'LEGO Star Wars', 799.99, 'Iconic Star Wars spaceship construction set'),
(9, 5, 9, 'Monopoly Board Game', 19.99, 'Classic board game for all ages'),
(10, 6, 10, 'Tide Laundry Detergent', 11.99, 'Liquid laundry detergent'),
(11, 7, 11, 'Nike Air Max 270', 150.00, 'Stylish and comfortable sneakers'),
(12, 7, 12, 'Adidas Ultraboost 21', 180.00, 'High-performance running shoes'),
(13, 8, 13, 'Chewy Blu Dog Food', 48.98, 'Dry dog food for all breeds'),
(14, 9, 14, 'Coca-Cola Classic', 2.99, 'Refreshing carbonated soft drink'),
(15, 9, 15, 'Nestle KitKat', 0.99, 'Crisp chocolate wafer bar'),
(16, 10, 16, 'AutoZone Brake Pads', 49.99, 'Ceramic brake pads for most vehicles');
----------------------- Insert in Review Table-------------------------------------
INSERT INTO Review (Review_ID, Customer_ID, Product_ID, Rating, Review_Description, Review_Date)
VALUES
(1, 1, 1, 4, 'Great gaming console!', '2022-03-15'),
(2, 2, 2, 5, 'Amazing camera and performance', '2022-03-18'),
(3, 3, 3, 3, 'Interesting read, but not my favorite', '2022-03-20'),
(4, 4, 4, 4, 'Kept me on the edge of my seat', '2022-03-22'),
(5, 5, 5, 5, 'Love the sweater, it fits perfectly', '2022-03-25'),
(6, 6, 6, 2, 'Not my style, but my friend loved them', '2022-03-28'),
(7, 7, 7, 4, 'Sturdy and reliable ladder', '2022-03-30'),
(8, 8, 8, 5, 'Awesome Star Wars set, great detail', '2022-04-01'),
(9, 9, 9, 3, 'Fun game, but takes too long to finish', '2022-04-03'),
(10, 10, 10, 5, 'Cleans my clothes well, and smells great!', '2022-04-06');
----------------------- Insert in DeliveryAgency Table-------------------------------------
INSERT INTO DeliveryAgency (DeliveryAgency_ID, DeliveryAgency_Name, DeliveryAgency_Type,
DeliveryAgency_ContactNo)
VALUES
(1, 'FastHaul', 'Ground', 5555555555),
(2, 'SwiftShip', 'Ground', 2345678901),
(3, 'RapidDeliver', 'Ground', 3456789012),
(4, 'AirExpress', 'Air', 4567890123),
(5, 'GroundHaul', 'Ground', 5678901234),
(6, 'AirFleet', 'Air', 6789012345),
(7, 'SpeedyShip', 'Ground', 7890123456),
(8, 'FlyByNight', 'Air', 8901234567),
(9, 'GroundForce', 'Ground', 9012345678),
(10, 'SpeedyDeliver', 'Ground', 7777777777);
----------------------- Insert in Warehouse Table-------------------------------------
INSERT INTO Warehouse (Warehouse_ID, Warehouse_Name, Warehouse_Location, Warehouse_Capacity)
VALUES
(1, 'Main Warehouse', 'New York', '1000'),
(2, 'North Warehouse', 'Boston', '500'),
(3, 'South Warehouse', 'Miami', '750'),
(4, 'West Warehouse', 'Los Angeles', '1200'),
(5, 'East Warehouse', 'Atlanta', '900'),
(6, 'Central Warehouse', 'Chicago', '800'),
(7, 'Midtown Warehouse', 'Houston', '1100'),
(8, 'Downtown Warehouse', 'San Francisco', '1500'),
(9, 'Uptown Warehouse', 'Seattle', '600'),
(10, 'Suburban Warehouse', 'Dallas', '1000');
----------------------- Insert in Vendor Table-------------------------------------
INSERT INTO Vendor (Vendor_ID, Vendor_Name, Vendor_Type, Vendor_Address, Vendor_City, Vendor_State,
Vendor_Zip, Vendor_Contact)
VALUES (1, 'ABC Traders', 'Wholesale', '123 Main St', 'Dallas', 'TX', 12345, 5551234567),
(2, 'XYZ Inc.', 'Retail', '456 Market St', 'San Jose', 'CA', 67890, 5559876543),
(3, 'PQR Enterprises', 'Wholesale', '789 Broadway', 'Dallas', 'TX', 54321, 5552345678),
(4, 'LMN Distributors', 'Retail', '987 Elm St', 'Chicago', 'IL', 45678, 5558765432),
(5, 'RST Suppliers', 'Wholesale', '321 Oak Ave', 'Maimi', 'FL', 90123, 5553456789),
(6, 'UVW Retailers', 'Retail', '654 Pine St', 'Dallas', 'TX', 23456, 5557654321),
(7, 'DEF Co.', 'Wholesale', '111 Chestnut St', 'Boston', 'MA', 78901, 5553217654),
(8, 'GHI Inc.', 'Retail', '222 Maple Ave', 'Boston', 'MA', 65432, 5554567890),
(9, 'JKL Distributors', 'Wholesale', '333 Cherry St', 'Charllote', 'NC', 98765, 5556789012),
(10, 'MNO Enterprises', 'Retail', '444 Walnut St', 'Maimi', 'FL', 32109, 5552109876);
----------------------- Insert in Shipment Table-------------------------------------
INSERT INTO Shipment (Shipment_ID, DeliveryAgency_ID, Warehouse_ID, Vendor_ID, Shipment_Date,
Shipment_Status)
VALUES
(1, 2, 3, 4, '2023-04-15', 'In transit'),
(2, 1, 5, 6, '2023-04-25', 'Delivered'),
(3, 3, 2, 7, '2023-04-19', 'In transit'),
(4, 1, 9, 8, '2023-04-12', 'In transit'),
(5, 4, 1, 10, '2023-04-09', 'Delivered'),
(6, 2, 4, 3, '2023-04-21', 'Delivered'),
(7, 3, 7, 6, '2023-04-16', 'Delivered'),
(8, 4, 10, 9, '2023-04-30', 'In transit'),
(9, 1, 8, 5, '2023-05-02', 'Delivered'),
(10, 2, 6, 7, '2023-05-05', 'Delivered')


----------------------- Insert in OrderItems Table-------------------------------------
INSERT INTO OrderItems (Invoice_ID, Order_ID, Product_ID, Shipment_ID, Quantity)
VALUES
(101, 1, 1, 1, 1),
(102, 2, 2, 2, 2),
(103, 3, 3, 3, 3),
(104, 4, 4, 4, 4),
(105, 5, 5, 5, 2),
(106, 6, 6, 6, 6),
(107, 7, 7, 7, 3),
(108, 8, 8, 8, 4),
(109, 9, 9, 9, 1),
(110, 10, 10, 10,5)
