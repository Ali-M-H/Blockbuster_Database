USE blockbuster;

INSERT INTO Stores (Location, No_of_workers, open_Date) VALUES
('Cairo Downtown', 15, '2018-05-10'),
('Alexandria', 12, '2019-03-22'),
('Giza', 10, '2020-07-15');

INSERT INTO Workers (Name, House_Adress, PhoneNo, Salary, Start_Date, Position, Date_Of_Birth, Gender, Store_ID) VALUES
('Ahmed Ali', 'Nasr City', 1012345678, 5000, '2019-01-10', 'Manager', '1985-06-15', 'M', 1),
('Sara Mohamed', 'Heliopolis', 1023456789, 3500, '2020-02-20', 'Cashier', '1992-09-10', 'F', 1),
('Omar Hassan', 'Maadi', 1034567890, 3200, '2021-06-01', 'Assistant', '1995-12-05', 'M', 2),
('Mona Adel', 'Smouha', 1045678901, 4000, '2019-08-18', 'Supervisor', '1990-04-25', 'F', 2),
('Youssef Tarek', 'Haram', 1056789012, 3000, '2022-03-12', 'Clerk', '1998-11-30', 'M', 3);

INSERT INTO Dependants (Name, Gender, Date_Of_Birth, Work_SSN) VALUES
('Laila Ahmed', 'F', '2010-05-01', 1),
('Karim Ahmed', 'M', '2012-07-12', 1),
('Nour Sara', 'F', '2015-03-20', 2),
('Hassan Omar', 'M', '2018-09-09', 3);

INSERT INTO Customers (Name, PhoneNo, Email, Fines) VALUES
('Ali Mahmoud', '01111111111', 'ali@mail.com', 0),
('Nora Samy', '01222222222', 'nora@mail.com', 50),
('Hassan Fathy', '01033333333', 'hassan@mail.com', 0),
('Mariam Adel', '01544444444', 'mariam@mail.com', 20);

INSERT INTO Product (Title, Age_Rating, Release_Date, Director, Price) VALUES
('Inception', 'PG-13', '2010-07-16', 'Christopher Nolan', 50.00),
('Titanic', 'PG-13', '1997-12-19', 'James Cameron', 40.00),
('The Matrix', 'R', '1999-03-31', 'Wachowski', 45.00),
('Frozen', 'G', '2013-11-27', 'Chris Buck', 35.00);

INSERT INTO StoreCards (Card_Level, Card_Status, Expiration_Date, Customer_ID) VALUES
(3, TRUE, '2026-12-31', 1),
(2, TRUE, '2025-06-30', 2),
(5, TRUE, '2027-01-15', 3),
(1, FALSE, '2024-09-10', 4);

INSERT INTO Genre (Product_ID, Genre) VALUES
(1, 'Sci-Fi'),
(1, 'Action'),
(2, 'Romance'),
(2, 'Drama'),
(3, 'Sci-Fi'),
(3, 'Action'),
(4, 'Animation'),
(4, 'Family');

INSERT INTO Revenue (Store_ID, Year, Store_Revenue) VALUES
(1, 2022, 500000.00),
(1, 2023, 550000.00),
(2, 2022, 400000.00),
(2, 2023, 420000.00),
(3, 2023, 300000.00);

INSERT INTO Rents (Customer_ID, Product_ID, Return_by_Date, Late_Fees) VALUES
(1, 1, '2026-04-15', 0),
(2, 2, '2026-04-10', 10),
(3, 3, '2026-04-20', 0),
(4, 4, '2026-04-12', 5),
(1, 3, '2026-04-18', 0);

INSERT INTO Stocks (Store_ID, Product_ID, InStock, Copies_Borrowed) VALUES
(1, 1, 5, 2),
(1, 2, 3, 1),
(2, 3, 4, 2),
(2, 4, 6, 1),
(3, 1, 2, 1),
(3, 4, 5, 0);
