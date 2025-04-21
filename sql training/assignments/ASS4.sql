CREATE DATABASE COURIER;
USE COURIER

CREATE TABLE Users (
    UserID INT PRIMARY KEY,
    Name VARCHAR(255),
    Email VARCHAR(255) UNIQUE,
    Password VARCHAR(255),
    ContactNumber VARCHAR(20),
    Address TEXT
);

CREATE TABLE Courier (
    CourierID INT PRIMARY KEY,
    SenderName VARCHAR(255),
    SenderAddress TEXT,
    ReceiverName VARCHAR(255),
    ReceiverAddress TEXT,
    Weight DECIMAL(5, 2),
    Status VARCHAR(50),
    TrackingNumber VARCHAR(20) UNIQUE,
    DeliveryDate DATE
);

CREATE TABLE CourierServices (
    ServiceID INT PRIMARY KEY,
    ServiceName VARCHAR(100),
    Cost DECIMAL(8, 2)
);

CREATE TABLE Employee (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(255),
    Email VARCHAR(255) UNIQUE,
    ContactNumber VARCHAR(20),
    Role VARCHAR(50),
    Salary DECIMAL(10, 2)
);

CREATE TABLE Location (
    LocationID INT PRIMARY KEY,
    LocationName VARCHAR(100),
    Address TEXT
);

CREATE TABLE Payment (
    PaymentID INT PRIMARY KEY,
    CourierID INT,
    LocationID INT,
    Amount DECIMAL(10, 2),
    PaymentDate DATE,
    FOREIGN KEY (CourierID) REFERENCES Courier(CourierID),
    FOREIGN KEY (LocationID) REFERENCES Location(LocationID)
);


INSERT INTO Users (UserID, Name, Email, Password, ContactNumber, Address) VALUES
(1, 'John Doe', 'john@example.com', 'john123', '1234567890', '123 Main St, City A'),
(2, 'Alice Smith', 'alice@example.com', 'alice456', '9876543210', '456 Park Ave, City B'),
(3, 'Bob Johnson', 'bob@example.com', 'bob789', '1122334455', '789 Elm Rd, City C');

INSERT INTO Courier (CourierID, SenderName, SenderAddress, ReceiverName, ReceiverAddress, Weight, Status, TrackingNumber, DeliveryDate) VALUES
(101, 'John Doe', '123 Main St, City A', 'Alice Smith', '456 Park Ave, City B', 2.5, 'Delivered', 'TRK001', '2025-04-19'),
(102, 'Alice Smith', '456 Park Ave, City B', 'Bob Johnson', '789 Elm Rd, City C', 4.0, 'In Transit', 'TRK002', '2025-04-22'),
(103, 'John Doe', '123 Main St, City A', 'Bob Johnson', '789 Elm Rd, City C', 3.2, 'Pending', 'TRK003', '2025-04-25');

INSERT INTO CourierServices (ServiceID, ServiceName, Cost) VALUES
(1, 'Standard Delivery', 50.00),
(2, 'Express Delivery', 100.00),
(3, 'Overnight Delivery', 150.00);

INSERT INTO Employee (EmployeeID, Name, Email, ContactNumber, Role, Salary) VALUES
(1, 'Emily Watson', 'emily@example.com', '5551112222', 'Delivery Agent', 30000),
(2, 'Daniel Craig', 'daniel@example.com', '5553334444', 'Manager', 60000),
(3, 'Sara Ali', 'sara@example.com', '5555556666', 'Delivery Agent', 32000);

INSERT INTO Location (LocationID, LocationName, Address) VALUES
(1, 'City A Hub', '123 Main St, City A'),
(2, 'City B Hub', '456 Park Ave, City B'),
(3, 'City C Hub', '789 Elm Rd, City C');

INSERT INTO Payment (PaymentID, CourierID, LocationID, Amount, PaymentDate) VALUES
(1, 101, 1, 50.00, '2025-04-19'),
(2, 102, 2, 100.00, '2025-04-20'),
(3, 103, 1, 75.00, '2025-04-21');


-----TASK 2----
-- 1. List all customers
SELECT * FROM Users;

-- 2. List all orders for a specific customer
SELECT * FROM Courier WHERE SenderName = 'John Doe';

-- 3. List all couriers
SELECT * FROM Courier;

-- 4. List all packages for a specific order (assuming CourierID represents an order)
SELECT * FROM Courier WHERE CourierID = 101;

-- 5. List all deliveries for a specific courier
SELECT * FROM Courier WHERE CourierID = 101;

-- 6. List all undelivered packages
SELECT * FROM Courier WHERE Status != 'Delivered';

-- 7. List all packages scheduled for delivery today
SELECT * FROM Courier WHERE DeliveryDate = CAST(GETDATE() AS DATE);

-- 8. List all packages with a specific status
SELECT * FROM Courier WHERE Status = 'In Transit';

