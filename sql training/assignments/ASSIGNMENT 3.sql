create database TechShop;
go

use TechShop;
go


create table Customers (
    CustomerID int primary key identity (1,1),
    FirstName varchar(50),
    LastName varchar(50),
    Email varchar(100),
    Phone varchar(20),
    Address varchar(200)
);


create table Products (
    ProductID int primary key identity (1,1),
    ProductName varchar(100),
    Description varchar(255),
    Price decimal(10,2)
);


create table Orders (
    OrderID int primary key identity(1,1),
    CustomerID int foreign key references Customers(CustomerID),
    OrderDate date,
    TotalAmount decimal(10,2)
);


create table OrderDetails (
    OrderDetailID int primary key identity(1,1),
    OrderID int foreign key references Orders(OrderID),
    ProductID int foreign key references Products(ProductID),
    Quantity int
);


create table Inventory (
    InventoryID int primary key identity(1,1),
    ProductID int foreign key references Products(ProductID),
    QuantityInStock int,
    LastStockUpdate date
);


insert into Customers (FirstName, LastName, Email, Phone, Address)
values 
('John', 'Doe', 'john@example.com', '1234567890', '123 Elm Street'),
('Jane', 'Smith', 'jane@example.com', '2345678901', '456 Oak Street'),
('Mike', 'Johnson', 'mikej@example.com', '3456789012', '789 Pine Street'),
('Emily', 'Clark', 'emilyc@example.com', '4567890123', '101 Maple Ave'),
('Daniel', 'Lee', 'daniel@example.com', '5678901234', '202 Birch Blvd'),
('Sarah', 'Davis', 'sarah@example.com', '6789012345', '303 Cedar Lane'),
('Chris', 'Brown', 'chrisb@example.com', '7890123456', '404 Willow Way'),
('Anna', 'Wilson', 'annaw@example.com', '8901234567', '505 Poplar Dr'),
('David', 'Miller', 'davidm@example.com', '9012345678', '606 Fir Rd'),
('Linda', 'Taylor', 'lindat@example.com', '0123456789', '707 Spruce Ct');

insert into Products (ProductName, Description, Price)
values 
('Smartphone', 'Latest Android smartphone', 500.00),
('Laptop', 'High-performance laptop', 1200.00),
('Smartwatch', 'Water-resistant smartwatch', 200.00),
('Tablet', '10-inch tablet', 350.00),
('Headphones', 'Noise-canceling headphones', 150.00),
('Camera', 'DSLR camera', 800.00),
('Printer', 'Color inkjet printer', 100.00),
('Keyboard', 'Mechanical keyboard', 80.00),
('Monitor', '24-inch monitor', 250.00),
('Router', 'Dual-band WiFi router', 70.00);


insert into Orders (CustomerID, OrderDate, TotalAmount)
values
(1, '2025-04-01', 750.00),
(2, '2025-04-02', 1300.00),
(3, '2025-04-03', 350.00),
(4, '2025-04-04', 150.00),
(5, '2025-04-05', 800.00),
(6, '2025-04-06', 180.00),
(7, '2025-04-07', 250.00),
(8, '2025-04-08', 700.00),
(9, '2025-04-09', 120.00),
(10, '2025-04-10', 270.00);

insert into OrderDetails (OrderID, ProductID, Quantity)
values
(1, 1, 1), (1, 5, 1),
(2, 2, 1), (2, 4, 1),
(3, 4, 1),
(4, 5, 1),
(5, 6, 1),
(6, 8, 2),
(7, 9, 1),
(8, 3, 1), (8, 5, 1),
(9, 10, 1),
(10, 7, 1), (10, 8, 1);


insert into Inventory (ProductID, QuantityInStock, LastStockUpdate)
values
(1, 10, '2025-03-30'),
(2, 8, '2025-03-29'),
(3, 15, '2025-03-28'),
(4, 12, '2025-03-27'),
(5, 20, '2025-03-26'),
(6, 5, '2025-03-25'),
(7, 9, '2025-03-24'),
(8, 13, '2025-03-23'),
(9, 6, '2025-03-22'),
(10, 11, '2025-03-21');

------------TASK 2------

