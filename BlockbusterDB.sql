USE master;
GO

IF DB_ID('Blockbuster') IS NOT NULL
BEGIN
    ALTER DATABASE Blockbuster SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE Blockbuster;
END;
GO

CREATE DATABASE Blockbuster;
GO

USE Blockbuster;
GO
CREATE TABLE Stores
(
	Store_ID int IDENTITY(1,1) PRIMARY KEY,
	Address varchar(150) Not Null,
	No_of_workers tinyint,
	open_Date date Not Null
);

CREATE TABLE Workers
(
	Work_SSN int IDENTITY(1,1) PRIMARY KEY,
	First_Name varchar(50) Not Null,
    last_Name varchar(50) Not Null,
	House_Address varchar(150),
	PhoneNo varchar(20),
	Salary DECIMAL(10,2) Not Null,
	Start_Date date Not Null,
	Position varchar(50) Not Null,
	Date_Of_Birth date,
	Gender char(1) CHECK(Gender IN ('M', 'F')),
    Store_ID int,
    FOREIGN KEY (Store_ID) REFERENCES stores(Store_ID)
    );	
    
    
    
CREATE TABLE Dependants -- People related to workers
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
	Customer_ID int IDENTITY(1,1) PRIMARY KEY,
	First_Name varchar(50) Not Null,
    last_Name varchar(50) Not Null,
	PhoneNo varchar(20) UNIQUE,
	Email varchar(320) UNIQUE,
	Fines DECIMAL Not Null CHECK (Fines >= 0)
);

CREATE TABLE Product
(
	Product_ID int IDENTITY(1,1) PRIMARY KEY,
	Title varchar(255) NOT NULL,
	Age_Rating	varchar(10),
    type varchar(15),
	Release_Date date, 
	Creator varchar(50),
	Price decimal(5, 2) Not Null CHECK(Price >= 20)

);


CREATE TABLE StoreCards
(
	Benefits_Level varchar(1) Not Null CHECK(Benefits_Level > 0 and Benefits_Level <= 5),
	Status BIT Not Null,
	Expiration_Date date Not Null,
    Customer_ID int,
    PRIMARY KEY( Customer_ID, Expiration_date ),
    FOREIGN KEY( Customer_ID ) REFERENCES Customers( Customer_ID ) ON UPDATE CASCADE ON DELETE CASCADE
);

-- -- -- -- -- -- -- -- -- 
-- MULTIVALUED ATTRIBUTES:
-- -- -- -- -- -- -- -- -- 
CREATE TABLE Genre 
(
	Product_ID int,
    Genre varchar(20),
    PRIMARY KEY (Product_ID, Genre),
	FOREIGN KEY (Product_ID) REFERENCES Product(Product_ID) ON UPDATE CASCADE ON DELETE CASCADE
    ); 

CREATE TABLE Revenue
(
	Store_ID int,
    Year int,
    Store_Revenue DECIMAL(25,5) CHECK( Store_revenue >= 0 ),
    PRIMARY KEY(Store_ID, Year), -- Composite primary key
    FOREIGN KEY (Store_ID) REFERENCES Stores(Store_ID) ON UPDATE CASCADE ON DELETE CASCADE  -- How to write a foreign key
);


-- Relationships

CREATE TABLE Rents 
(
	Customer_ID int,
    Product_ID int,
    Return_by_Date date,
    Late_Fees int,
    PRIMARY KEY(Customer_ID, Product_ID, Return_by_Date),
    FOREIGN KEY(Customer_ID) REFERENCES Customers(Customer_ID),
	FOREIGN KEY(Product_ID) REFERENCES Product(Product_ID)
);

CREATE TABLE Stocks 
(
	Store_ID int,
    Product_ID int,
	InStock tinyint Not Null, -- Number of copies currently in stock
	Copies_Borrowed tinyint DEFAULT 0 Not Null, -- Number of copies currently borrowed out
    PRIMARY KEY(Store_ID, Product_ID),
    FOREIGN KEY(Store_ID) REFERENCES Stores(Store_ID),
	FOREIGN KEY(Product_ID) REFERENCES Product(Product_ID)
);