-- 9. Calculate the total number of packages for each courier
SELECT CourierID, COUNT(*) AS TotalPackages FROM Courier GROUP BY CourierID;



-- 11. List all packages with a specific weight range
SELECT * FROM Courier WHERE Weight BETWEEN 2.0 AND 5.0;

-- 12. Retrieve employees whose names contain 'John'
SELECT * FROM Employee WHERE Name LIKE '%John%';

-- 13. Retrieve courier records with payments greater than $50
SELECT * FROM Payment WHERE Amount > 50;


----TASK3---
-- 14. Total couriers handled by each employeeRequires a relation between Employee and Courier (not in schema)Assuming you have EmployeeID in Courier table:
SELECT EmployeeID, COUNT(*) FROM Courier GROUP BY EmployeeID;

-- 15. Total revenue by each location
SELECT LocationID, SUM(Amount) AS TotalRevenue
FROM Payment
GROUP BY LocationID;

-- 16. Total couriers delivered to each locationAssuming DeliveryLocation in Courier table:
SELECT DeliveryLocationID, COUNT(*) FROM Courier GROUP BY DeliveryLocationID;


-- 18. Locations with total payments < X
SELECT LocationID, SUM(Amount) AS TotalAmount
FROM Payment
GROUP BY LocationID
HAVING SUM(Amount) < 1000;

-- 19. Total payments per location
SELECT LocationID, SUM(Amount) AS TotalAmount
FROM Payment
GROUP BY LocationID;

-- 20. Couriers with payments > $1000 in a specific location
SELECT CourierID
FROM Payment
WHERE LocationID = 1
GROUP BY CourierID
HAVING SUM(Amount) > 1000;

-- 21. Payments > $1000 after a certain date
SELECT CourierID
FROM Payment
WHERE PaymentDate > '2024-01-01'
GROUP BY CourierID
HAVING SUM(Amount) > 1000;

-- 22. Locations with total > $5000 before a certain date
SELECT LocationID, SUM(Amount) AS TotalAmount
FROM Payment
WHERE PaymentDate < '2024-01-01'
GROUP BY LocationID
HAVING SUM(Amount) > 5000;

-----TASK4---------------

-- 23. Payments with courier info
SELECT P.*, C.*
FROM Payment P
INNER JOIN Courier C ON P.CourierID = C.CourierID;

-- 24. Payments with location info
SELECT P.*, L.*
FROM Payment P
INNER JOIN Location L ON P.LocationID = L.LocationID;

-- 25. Payments with courier and location info
SELECT P.*, C.*, L.*
FROM Payment P
INNER JOIN Courier C ON P.CourierID = C.CourierID
INNER JOIN Location L ON P.LocationID = L.LocationID;

-- 26. All payments with courier details
SELECT P.*, C.*
FROM Payment P
INNER JOIN Courier C ON P.CourierID = C.CourierID;


-- 27. Total payments received for each courier
SELECT CourierID, SUM(Amount) AS TotalPayment
FROM Payment
GROUP BY CourierID;

-- 28. Payments made on a specific date
SELECT * FROM Payment WHERE PaymentDate = '2024-04-01';

-- 29. Courier info for each payment
SELECT P.*, C.*
FROM Payment P
INNER JOIN Courier C ON P.CourierID = C.CourierID;

-- 30. Payment details with location
SELECT P.*, L.*
FROM Payment P
INNER JOIN Location L ON P.LocationID = L.LocationID;



-- 32. Payments within a date range
SELECT * FROM Payment
WHERE PaymentDate BETWEEN '2024-01-01' AND '2024-04-01';

-- 33. All users and courier records (FULL JOIN)
SELECT U.*, C.*
FROM Users U
FULL OUTER JOIN Courier C ON U.Name = C.SenderName;


-- 36. All users and courier services (CROSS JOIN)
SELECT U.Name, S.ServiceName
FROM Users U
CROSS JOIN CourierServices S;

-- 37. Employees and locations (CROSS JOIN)
SELECT E.Name, L.LocationName
FROM Employee E
CROSS JOIN Location L;

-- 38. Couriers with sender info (SenderName)
SELECT * FROM Courier WHERE SenderName IS NOT NULL;

-- 39. Couriers with receiver info
SELECT * FROM Courier WHERE ReceiverName IS NOT NULL;


-- 42. Locations and total payment received
SELECT LocationID, SUM(Amount) AS TotalAmount
FROM Payment
GROUP BY LocationID;

-- 43. All couriers sent by same sender
SELECT * FROM Courier WHERE SenderName = 'John Doe';

-- 44. Employees with same role
SELECT * FROM Employee WHERE Role IN (
    SELECT Role FROM Employee GROUP BY Role HAVING COUNT(*) > 1
);


-- 46. Couriers from same sender address
SELECT * FROM Courier
WHERE SenderAddress IN (
    SELECT SenderAddress
    FROM Courier
    GROUP BY SenderAddress
    HAVING COUNT(*) > 1
);