-------1.Write an SQL query to retrieve the names and emails of all customers. 
select FirstName, LastName, Email from Customers;

---2.Write an SQL query to list all orders with their order dates and corresponding customer names. 

select  O.OrderID, O.OrderDate, C.FirstName, C.LastName
from Orders O
join Customers C on O.CustomerID = C.CustomerID;

----3.Write an SQL query to insert a new customer record into the "Customers" table. Include customer information such as name, email, and address.

insert into Customers(FirstName,LastName,Email,Address) values('raja','ram','rajram@gmail.com','chennai');

----4.Write an SQL query to update the prices of all electronic gadgets in the "Products" table by increasing them by 10%.
update Products set Price=Price*1.10;

-----5.Write an SQL query to delete a specific order and its associated order details from the "Orders" and "OrderDetails" tables. Allow users to input the order ID as a parameter. 

DECLARE @OrderID INT = 1;

delete from OrderDetails where OrderID = @OrderID;
delete from  Orders where OrderID = @OrderID;

----6.Write an SQL query to insert a new order into the "Orders" table. Include the customer ID, order date, and any other necessary information.

insert into Orders (CustomerID, OrderDate, TotalAmount)
values(11, '2025-07-10', 2700.00);

----7.Write an SQL query to update the contact information (e.g., email and address) of a specific customer in the "Customers" table. Allow users to input the customer ID and new contact information.

update Customers set Email='happy@gmail.com',Address='mumbai' where CustomerID=3;

-----8.Write an SQL query to recalculate and update the total cost of each order in the "Orders" table based on the prices and quantities in the "OrderDetails" table. 

update Orders
set TotalAmount = (
    select sum(OD.Quantity * P.Price)
   from OrderDetails OD
    join Products P on OD.ProductID = P.ProductID
   where OD.OrderID = Orders.OrderID
);

----9.Write an SQL query to delete all orders and their associated order details for a specific customer from the "Orders" and "OrderDetails" tables. Allow users to input the customer ID as a parameter.

DECLARE @CustomerID int = 4;

delete from OrderDetails
where OrderID IN (select OrderID from Orders where CustomerID = @CustomerID);

delete from Orders
where CustomerID = @CustomerID;

----10.Write an SQL query to insert a new electronic gadget product into the "Products" table, including product name, category, price, and any other relevant details. 

insert into Products (ProductName, Description, Price)
values ('Smartphone', 'Latest Android smartphone', 5000.00);

----11. Write an SQL query to update the status of a specific order in the "Orders" table (e.g., from "Pending" to "Shipped"). Allow users to input the order ID and the new status. 

alter table Orders add Status varchar(20) default 'Pending';

DECLARE @OrderID INT = 2;
update Orders
set Status = 'Shipped'
where OrderID = @OrderID;

----12.Write an SQL query to calculate and update the number of orders placed by each customer in the "Customers" table based on the data in the "Orders" table.

alter table  Customers add OrderCount int default 0;


update Customers
set OrderCount = (
    select count(*) from Orders
    where Orders.CustomerID = Customers.CustomerID
);

-----TASK 3-------

----1.Write an SQL query to retrieve a list of all orders along with customer information (e.g., customer name) for each order. 

select O.OrderID, O.OrderDate, C.FirstName, C.LastName, C.Email
from Orders O
join Customers C on O.CustomerID = C.CustomerID;

----2.Write an SQL query to find the total revenue generated by each electronic gadget product. Include the product name and the total revenue. 

select P.ProductName, sum(OD.Quantity*P.Price) as total_revenue from OrderDetails OD
join Products P on OD.ProductID = P.ProductID
group by P.ProductName

----3.Write an SQL query to list all customers who have made at least one purchase. Include their names and contact information. 

select distinct C.FirstName, C.LastName, C.Email, C.Phone
from Customers C
join Orders O on C.CustomerID = O.CustomerID;

----4.Write an SQL query to find the most popular electronic gadget, which is the one with the highest total quantity ordered. Include the product name and the total quantity ordered.

select top  1 P.ProductName, SUM(OD.Quantity) AS TotalQuantityOrdered
from OrderDetails OD
join Products P ON OD.ProductID = P.ProductID
group by P.ProductName
order by  TotalQuantityOrdered desc;