-- STORES 

INSERT INTO Stores (Address, No_of_workers, open_Date) VALUES
('Nasr City, Cairo', 10, '2015-06-01'),
('Maadi, Cairo', 8, '2017-09-15'),
('Heliopolis, Cairo', 12, '2014-03-20'),
('Alexandria Downtown', 7, '2018-11-10');

-- WORKERS
INSERT INTO Workers (First_Name, last_Name, House_Address, PhoneNo, Salary, Start_Date, Position, Date_Of_Birth, Gender, Store_ID) VALUES
('Ahmed', 'Hassan', 'Nasr City', '01012345678', 5000, '2020-01-01', 'Manager', '1990-05-10', 'M', 1),
('Sara', 'Ali', 'Maadi', '01087654321', 4000, '2021-03-15', 'Cashier', '1995-07-22', 'F', 2),
('Omar', 'Khaled', 'Heliopolis', NULL, 4500, '2019-06-10', 'Supervisor', '1992-02-18', 'M', 3),
('Mona', 'Adel', 'Alexandria', '01122334455', 3800, '2022-08-01', 'Assistant', '1998-11-05', 'F', 4),
('Hassan','Fathy','Cairo','01055511111',4800,'2018-03-12','Clerk','1991-04-15','M',1),
('Dina','Samir','Giza','01155522222',3900,'2020-07-19','Cashier','1996-08-22','F',2),
('Khaled','Youssef','Alexandria','01255533333',5200,'2017-11-01','Manager','1988-12-30','M',3),
('Nadia','Adel','Maadi','01055544444',4100,'2021-02-10','Assistant','1997-01-05','F',4),
('Tarek','Mahmoud','Nasr City','01155555555',4500,'2019-06-14','Clerk','1993-09-09','M',1),
('Salma','Hesham','Dokki','01255566666',4300,'2022-04-01','Cashier','1999-03-17','F',2),
('Yara','Nabil','Smouha','01055577777',4200,'2021-09-25','Assistant','1998-06-11','F',3),
('Amr','Fouad','Cairo','01155588888',4700,'2018-12-05','Clerk','1992-10-21','M',4),
('Reem','Tamer','Giza','01255599999',4000,'2023-01-15','Cashier','2000-02-02','F',1),
('Mostafa','Zaki','Alexandria','01055600000',5300,'2016-05-20','Manager','1987-07-13','M',2);



-- DEPENDANTS (Weak Entity)
INSERT INTO Dependants (First_Name, last_Name, Gender, Date_Of_Birth, Work_SSN) VALUES
('Youssef', 'Hassan', 'M', '2015-04-01', 1),
('Laila', 'Hassan', 'F', '2017-08-12', 1),
('Karim', 'Ali', 'M', '2018-01-20', 2),
('Nour', 'Khaled', 'F', '2016-09-30', 3),
('Ali','Hassan','M','2015-05-01',5),
('Mariam','Hassan','F','2018-07-12',5),
('Omar','Dina','M','2019-09-20',6),
('Lina','Khaled','F','2012-11-11',7),
('Youssef','Nadia','M','2020-01-01',8),
('Adam','Tarek','M','2016-03-03',9),
('Farah','Salma','F','2021-04-04',10),
('Hana','Yara','F','2022-05-05',11),
('Karim','Amr','M','2017-06-06',12),
('Nour','Reem','F','2023-07-07',13),
('Ziad','Mostafa','M','2010-08-08',14);

