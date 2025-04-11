create database ecommerce;

use ecommerce;

create table customers (
customer_id int Primary Key,
firstName  varchar(90),
lastname varchar(80),
email  varchar(100),
password varchar(80)
);
alter table customers add address varchar(100);

create table products(
product_id int Primary Key,
name  varchar(100),
price decimal(10,2),
description  varchar(80),
stockQuantity int,
);

create table cart( 
cart_id int Primary Key,
customer_id int Foreign Key references customers(customer_id),
product_id int Foreign Key references products(product_id),
quantity int,
);

create table orders ( 
order_id int Primary Key,
customer_id int Foreign Key references customers(customer_id), 
order_date datetime,
total_price decimal(10,2),
shipping_address varchar(100)
)

create table order_items ( 
order_item_id int Primary Key,
order_id int Foreign Key references orders(order_id),
product_id int Foreign Key references products(product_id),
quantity int
);

insert into customers(customer_id,firstName,lastname,email,password,address) values 
(1,'John',' Doe', 'johndoe@example.com','jon123',' 123 Main St, City '),
(2,'Jane', 'Smith', 'janesmith@example.com ','jane123','456 Elm St, Town'),
(3,'Robert', 'Johnson',' robert@example.com ','robert123','789 Oak St, Village'),
(4,'Sarah', 'Brown', 'sarah@example.com','sarah123',' 101 Pine St, Suburb '),
(5,'David',' Lee',' david@example.com','david123',' 234 Cedar St, District'),
(6,'Laura','Hall' ,'laura@example.com','laura123',' 567 Birch St, County'),
(7,'Michael',' Davis', 'michael@example.com', 'michale123','890 Maple St, State'),
(8, 'Emma',' Wilson', 'emma@example.com','emma123', '321 Redwood St, Country'),
( 9,'William',' Taylor', 'william@example.com', 'william123','432 Spruce St, Province'),
( 10,'Olivia',' Adams', 'olivia@example.com', 'olivia123','765 Fir St, Territory');

insert into products(product_id,name,description,price,stockQuantity)values 
(1, 'Laptop', 'High-performance laptop', 800.00, 10),
(2, 'Smartphone', 'Latest smartphone', 600.00, 15),
(3, 'Tablet', 'Portable tablet', 300.00, 20),
(4, 'Headphones', 'Noise-canceling', 150.00, 30),
(5, 'TV', '4K Smart TV', 900.00, 5),
(6, 'Coffee Maker', 'Automatic coffee maker', 50.00, 25),
(7, 'Refrigerator', 'Energy-efficient', 700.00, 10),
(8, 'Microwave Oven', 'Countertop microwave', 80.00, 15),
(9, 'Blender', 'High-speed blender', 70.00, 20),
(10, 'Vacuum Cleaner', 'Bagless vacuum cleaner', 120.00, 10);


insert into cart(cart_id, customer_id, product_id, quantity) values
(1, 1, 1, 2),
(2, 1, 3, 1),
(3, 2, 2, 3),
(4, 3, 4, 4),
(5, 3, 5, 2),
(6, 4, 6, 1),
(7, 5, 1, 1),
(8, 6, 10, 2),
(9, 6, 9, 3),
(10, 7, 7, 2);

insert into orders(order_id, customer_id, order_date, total_price, shipping_address)values
(1, 1, '2023-01-05', 1200.00, NULL),
(2, 2, '2023-02-10', 900.00, NULL),
(3, 3, '2023-03-15', 300.00, NULL),
(4, 4, '2023-04-20', 150.00, NULL),
(5, 5, '2023-05-25', 1800.00, NULL),
(6, 6, '2023-06-30', 400.00, NULL),
(7, 7, '2023-07-05', 700.00, NULL),
(8, 8, '2023-08-10', 160.00, NULL),
(9, 9, '2023-09-15', 140.00, NULL),
(10, 10, '2023-10-20', 1400.00, NULL);

insert into order_items(order_item_id, order_id, product_id, quantity) values
(1, 1, 1, 2),
(2, 1, 3, 1),
(3, 2, 2, 3),
(4, 3, 5, 2),
(5, 4, 4, 4),
(6, 4, 6, 1),
(7, 5, 1, 1),
(8, 5, 2, 2),
(9, 6, 10, 2),
(10, 6, 9, 3);


------QUESTIONS---

----1.Update refrigerator product price to 800. 

update products set price=800
where product_id=7;

select*from products;

----2.Remove all cart items for a specific customer. 

delete from cart where customer_id=4;

select*from cart;

----3.Retrieve Products Priced Below $100. 

select* from products where price<100;

----4.Find Products with Stock Quantity Greater Than 5. 

select *from products where stockQuantity>5;

----5.Retrieve Orders with Total Amount Between $500 and $1000.

select *from orders where  total_price between 500 and 1000;

---6.Find Products which name end with letter ‘r’.

select * from products where name  LIKE '%r';

----7.Retrieve Cart Items for Customer 5. 

select *from cart where customer_id=5;

----8.Find Customers Who Placed Orders in 2023. 

select distinct c.*from  customers c
join orders o on c.customer_id = o.customer_id
where year(o.order_date) = 2023;

---9.Determine the Minimum Stock Quantity for Each Product Category. 

select name, min(stockQuantity) as min_stock from products group by name;

---10.Calculate the Total Amount Spent by Each Customer. 

select  o.customer_id, sum(oi.quantity * p.price) as total_spent
from orders o
join order_items oi on o.order_id = oi.order_id
join products p on oi.product_id = p.product_id
group by o.customer_id;

---11.Find the Average Order Amount for Each Customer. 

select  customer_id, avg(total_price) as average_spent
from orders 
group by customer_id;


----12.Count the Number of Orders Placed by Each Customer.

select customer_id,count(*) as order_count
from orders
group by customer_id;

----13.Find the Maximum Order Amount for Each Customer. 

select  customer_id, max(total_price) as maximum_spent
from orders 
group by customer_id;

----14.Get Customers Who Placed Orders Totaling Over $1000. 

select customer_id, sum(total_price) as total_order_amount
from orders
group by customer_id
having sum(total_price) > 1000;

----15.Subquery to Find Products Not in the Cart.

select * from products
where product_id not in (select distinct product_id from cart);

---16.Subquery to Find Customers Who Haven't Placed Orders. 

select * from customers
where customer_id not in (select distinct customer_id from orders);


---17. Subquery to Calculate the Percentage of Total Revenue for a Product.

select p.name, (sum(oi.quantity * p.price) / 
(select sum(quantity * price) from order_items oi2 join products p2 on oi2.product_id = p2.product_id) * 100) as revenue_percentage
from order_items oi
join products p on oi.product_id = p.product_id
group by p.name;

----18. Subquery to Find Products with Low Stock. 

select* from products where stockQuantity < 5;

---19.Subquery to Find Customers Who Placed High-Value Orders.

select distinct customer_id
from orders
where total_price > 1000;