---5.Write an SQL query to retrieve a list of electronic gadgets along with their corresponding categories. 

alter table Products add  Category varchar(50);

update Products set Category = 'Electronics';

select ProductName, Category
from Products;

---6.. Write an SQL query to calculate the average order value for each customer. Include the customer's name and their average order value. 
select C.FirstName, C.LastName, avg(O.TotalAmount) as AvgOrderValue
from Customers C
join Orders O on C.CustomerID = O.CustomerID
group by C.FirstName, C.LastName;


----7. Write an SQL query to find the order with the highest total revenue. Include the order ID, customer information, and the total revenue. 

select top 1 O.OrderID, C.FirstName, C.LastName, O.TotalAmount
FROM Orders O
join Customers C ON O.CustomerID = C.CustomerID
order by  O.TotalAmount desc;

---8. Write an SQL query to list electronic gadgets and the number of times each product has been ordered. 
select P.ProductName, count (OD.OrderDetailID) as TimesOrdered
from OrderDetails OD
join Products P ON OD.ProductID = P.ProductID
group by P.ProductName;

--9. Write an SQL query to find customers who have purchased a specific electronic gadget product. Allow users to input the product name as a parameter. 

DECLARE @ProductName varchar(100) = 'Smartphone';

select distinct C.FirstName, C.LastName, C.Email
from Customers C
join Orders O on C.CustomerID = O.CustomerID
join OrderDetails OD on O.OrderID = OD.OrderID
join Products P on OD.ProductID = P.ProductID
where P.ProductName = @ProductName;

--10. Write an SQL query to calculate the total revenue generated by all orders placed within a specific time period. Allow users to input the start and end dates as parameters. 

DECLARE @StartDate DATE = '2025-04-01';
DECLARE @EndDate DATE = '2025-04-10';

select sum(O.TotalAmount) as TotalRevenue
from Orders O
where O.OrderDate BETWEEN @StartDate AND @EndDate;


-----TASK 4---

---1. Write an SQL query to find out which customers have not placed any orders. 

SELECT FirstName, LastName, Email
FROM Customers
WHERE CustomerID NOT IN (
    SELECT CustomerID FROM Orders
);

--2. Write an SQL query to find the total number of products available for sale. 

SELECT COUNT(*) AS TotalProducts
FROM Products;

---3. Write an SQL query to calculate the total revenue generated by TechShop.  

select sum(TotalAmount) as TotalRevenue
from Orders;

--4. Write an SQL query to calculate the average quantity ordered for products in a specific category. Allow users to input the category name as a parameter.

DECLARE @Category varchar(50) = 'Electronics';

select avg(OD.Quantity) as AvgQuantityOrdered
from OrderDetails OD
join Products P on OD.ProductID = P.ProductID
where P.Category = @Category;	

--5. Write an SQL query to calculate the total revenue generated by a specific customer. Allow users to input the customer ID as a parameter. 

DECLARE @CustomerID INT = 2;

select SUM(TotalAmount) AS CustomerRevenue
from Orders
where CustomerID = @CustomerID;

--6. Write an SQL query to find the customers who have placed the most orders. List their names and the number of orders they've placed. 
select top 1 C.FirstName, C.LastName, count(O.OrderID) as OrderCount
from  Customers C
join Orders O on C.CustomerID = O.CustomerID
group by C.FirstName, C.LastName
order by OrderCount desc;

--7. Write an SQL query to find the most popular product category, which is the one with the highest total quantity ordered across all orders. 

select top 1 P.Category, sum(OD.Quantity) as TotalQuantity
from OrderDetails OD
join Products P ON OD.ProductID = P.ProductID
group by P.Category
order by TotalQuantity desc;

--8. Write an SQL query to find the customer who has spent the most money (highest total revenue) on electronic gadgets. List their name and total spending. 

--9. Write an SQL query to calculate the average order value (total revenue divided by the number of orders) for all customers.
select avg(TotalAmount) as AvgOrderValue
from Orders;

--10.Find the total number of orders placed by each customer with names

select C.FirstName, C.LastName, count(O.OrderID) as OrderCount
from Customers C
left join Orders O on C.CustomerID = O.CustomerID
group by C.FirstName, C.LastName;