-- CUSTOMERS
INSERT INTO Customers (First_Name, last_Name, PhoneNo, Email, Fines) VALUES
('Mostafa', 'Ibrahim', '011111534433', 'mostafa@mail.com', 0),
('Hana', 'Samy', '01014055111', 'hana@mail.com', 50),
('Yara', 'Tarek', '01061361302', 'yara@mail.com', 10),
('Kareem', 'Nabil', '01008000806', 'kareem@mail.com', 0),
('Ali','Saeed','01060000001','ali1@mail.com',0),
('Mona','Lotfy','01060000002','mona2@mail.com',5),
('Hany','Ragab','01060000003','hany3@mail.com',0),
('Nada','Fathy','01060000004','nada4@mail.com',2),
('Sameh','Adel','01060000005','sameh5@mail.com',0),
('Rana','Maher','01060000006','rana6@mail.com',7),
('Sherif','Kamel','01060000007','sherif7@mail.com',0),
('Dalia','Tarek','01060000008','dalia8@mail.com',3),
('Walid','Hossam','01060000009','walid9@mail.com',0),
('Ghada','Sami','01060000010','ghada10@mail.com',1),
('Fady','George','01060000011','fady11@mail.com',0),
('Nermine','Ashraf','01060000012','nermine12@mail.com',4),
('Bassam','Nader','01060000013','bassam13@mail.com',0),
('Riham','Zein','01060000014','riham14@mail.com',6),
('Ahmed','Talaat','01060000015','ahmed15@mail.com',0),
('Heba','Magdy','01060000016','heba16@mail.com',2),
('Samir','Wagdy','01060000017','samir17@mail.com',0),
('Doaa','Sabry','01060000018','doaa18@mail.com',3),
('Essam','Fikry','01060000019','essam19@mail.com',0),
('Lobna','Yehia','01060000020','lobna20@mail.com',5),
('Ayman','Hamed','01060000021','ayman21@mail.com',0),
('Nelly','Karam','01060000022','nelly22@mail.com',1),
('Mahmoud','Anwar','01060000023','mahmoud23@mail.com',0),
('Rasha','Eid','01060000024','rasha24@mail.com',2),
('Tamer','Selim','01060000025','tamer25@mail.com',0),
('Noha','Reda','01060000026','noha26@mail.com',3),
('Kareem','Ashour','01060000027','kareem27@mail.com',0),
('Salwa','Aziz','01060000028','salwa28@mail.com',4),
('Yehia','Fouad','01060000029','yehia29@mail.com',0),
('Alaa','Naguib','01060000030','alaa30@mail.com',2),
('Bassem','Raouf','01060000031','bassem31@mail.com',0),
('Hoda','Gamal','01060000032','hoda32@mail.com',1),
('Wael','Farid','01060000033','wael33@mail.com',0),
('Sahar','Mostafa','01060000034','sahar34@mail.com',5),
('Adham','Samy','01060000035','adham35@mail.com',0),
('Mervat','Ali','01060000036','mervat36@mail.com',2),
('Nader','Galal','01060000037','nader37@mail.com',0),
('Rami','Hafez','01060000038','rami38@mail.com',3),
('Shimaa','Zaki','01060000039','shimaa39@mail.com',0),
('Eman','Fouad','01060000040','eman40@mail.com',1),
('Hussein','Sayed','01060000041','hussein41@mail.com',0),
('Dina','Kamal','01060000042','dina42@mail.com',2),
('Mostafa','Ibrahim','01060000043','mostafa43@mail.com',0),
('Nourhan','Tarek','01060000044','nourhan44@mail.com',4),
('Amira','Hassan','01060000045','amira45@mail.com',0),
('Karima','Lotfy','01060000046','karima46@mail.com',1),
('Sayed','Hamdy','01060000047','sayed47@mail.com',0),
('Fouad','Adly','01060000048','fouad48@mail.com',3),
('Reda','Morsi','01060000049','reda49@mail.com',0),
('Hala','Sabir','01060000050','hala50@mail.com',2);


