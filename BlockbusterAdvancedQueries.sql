--------------------------------------------------------------------------------
-- ADVANCED QUERIES
--------------------------------------------------------------------------------

----------------------------------------------------------
-- FILTERING AND SORTING QUERIES
----------------------------------------------------------
-- Retrieves all customers who have fines greater than 0, and sorts them in descending order.
SELECT * 
FROM Customers
WHERE Fines > 0
ORDER BY Fines DESC;

-- Retrieves products released after 2010,and sorts them by price in descending order.
SELECT Title, type, Release_Date, Price
FROM Product
WHERE Release_Date > '2010-01-01'
ORDER BY Price DESC;

-- Retrieves products priced under 50,and sorts them by price in descending order.
SELECT Product_ID, Title, Price 
FROM Product 
WHERE Price < 50 
ORDER BY Price DESC;

-- Retrieves products priced above 50,and sorts them by price in ascending order.
SELECT Product_ID, Title, Price 
FROM Product 
WHERE Price > 50 
ORDER BY Price ASC;

----------------------------------------------------------
-- AGGREGATE QUERIES
----------------------------------------------------------

-- Counts the total number of customers stored in the Customers table.
SELECT COUNT(*) AS Total_Customers
FROM Customers; 

-- Shows store with the most workers vs the store with least workers
SELECT 
    MAX(No_of_workers) AS Largest_Store,
    MIN(No_of_workers) AS Smallest_Store
FROM Stores;

-- Displays the customer with the maximum fines and the customer with the minimum fines
SELECT 
    C.Customer_ID,
    C.First_Name,
    C.last_Name,
    C.Fines,
    CASE 
        WHEN C.Fines = (SELECT MAX(Fines) FROM Customers) THEN 'Highest Fine'
        WHEN C.Fines = (SELECT MIN(Fines) FROM Customers) THEN 'Lowest Fine'
    END AS Fine_Category
FROM Customers C
WHERE C.Fines = (SELECT MAX(Fines) FROM Customers)
   OR C.Fines = (SELECT MIN(Fines) FROM Customers)
ORDER BY C.Fines ASC;

----------------------------------------------------------
-- JOIN QUERY
----------------------------------------------------------
SELECT 
    W.First_Name,
    W.last_Name,
    S.Address,
    R.Year,
    R.Store_Revenue
FROM Workers W
INNER JOIN Stores S
    ON W.Store_ID = S.Store_ID
INNER JOIN Revenue R
    ON S.Store_ID = R.Store_ID;

----------------------------------------------------------
-- NULL HANDLING QUERY
----------------------------------------------------------

-- Retrieves workers whose phone number is missing (NULL)
SELECT Work_SSN, First_Name, last_Name
FROM Workers
WHERE PhoneNo IS NULL;