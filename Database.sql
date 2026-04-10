CREATE DATABASE Blockbuster;
USE Blockbuster;

CREATE TABLE Stores
(
	Store_ID int AUTO_INCREMENT PRIMARY KEY,
	Address varchar(150) Not Null,
	No_of_workers tinyint,
	open_Date date Not Null
);

CREATE TABLE Workers
(
	Work_SSN int AUTO_INCREMENT PRIMARY KEY,
	First_Name varchar(50) Not Null,
    last_Name varchar(50) Not Null,
	House_Address varchar(150),
	PhoneNo int,
	Salary DECIMAL Not Null,
	Start_Date date Not Null,
	Position varchar(50) Not Null,
	Date_Of_Birth date,
	Gender char(1) CHECK(Gender IN ('M', 'F')),
    Store_ID int,
    FOREIGN KEY (Store_ID) REFERENCES stores(Store_ID)
    );	
    
    
    
CREATE TABLE Dependants
(
	First_Name varchar(50) Not Null,
    last_Name varchar(50) Not Null,
	Gender char(1) CHECK(Gender IN ('M', 'F')),
	Date_Of_Birth date,
    Work_SSN int,
    PRIMARY KEY (Work_SSN, First_Name, last_Name),
    FOREIGN KEY (Work_SSN) REFERENCES Workers(Work_SSN)
	);

CREATE TABLE Customers
(
	Customer_ID int AUTO_INCREMENT PRIMARY KEY,
	First_Name varchar(50) Not Null,
    last_Name varchar(50) Not Null,
	PhoneNo varchar(20) UNIQUE,
	Email varchar(320) UNIQUE,
	Fines DECIMAL Not Null CHECK (Fines >= 0)
);

CREATE TABLE Product
(
	Product_ID int AUTO_INCREMENT PRIMARY KEY,
	Title varchar(255) NOT NULL,
	Age_Rating	varchar(10),
    type varchar(15),
	Release_Date date, 
	Director varchar(50),
	Price decimal(5, 2) Not Null CHECK(Price >= 20)

);


CREATE TABLE StoreCards
(
	Benefits_Level tinyint(1) Not Null CHECK(Benefits_Level > 0 and Benefits_Level <= 5),
	Status bool Not Null,
	Expiration_Date date Not Null,
    Customer_ID int,
    PRIMARY KEY( Customer_ID, Expiration_date ),
    FOREIGN KEY( Customer_ID ) REFERENCES Customers( Customer_ID ) ON UPDATE CASCADE ON DELETE CASCADE
);

-- -- -- -- -- -- -- -- -- --
-- MULTIVALUED ATTRIBUTES
-- -- -- -- -- -- -- -- -- --

CREATE TABLE Genre -- Multivalued attribute related to Product
(
	Product_ID int,
    Genre varchar(20),
    PRIMARY KEY (Product_ID, Genre),
	FOREIGN KEY (Product_ID) REFERENCES Product(Product_ID) ON UPDATE CASCADE ON DELETE CASCADE
    ); 

CREATE TABLE Revenue -- Multivalued attribute related to Stores
(
	Store_ID int,
    Year int,
    Store_Revenue DECIMAL(25,5) CHECK( Store_revenue >= 0 ),
    PRIMARY KEY(Store_ID, Year), -- Composite primary key
    FOREIGN KEY (Store_ID) REFERENCES Stores(Store_ID) ON UPDATE CASCADE ON DELETE CASCADE  -- How to write a foreign key
);

-- -- -- -- -- -- -- -- -- --
-- Relationships
-- -- -- -- -- -- -- -- -- --

CREATE TABLE Rents -- Many to Many relationship related to Customers and Product
(
	Customer_ID int,
    Product_ID int,
    Return_by_Date date,
    Late_Fees int,
    PRIMARY KEY(Customer_ID, Product_ID, Return_by_Date),
    FOREIGN KEY(Customer_ID) REFERENCES Customers(Customer_ID),
	FOREIGN KEY(Product_ID) REFERENCES Product(Product_ID)
);

CREATE TABLE Stocks -- Many to Many relationship related to Stores and Product
(
	Store_ID int,
    Product_ID int,
	InStock tinyint Not Null, -- Number of copies currently in stock
	Copies_Borrowed tinyint DEFAULT 0 Not Null, -- Number of copies currently borrowed out
    PRIMARY KEY(Store_ID, Product_ID),
    FOREIGN KEY(Store_ID) REFERENCES Stores(Store_ID),
	FOREIGN KEY(Product_ID) REFERENCES Product(Product_ID)
);


