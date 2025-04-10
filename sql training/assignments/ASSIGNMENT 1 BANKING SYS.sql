create database HMBank1;
go
use HMBank1;

create table Customers(
    customer_id int primary key identity(1,1),
    first_name varchar(50),
    last_name varchar(50),
    DOB date,
    email varchar(100),
    phone_number varchar(20),
    address varchar(255)
);
create table Accounts (
    account_id int primary key identity(1001,1),
    customer_id int foreign key references Customers(customer_id),
    account_type varchar(50),
    balance decimal(18,2)
);

CREATE TABLE Transactions (
    transaction_id int primary key identity(1,1),
    account_id  int foreign key references Accounts(account_id),
    transaction_type varchar(50), -- deposit, withdrawal, transfer
    amount decimal(18,2),
    transaction_date datetime default GETDATE()
);

---TASK2--
insert into Customers (first_name, last_name, DOB, email, phone_number, address)
values 
('yuva','shri','2002-10-11','yuvas@gmail.com','90876549','chennai'),
('John', 'Doe', '1985-01-01', 'john@gamil.com', '1234567890', 'Chennai'),
('Jane', 'Smith', '1990-03-15', 'jane@gmail.com', '9876543210', 'Bangalore'),
('selvi','meena','1972-10-11','meena11@gmail.com','839939829','Mumbai'),
('vaish','suri','2002-09-28','scvaish@gmail.com','999367729','Dehli'),
('viswa','ram','1999-11-11','viswa28@gmail.com','90997649','chennai'),
('yuva','shri','2001-10-11','yuvas@gmail.com','90855369','mumbai'),
('sai','shri','2000-10-03','sai02@gmail.com','90228189','kolkata'),
('sir','varsha','2002-10-11','srivars@gmail.com','90286549','kerala'),
('yuva','sai','1998-10-11','yuvasai88@gmail.com','67996r549','chennai')

insert into Accounts (customer_id, account_type, balance)
values 
(1, 'savings', 1500.00),
(2, 'current', 2000.00),
(3, 'savings', 1100.00),
(4, 'current', 2500.00),
(5, 'savings', 3500.00),
(6, 'current', 2000.00),
(7, 'savings', 500.00),
(8, 'current', 2200.00),
(9, 'current', 5000.00),
(10, 'savings', 1500.00)



insert into Transactions (account_id, transaction_type, amount)
values 
(1001, 'deposit', 50000.00),
(1002, 'withdrawal', 2000.00),
(1003, 'deposit', 1500.00),
(1004, 'withdrawal',2200.00),
(1005, 'deposit', 300.00),
(1006, 'withdrawal', 2800.00),
(1007, 'withdrawal', 7000.00),
(1008, 'deposit', 5500.00),
(1009, 'withdrawal', 2500.00),
(1010, 'deposit', 1000.00)


----2.Write a SQL query to retrieve the name, account type and email of all customers. 

select c.first_name, c.last_name, a.account_type, c.email
from Customers c
join Accounts a on c.customer_id = a.customer_id;

----3.Write a SQL query to list all transaction corresponding customer. 
select t.*, c.first_name, c.last_name
from Transactions t
join Accounts a on t.account_id = a.account_id
join  Customers c on a.customer_id = c.customer_id;



-----4.Write a SQL query to increase the balance of a specific account by a certain amount.
update Accounts
set balance = balance + 1000
where account_id = 1001;

--------5.Write a SQL query to Combine first and last names of customers as a full_name.
select concat(first_name, ' ', last_name) as full_name from Customers;

----6.Write a SQL query to remove accounts with a balance of zero where the account type is savings. 
delete from Accounts
where balance = 0 and account_type = 'savings';

-------7.Write a SQL query to Find customers living in a specific city. 
select * from Customers where address LIKE '%Chennai%';

----8.Write a SQL query to Get the account balance for a specific account. 
select balance from Accounts where account_id = 1001;

--------9.Write a SQL query to List all current accounts with a balance greater than 1,000. 
select* from Accounts where account_type = 'current' and balance > 1000;

--------10-Write a SQL query to Retrieve all transactions for a specific account. 

select * from Transactions where account_id = 1001;

-----11.Write a SQL query to Calculate the interest accrued on savings accounts based on a given interest rate. 

