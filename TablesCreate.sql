CREATE DATABASE Group10_DAMG6210
GO
USE Group10_DAMG6210
GO
-------------------Creating Customer Table--------------------------------------

CREATE TABLE Customer(
    Cust_ID INT NOT NULL,
    Cust_FirstName VARCHAR(50),
    Cust_LastName VARCHAR(50),
    Cust_Email VARCHAR(50),
    Cust_PhoneNo BIGINT,
    Cust_StreetAddress VARCHAR(100),
    Cust_City VARCHAR(20),
    Cust_State CHAR(2),
    Cust_Zip INT,
    Repeat_customer char(1)

    CONSTRAINT Customer_PK PRIMARY KEY (Cust_ID),
    CONSTRAINT CHK_Cust_PhoneNo CHECK (Cust_PhoneNo>=1000000000 AND Cust_PhoneNo<=9999999999)
);

-------------------Creating Employee Table--------------------------------------

CREATE TABLE Employee(
    Emp_ID INT NOT NULL,
    Emp_FirstName VARCHAR(50),
    Emp_LastName VARCHAR(50),
    Emp_DOB VARBINARY(400),
    Emp_DOJ DATE,
    Emp_Address VARCHAR(100),
    Emp_City VARCHAR(20),
    Emp_State CHAR(2),
    Emp_Zip INT,
    Emp_ContactNo BIGINT,
    Emp_ManagerID INT,
    CONSTRAINT Employee_PK PRIMARY KEY (Emp_ID),
    CONSTRAINT CHK_Emp_ContactNo CHECK (Emp_ContactNo>=1000000000 AND Emp_ContactNo<=9999999999)
);









-------------------Creating Payment Table--------------------------------------

CREATE TABLE Payment(
    Payment_ID INT  NOT NULL,
    Order_ID INT,
    Payment_Date DATE,
    Payment_Type VARCHAR(50),
    Billing_Address VARCHAR(100),
    Billing_City VARCHAR(20),
    Billing_State CHAR(2),
    Billing_Zip INT,
    Amount INT,
    Payment_Status VARCHAR(50),
    CONSTRAINT Payment_PK PRIMARY KEY (Payment_ID)
);

-------------------Creating Order Table--------------------------------------

CREATE TABLE [Order](
    Order_ID INT NOT NULL,
    Customer_ID INT,
    Payment_ID INT,
    Order_Date DATE,
    Total_Amount INT,
    CONSTRAINT Order_PK PRIMARY KEY (Order_ID),
    CONSTRAINT Order_FK1 FOREIGN KEY (Customer_ID) REFERENCES Customer(Cust_ID),
    CONSTRAINT Order_FK2 FOREIGN KEY (Payment_ID) REFERENCES Payment(Payment_ID)
);

-------------------Creating Category Table--------------------------------------

CREATE TABLE Category(
    Category_ID INT NOT NULL,
    Category_Name VARCHAR(20),
    Category_Description VARCHAR(50),
    CONSTRAINT Category_PK PRIMARY KEY (Category_ID)
);

-------------------Creating Brand Table--------------------------------------

CREATE TABLE Brand(
    Brand_ID INT NOT NULL,
    Brand_Name VARCHAR(20),
    Brand_Description VARCHAR(50),
    CONSTRAINT Brand_PK PRIMARY KEY (Brand_ID)
);

-------------------Creating Product Table--------------------------------------

CREATE TABLE Product(
    Product_ID INT NOT NULL,
    Category_ID INT,
    Brand_ID INT,
    Product_Name VARCHAR(30),
    Product_Price FLOAT,
    Product_Description VARCHAR(250),
    CONSTRAINT Product_PK1 PRIMARY KEY (Product_ID),
    CONSTRAINT Product_FK2 FOREIGN KEY (Category_ID) REFERENCES Category(Category_ID),
    CONSTRAINT Product_FK3 FOREIGN KEY (Brand_ID) REFERENCES Brand(Brand_ID)
);

-------------------Creating Review Table--------------------------------------

CREATE TABLE Review(
    Review_ID INT NOT NULL,
    Customer_ID INT,
    Product_ID INT,
    Rating INT,
    Review_Description VARCHAR(100),
    Review_Date DATE,
    CONSTRAINT Review_PK PRIMARY KEY (Review_ID),
    CONSTRAINT Review_FK1 FOREIGN KEY (Customer_ID) REFERENCES Customer(Cust_ID),
    CONSTRAINT Review_FK2 FOREIGN KEY (Product_ID) REFERENCES Product(Product_ID)
);






-------------------Creating DeliveryAgency Table--------------------------------------

