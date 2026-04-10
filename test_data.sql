INSERT INTO Stores (Address, No_of_workers, open_Date) VALUES
('123 Main St, Cairo', 12, '2015-06-01'),
('45 Nile Ave, Giza', 9, '2017-08-15'),
('78 Alexandria Rd, Alexandria', 15, '2014-03-10'),
('22 Tahrir Sq, Cairo', 7, '2019-11-20'),
('10 Canal St, Ismailia', 6, '2020-05-05');

INSERT INTO Workers (First_Name, last_Name, House_Address, PhoneNo, Salary, Start_Date, Position, Date_Of_Birth, Gender, Store_ID) VALUES
('Ahmed', 'Hassan', 'Nasr City', 111111111, 6000, '2018-01-10', 'Manager', '1985-05-12', 'M', 1),
('Sara', 'Ali', 'Maadi', 222222222, 3500, '2021-03-20', 'Cashier', '1995-08-25', 'F', 1),
('Omar', 'Khaled', 'Dokki', 333333333, 5000, '2017-09-01', 'Manager', '1988-02-14', 'M', 2),
('Nour', 'Ibrahim', 'Giza', 444444444, 3200, '2022-06-12', 'Clerk', '1998-12-01', 'F', 2),
('Youssef', 'Samir', 'Alexandria', 555555555, 6500, '2016-04-18', 'Manager', '1983-07-22', 'M', 3),
('Mona', 'Fathy', 'Smouha', 666666666, 3400, '2020-10-05', 'Cashier', '1996-09-30', 'F', 3),
('Karim', 'Adel', 'Downtown', 777777777, 4800, '2019-12-01', 'Supervisor', '1991-11-11', 'M', 4),
('Huda', 'Mostafa', 'Ismailia', 888888888, 4500, '2021-07-07', 'Manager', '1990-03-03', 'F', 5);

INSERT INTO Dependants (First_Name, last_Name, Gender, Date_Of_Birth, Work_SSN) VALUES
('Lina', 'Hassan', 'F', '2010-07-10', 1),
('Adam', 'Ali', 'M', '2014-05-05', 2),
('Salma', 'Khaled', 'F', '2012-01-20', 3),
('Tarek', 'Samir', 'M', '2008-09-09', 5);

INSERT INTO Customers (First_Name, last_Name, PhoneNo, Email, Fines) VALUES
('Mona', 'Adel', '01011111111', 'mona@email.com', 0),
('Ali', 'Mahmoud', '01022222222', 'ali@email.com', 10),
('Salma', 'Hesham', '01033333333', 'salma@email.com', 5),
('Omar', 'Nabil', '01044444444', 'omar@email.com', 0),
('Nada', 'Tarek', '01055555555', 'nada@email.com', 2);

INSERT INTO StoreCards (Benefits_Level, Status, Expiration_Date, Customer_ID) VALUES
(3, TRUE, '2026-12-31', 1),
(2, TRUE, '2025-10-10', 2),
(5, TRUE, '2027-01-01', 3),
(1, FALSE, '2024-05-05', 4),
(4, TRUE, '2026-06-06', 5);

INSERT INTO Product (Title, Age_Rating, Release_Date, Director, Price, Type) VALUES
-- Movies
('Inception', 'PG-13', '2010-07-16', 'Christopher Nolan', 50.00, 'Movie'),
('The Matrix', 'R', '1999-03-31', 'Wachowski', 45.00, 'Movie'),
('Titanic', 'PG-13', '1997-12-19', 'James Cameron', 40.00, 'Movie'),
('Avengers: Endgame', 'PG-13', '2019-04-26', 'Russo Brothers', 60.00, 'Movie'),
-- Video Games
('The Last of Us', '18+', '2013-06-14', 'Naughty Dog', 70.00, 'Video Game'),
('FIFA 23', 'E', '2022-09-30', 'EA Sports', 65.00, 'Video Game'),
('Call of Duty: Modern Warfare', '18+', '2019-10-25', 'Infinity Ward', 75.00, 'Video Game'),
('Minecraft', 'E', '2011-11-18', 'Mojang', 55.00, 'Video Game');

INSERT INTO Genre (Product_ID, Genre) VALUES
-- Movies
(1, 'Sci-Fi'), (1, 'Action'),
(2, 'Sci-Fi'), (2, 'Action'),
(3, 'Romance'), (3, 'Drama'),
(4, 'Action'),
-- Video Games
(5, 'Adventure'), (5, 'Survival'),
(6, 'Sports'),
(7, 'Shooter'),
(8, 'Sandbox');

INSERT INTO Revenue (Store_ID, Year, Store_Revenue) VALUES
(1, 2023, 150000),
(2, 2023, 120000),
(3, 2023, 200000),
(4, 2023, 90000),
(5, 2023, 80000);

INSERT INTO Stocks (Store_ID, Product_ID, InStock, Copies_Borrowed) VALUES
(1, 1, 10, 2),
(1, 2, 8, 1),
(2, 3, 12, 3),
(2, 4, 6, 2),
(3, 1, 15, 5),
(3, 5, 10, 4),
(4, 2, 7, 1),
(5, 3, 9, 2);

INSERT INTO Rents (Customer_ID, Product_ID, Return_by_Date, Late_Fees) VALUES
(1, 1, '2026-04-15', 0),
(2, 2, '2026-04-12', 5),
(3, 3, '2026-04-20', 0),
(4, 4, '2026-04-18', 2),
(5, 5, '2026-04-25', 0);