-- PRODUCT
--Movies/Shows
INSERT INTO Product (Title, Age_Rating, type, Release_Date, Creator, Price) VALUES
('Inception', 'PG-13', 'Movie', '2010-07-16', 'Christopher Nolan', 50),
('Breaking Bad', '18+', 'Series', '2008-01-20', 'Vince Gilligan', 60),
('The Matrix', 'R', 'Movie', '1999-03-31', 'Wachowski', 45),
('The Dark Knight','PG-13','Movie','2008-07-18','Christopher Nolan',60),
('Joker','18+','Movie','2019-10-04','Todd Phillips',55),
('Titanic','PG-13','Movie','1997-12-19','James Cameron',50),
('Avatar','PG-13','Movie','2009-12-18','James Cameron',65),
('Avengers: Endgame','PG-13','Movie','2019-04-26','Marvel Studios',70),
('Iron Man','PG-13','Movie','2008-05-02','Jon Favreau',55),
('The Godfather','18+','Movie','1972-03-24','Francis Ford Coppola',60),
('Pulp Fiction','18+','Movie','1994-10-14','Quentin Tarantino',55),
('Fight Club','18+','Movie','1999-10-15','David Fincher',50),
('Forrest Gump','PG-13','Movie','1994-07-06','Robert Zemeckis',55),
('The Shawshank Redemption','18+','Movie','1994-09-23','Frank Darabont',60),
('Gladiator','18+','Movie','2000-05-05','Ridley Scott',55),
('Interstellar','PG-13','Movie','2014-11-07','Christopher Nolan',70),
('Inglourious Basterds','18+','Movie','2009-08-21','Quentin Tarantino',60),
('Django Unchained','18+','Movie','2012-12-25','Quentin Tarantino',65),
('The Matrix Reloaded','18+','Movie','2003-05-15','Wachowski',55),
('The Matrix Revolutions','18+','Movie','2003-11-05','Wachowski',50),
('Doctor Strange','PG-13','Movie','2016-11-04','Marvel Studios',60),
('Black Panther','PG-13','Movie','2018-02-16','Marvel Studios',65),
('Captain America: Civil War','PG-13','Movie','2016-05-06','Marvel Studios',65),
('Thor: Ragnarok','PG-13','Movie','2017-11-03','Marvel Studios',60),
('Guardians of the Galaxy','PG-13','Movie','2014-08-01','Marvel Studios',60),
('Deadpool','18+','Movie','2016-02-12','Tim Miller',65),
('Deadpool 2','18+','Movie','2018-05-18','David Leitch',65),
('Logan','18+','Movie','2017-03-03','James Mangold',60),
('The Batman','PG-13','Movie','2022-03-04','Matt Reeves',70),
('Spider-Man: No Way Home','PG-13','Movie','2021-12-17','Marvel Studios',75),
('Doctor Strange in the Multiverse of Madness','PG-13','Movie','2022-05-06','Marvel Studios',70),
('Top Gun: Maverick','PG-13','Movie','2022-05-27','Joseph Kosinski',75),
('Oppenheimer','18+','Movie','2023-07-21','Christopher Nolan',80),
-- GAMES
('The Witcher 3: Wild Hunt', '18+', 'Game', '2015-05-19', 'CD Projekt Red', 80),
('God of War (2018)', '18+', 'Game', '2018-04-20', 'Santa Monica Studio', 75),
('FIFA 24', '3+', 'Game', '2023-09-29', 'EA Sports', 90),
('Minecraft', '7+', 'Game', '2011-11-18', 'Mojang', 40),
('Red Dead Redemption 2','18+','Game','2018-10-26','Rockstar Games',85),
('Grand Theft Auto V','18+','Game','2013-09-17','Rockstar Games',70),
('Call of Duty: Modern Warfare','18+','Game','2019-10-25','Infinity Ward',75),
('Fortnite','12+','Game','2017-07-21','Epic Games',30),
('Cyberpunk 2077','18+','Game','2020-12-10','CD Projekt Red',65),
('Assassin''s Creed Valhalla','18+','Game','2020-11-10','Ubisoft',70),
('Elden Ring','16+','Game','2022-02-25','FromSoftware',80),
('Horizon Zero Dawn','16+','Game','2017-02-28','Guerrilla Games',60),
('Resident Evil 4 Remake','18+','Game','2023-03-24','Capcom',75),
('Spider-Man: Miles Morales','16+','Game','2020-11-12','Insomniac Games',65);