CREATE TABLE DeliveryAgency(
    DeliveryAgency_ID INT NOT NULL,
    DeliveryAgency_Name VARCHAR(30),
    DeliveryAgency_Type VARCHAR(20),
    DeliveryAgency_ContactNo BIGINT,
    CONSTRAINT DeliveryAgency_PK PRIMARY KEY (DeliveryAgency_ID),
    CONSTRAINT CHK_DeliveryAgency_ContactNo CHECK (DeliveryAgency_ContactNo>=1000000000 AND DeliveryAgency_ContactNo<=9999999999),
    CONSTRAINT CHK_DeliveryAgency_Type CHECK (DeliveryAgency_Type='Air' OR DeliveryAgency_Type='Ground')
);

-------------------Creating Warehouse Table--------------------------------------

CREATE TABLE Warehouse(
    Warehouse_ID INT NOT NULL,
    Warehouse_Name VARCHAR(30),
    Warehouse_Location VARCHAR(20),
    Warehouse_Capacity VARCHAR(30),
    CONSTRAINT Warehouse_PK PRIMARY KEY (Warehouse_ID)
);

-------------------Creating Vendor Table--------------------------------------

CREATE TABLE Vendor(
    Vendor_ID INT NOT NULL,
    Vendor_Name VARCHAR(30),
    Vendor_Type VARCHAR(20),
    Vendor_Address VARCHAR(100),
    Vendor_City VARCHAR(20),
    Vendor_State CHAR(2),
    Vendor_Zip INT, 
    Vendor_Contact BIGINT,
    CONSTRAINT Vendor_ID_PK PRIMARY KEY (Vendor_ID),
    CONSTRAINT CHK_Vendor_Type CHECK ( Vendor_Type='Retail' OR Vendor_Type='Wholesale')
);



-------------------Creating Shipment Table--------------------------------------

CREATE TABLE Shipment(
    Shipment_ID INT NOT NULL,
    DeliveryAgency_ID INT,
    Warehouse_ID INT,
    Vendor_ID INT,
    Shipment_Date DATE,
    Shipment_Status VARCHAR(30),
    CONSTRAINT Shipment_PK PRIMARY KEY (Shipment_ID),
    CONSTRAINT Shipment_FK1 FOREIGN KEY (DeliveryAgency_ID) REFERENCES DeliveryAgency(DeliveryAgency_ID),
    CONSTRAINT Shipment_FK2 FOREIGN KEY (Warehouse_ID) REFERENCES Warehouse(Warehouse_ID),
    CONSTRAINT Vendor_FK3 FOREIGN KEY (Vendor_ID) REFERENCES Vendor(Vendor_ID)
);

-------------------Creating OrderItems Table--------------------------------------

CREATE TABLE OrderItems(
    Invoice_ID BIGINT NOT NULL,
    Order_ID INT,
    Product_ID INT,
    Shipment_ID INT,
    Quantity INT,
    CONSTRAINT OrderItems_PK PRIMARY KEY (Invoice_ID),
    CONSTRAINT OrderItems_FK1 FOREIGN KEY (Order_ID) REFERENCES [Order](Order_ID),
    CONSTRAINT OrderItems_FK2 FOREIGN KEY (Product_ID) REFERENCES Product(Product_ID),
    CONSTRAINT OrderItems_FK3 FOREIGN KEY (Shipment_ID) REFERENCES Shipment(Shipment_ID)
);






--COLUMN ENCRYPTION--
GO
CREATE MASTER KEY
ENCRYPTION BY PASSWORD = '#nay@1234';
go
--DROP MASTER KEY 
--VERIFY THAT MASTER KEY EXISTS
--SELECT NAME KeyName,
--  symmetric_key_id KeyID,
-- key_length KeyLength,
--  algorithm_desc KeyAlgorithm
--FROM sys.symmetric_keys;
--GO
--CREATE A SELF SIGNED CERTIFICATE AND NAME IT EmpSSN
CREATE CERTIFICATE Emp_Bdate  
   WITH SUBJECT = 'Protect employee personal info';  
GO 
--DROP CERTIFICATE Emp_Bdate
--SELECT name CertName, 
--    certificate_id CertID, 
--    pvt_key_encryption_type_desc EncryptType, 
--    issuer_name Issuer
--FROM sys.certificates;
--CREATE A SYMMETRIC KEY  WITH AES 256 ALGORITHM USING THE CERTIFICATE
--AS ENCRYPTION/DECRYPTION METHOD

CREATE SYMMETRIC KEY EmpBdate_SK
	WITH ALGORITHM = AES_256
ENCRYPTION BY CERTIFICATE Emp_Bdate;  
GO		
--DROP SYMMETRIC KEY EmpBdate_SK
--NOW WE ARE READY TO ENCRYPT THE PASSWORD AND ALSO DECRYPT
--ENCRYPTION IS DONE WHILE INSERTING DATA IN THE INSERT SCRIPT
 --OPEN THE SYMMETRIC KEY WITH WHICH TO ENCRYPT THE DATA.  
OPEN SYMMETRIC KEY EmpBdate_SK
DECRYPTION BY CERTIFICATE Emp_Bdate;
GO