select account_id, balance * 0.04 as interest
from Accounts
where account_type = 'savings';

-----------12.Write a SQL query to Identify accounts where the balance is less than a specified overdraft limit. 

select * from Accounts where balance < 500;

---------13. Write a SQL query to Find customers not living in a specific city.
select * from Customers where address not like '%Chennai%';


------TASK3-----

--1.  Write a SQL query to Find the average account balance for all customers.   
select avg(balance) as avg_balance from Accounts;

----2.Write a SQL query to Retrieve the top 10 highest account balances. 
select top 10 * from Accounts order by balance desc;

---------3.write a SQL query to Calculate Total Deposits for All Customers in specific date. 

select  sum(amount) as total_deposits
from Transactions
where transaction_type = 'deposit' and CAST(transaction_date AS DATE) = '2025-04-08';

-----4.Write a SQL query to Find the Oldest and Newest Customers. 

select top 1 * from Customers order by DOB asc;

select top 1 * from Customers order by DOB desc; 

---5.Write a SQL query to Retrieve transaction details along with the account type. 
select t.*, a.account_type
from Transactions t
join Accounts a on t.account_id = a.account_id;

---6.-Write a SQL query to Get a list of customers along with their account details. 
select  c.*, a.account_type, a.balance
from Customers c
join Accounts a on c.customer_id = a.customer_id;

----7.Write a SQL query to Retrieve transaction details along with customer information for a specific account.

select  t.*, c.first_name, c.last_name
from Transactions t
join Accounts a on t.account_id = a.account_id
join  Customers c on a.customer_id = c.customer_id
where t.account_id = 1001;

---8.Write a SQL query to Identify customers who have more than one account. 

select customer_id, count(*) as account_count
from Accounts
group by customer_id
having  count(*) > 1;

---9.Write a SQL query to Calculate the difference in transaction amounts between deposits and withdrawals. 

select
    sum(case when transaction_type = 'deposit'then amount else 0 end) -
    sum(case when transaction_type = 'withdrawal' then  amount else 0 end) as net_difference
from Transactions;



-------10.. Calculate the total balance for each account type. 
select 
    account_type, 
    sum(balance) AS total_balance 
from 
    Accounts
group by 
    account_type;

----11.dentify accounts with the highest number of transactions order by descending order. 

select
    a.account_id,
    count(t.transaction_id) as transaction_count
from
    Accounts a
join Transactions t on a.account_id = t.account_id
group by
    a.account_id
order by 
    transaction_count desc;

--------TASK 4 SUB QUERY--
-----1.Retrieve the customer(s) with the highest account balance.
select * 
from Customers 
where customer_id IN (
    select customer_id 
    from Accounts 
    where balance = (select max(balance) from Accounts)
);
----2.Calculate the average account balance for customers who have more than one account. 

select avg(balance) as avg_balance
from Accounts
where customer_id IN (
    select customer_id
   from Accounts
    group by customer_id
    having count(account_id) > 1
);

--------3.Retrieve accounts with transactions whose amounts exceed the average transaction amount. 

select distinct account_id 
from Transactions 
where amount > (
    select avg(amount) from Transactions
);

---------4.Identify customers who have no recorded transactions. 
select * 
from Customers 
where customer_id NOT IN (
    select distinct a.customer_id
    from Accounts a
    join Transactions t on a.account_id = t.account_id
);

-----------5.Calculate the total balance of accounts with no recorded transactions.
select sum(balance) AS total_balance
from Accounts
where account_id NOT IN (
    select distinct account_id from Transactions
);

-----6. Retrieve transactions for accounts with the lowest balance.
select * 
from Transactions 
where account_id in (
    select account_id 
    from Accounts 
   where balance = (select min(balance) from Accounts)
);

-----7.Identify customers who have accounts of multiple types. 
select customer_id
from Accounts
group  by customer_id
having count(distinct account_type) > 1;

----------8.Calculate the percentage of each account type out of the total number of accounts.
select
    account_type,
   count(*) * 100.0 / (select count(*) from Accounts) as percentage
from
    Accounts
group by
    account_type;

---------9. Retrieve all transactions for a customer with a given customer_id. 

select t.*from Transactions t
join Accounts a on t.account_id = a.account_id
where a.customer_id = 3;