-- STORE CARDS
INSERT INTO StoreCards (Benefits_Level, Status, Expiration_Date, Customer_ID) VALUES
(1, 1, '2026-12-31', 1),
(2, 1, '2025-10-10', 2),
(3, 0, '2024-08-20', 3),
(2, 1, '2026-05-15', 4);

-- GENRE (Multivalued)
INSERT INTO Genre (Product_ID, Genre) VALUES
(1, 'Sci-Fi'),
(1, 'Thriller'),
(2, 'Drama'),
(3, 'Action');



-- REVENUE (Multivalued)
INSERT INTO Revenue (Store_ID, Year, Store_Revenue) VALUES
(1, 2022, 150000),
(2, 2022, 120000),
(3, 2023, 180000),
(4, 2023, 90000);


-- RENTS (M:N)
INSERT INTO Rents (Customer_ID, Product_ID, Return_by_Date, Late_Fees) VALUES
-- Original realistic base
(1,1,'2026-04-20',0),
(2,2,'2026-04-18',20),
(3,3,'2026-04-22',0),
(4,4,'2026-04-25',10),

-- Movies (IDs 5–34)
(5,5,'2026-05-01',0),
(6,6,'2026-05-02',5),
(7,7,'2026-05-03',0),
(8,8,'2026-05-04',2),
(9,9,'2026-05-05',0),
(10,10,'2026-05-06',3),
(11,11,'2026-05-07',0),
(12,12,'2026-05-08',4),
(13,13,'2026-05-09',0),
(14,14,'2026-05-10',1),

(15,15,'2026-05-11',0),
(16,16,'2026-05-12',2),
(17,17,'2026-05-13',0),
(18,18,'2026-05-14',3),
(19,19,'2026-05-15',0),
(20,20,'2026-05-16',5),
(21,21,'2026-05-17',0),
(22,22,'2026-05-18',2),
(23,23,'2026-05-19',0),
(24,24,'2026-05-20',1),

-- Games (IDs 35–48)
(1,35,'2026-06-01',2),
(2,36,'2026-06-02',0),
(3,37,'2026-06-03',4),
(4,38,'2026-06-04',0),
(5,39,'2026-06-05',3),
(6,40,'2026-06-06',0),
(7,41,'2026-06-07',1),
(8,42,'2026-06-08',0),
(9,43,'2026-06-09',2),
(10,44,'2026-06-10',0);

-- STOCKS (M:N)
INSERT INTO Stocks (Store_ID, Product_ID, InStock, Copies_Borrowed) VALUES
-- Store 1
(1,5,6,2),
(1,10,4,1),
(1,15,3,1),
(1,20,5,2),
(1,25,2,0),
(1,35,4,1),
(1,40,3,1),

-- Store 2
(2,6,5,2),
(2,11,4,1),
(2,16,6,3),
(2,21,3,1),
(2,26,2,0),
(2,36,5,2),
(2,41,4,1),

-- Store 3
(3,7,6,2),
(3,12,3,1),
(3,17,5,2),
(3,22,4,1),
(3,27,3,0),
(3,37,6,3),
(3,42,2,0),

-- Store 4
(4,8,5,2),
(4,13,4,1),
(4,18,3,1),
(4,23,6,2),
(4,28,4,1),
(4,38,5,2),
(4,43,3,1);

-- Updates number of store workers accordingly
UPDATE S
SET No_of_workers = W.WorkerCount
FROM Stores S
JOIN (
    SELECT Store_ID, COUNT(*) AS WorkerCount
    FROM Workers
    GROUP BY Store_ID
) W
ON S.Store_ID = W.Store_ID;
