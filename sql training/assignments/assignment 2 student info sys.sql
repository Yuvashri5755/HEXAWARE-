
create database StudentDB;
go

use StudentDB;
go

create table Students (
    student_id INT PRIMARY KEY IDENTITY(1,1),
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    date_of_birth DATE NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone_number VARCHAR(15)
);


create table Teacher (
    teacher_id INT PRIMARY KEY IDENTITY(1,1),
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100) UNIQUE
);


create table Courses (
    course_id INT PRIMARY KEY IDENTITY(1,1),
    course_name VARCHAR(100),
    credits INT,
    teacher_id INT FOREIGN KEY REFERENCES Teacher(teacher_id)
);


create table Enrollments (
    enrollment_id INT PRIMARY KEY IDENTITY(1,1),
    student_id INT FOREIGN KEY REFERENCES Students(student_id),
    course_id INT FOREIGN KEY REFERENCES Courses(course_id),
    enrollment_date DATE
);


create table Payments (
    payment_id INT PRIMARY KEY IDENTITY(1,1),
    student_id INT FOREIGN KEY REFERENCES Students(student_id),
    amount DECIMAL(10, 2),
    payment_date DATE
);


insert into Students (first_name, last_name, date_of_birth, email, phone_number) values
('Ravi', 'Kumar', '2000-05-20', 'ravi@example.com', '9991112233'),
('Anjali', 'Sharma', '2001-03-15', 'anjali@example.com', '8887776655'),
('John', 'Doe', '1995-08-15', 'john.doe@example.com', '1234567890'),
('yuva','sai','2002-10-11','yuvas11@gmail.com','2989201899'),
('Janu', 'sandy', '1997-07-15', 'janu.sandy@example.com', '899367890'),
('viswa', 'Dr', '2003-08-28', 'vizz@example.com', '782911890'),
('suriya', 'prathap', '2002-10-01', 'surr@example.com', '991881900'),
('sara', 'Doe', '1999-04-15', 'sara.doe@example.com', '199017890'),
('meena', 'selvi', '1999-08-23', 'meena11@example.com', '902178890'),
('sai', 'selvi', '2000-08-23', 'sai1@example.com', '9009217889')


insert into Teacher (first_name, last_name, email)values
('Priya', 'Mehta', 'priya.mehta@school.com'),
('Raj', 'Verma', 'raj.verma@school.com'),
('rani','ammal','rani55@school.com'),
('siva','subbu','sivasubbu22@school.com'),
('raju','sara','rajjj22@school.com'),
('harni','sai','harini@school.com'),
('jaya','suriya','jaya11@school.com'),
('sharmi','suriya','sharmi88@school.com'),
('vaishali','sara','saravaish@school.com'),
('yuvaraj','suriyan','suriyan@school.com')


insert into Courses (course_name, credits, teacher_id) values
('Mathematics', 3, 1),
('Science', 4, 2),
('English',4,3),
('Tamil',5,4),
('social ',3,5),
('GK',4,6),
('Computer science',5,7),
('Java',4,8),
('biology',4,9),
('python',3,10)


insert into Enrollments (student_id, course_id, enrollment_date) values
(1, 1, '2023-08-01'),
(2, 1, '2023-08-01'),
(3, 2, '2023-08-01'),
(4,2,'2023-08-02'),
(5,8,'2023-08-04'),
(6,4,'2023-09-01'),
(7,3,'2023-09-10'),
(8,7,'2023-12-01'),
(9,5,'2024-01-02'),
(10,6,'2024-02-22')


insert into Payments (student_id, amount, payment_date) values
(1, 5000, '2023-08-15'),
(2, 5500, '2023-08-16'),
(3,2500,'2023-08-10'),
(4,8000,'2023-09-10'),
(5,5000,'2023-09-29'),
(6,6000,'2023-09-23'),
(7,3000,'2023-10-11'),
(8,4500,'2023-11-10'),
(9,7000,'2024-01-20'),
(10,3500,'2024-01-22');




-------------TASK2----
------1.Write an SQL query to insert a new student into the "Students" table with the following details:a. First Name: Johnie© Hexaware Technologies Limited. All rights www.hexaware.comb. Last Name: Doec. Date of Birth: 1995-08-15d. Email: john.doe@example.com. Phone Number: 1234567890-----

insert into Students (first_name, last_name, date_of_birth, email, phone_number)
values ('Johnie', 'Doe', '1995-08-15', 'johnie.doe@example.com', '1234567890');

-----2.Write an SQL query to enroll a student in a course. Choose an existing student and course and Insert a record into the "Enrollments" table with the enrollment date. 


insert into Enrollments (student_id, course_id, enrollment_date)
values (4, 3, GETDATE());
insert intoEnrollments (student_id, course_id, enrollment_date)
values (7, 6, GETDATE());

insert into Enrollments (student_id, course_id, enrollment_date)
values (1, 10, GETDATE());

-- 3.Update the email address of a specific teacher in the "Teacher" table. Choose any teacher and modify their email address. 

update Teacher
set email = 'priya.updated@school.com'
where teacher_id = 1;

-- 4.Write an SQL query to delete a specific enrollment record from the "Enrollments" table. Select an enrollment record based on the student and course. 

delete from Enrollments
where student_id = 2 and course_id = 1;

-- 5. Update the "Courses" table to assign a specific teacher to a course. Choose any course and teacher from the respective tables. 

update Courses
set teacher_id = 2
where course_id = 1;

-- 6.Delete a specific student from the "Students" table and remove all their enrollment records from the "Enrollments" table. Be sure to maintain referential integrity.

delete from Enrollments where student_id = 3;
delete from Payments where student_id = 3;
delete from  Students where student_id = 3;

-- 7.Update the payment amount for a specific payment record in the "Payments" table. Choose any payment record and modify the payment amount. 

update Payments
set amount = 6000
where payment_id = 1;

------TASK3------
----1. Write an SQL query to calculate the total payments made by a specific student. You will need to join the "Payments" table with the "Students" table based on the student's ID.

select  s.first_name, SUM(p.amount) as total_paid
from Students s
join Payments p on s.student_id = p.student_id
where s.student_id = 1
group by s.first_name;

-- 2.Write an SQL query to retrieve a list of courses along with the count of students enrolled in each course. Use a JOIN operation between the "Courses" table and the "Enrollments" table. 

select T c.course_name, count (e.enrollment_id) as total_enrolled
from Courses c
left join Enrollments e on c.course_id = e.course_id
group by c.course_name;

-- 3.Write an SQL query to find the names of students who have not enrolled in any course. Use a LEFT JOIN between the "Students" table and the "Enrollments" table to identify students without enrollments.

select s.first_name, s.last_name
from Students s
left join Enrollments e on s.student_id = e.student_id
where e.student_id is null;

-- 4. Write an SQL query to retrieve the first name, last name of students, and the names of the courses they are enrolled in. Use JOIN operations between the "Students" table and the "Enrollments" and "Courses" tables. 

select s.first_name, s.last_name, c.course_name
from Students s
join Enrollments e on s.student_id = e.student_id
join Courses c on e.course_id = c.course_id;

-- 5.Create a query to list the names of teachers and the courses they are assigned to. Join the "Teacher" table with the "Courses" table.

select t.first_name, t.last_name, c.course_name
from Teacher t
left join Courses c on t.teacher_id = c.teacher_id;

-- 6. Retrieve a list of students and their enrollment dates for a specific course. You'll need to join the "Students" table with the "Enrollments" and "Courses" tables. 

select s.first_name, e.enrollment_date
from Students s
join Enrollments e on s.student_id = e.student_id
join Courses c on e.course_id = c.course_id
where c.course_name = 'Mathematics';

-- 7. Find the names of students who have not made any payments. Use a LEFT JOIN between the "Students" table and the "Payments" table and filter for students with NULL payment records. 

select s.first_name, s.last_name
from Students s
left join Payments p ON s.student_id = p.student_id
where p.payment_id is null;

-- 8. Write a query to identify courses that have no enrollments. You'll need to use a LEFT JOIN between the "Courses" table and the "Enrollments" table and filter for courses with NULL enrollment records. 

select c.course_name
from Courses c
left join Enrollments e on c.course_id = e.course_id
where e.enrollment_id  is null;

-- 9. Identify students who are enrolled in more than one course. Use a self-join on the "Enrollments" table to find students with multiple enrollment records. 

select s.first_name, count(e.course_id) as course_count
from Students s
join Enrollments e ON s.student_id = e.student_id
group by s.first_name
having count (e.course_id) > 1;

-- 10. Find teachers who are not assigned to any courses. Use a LEFT JOIN between the "Teacher" table and the "Courses" table and filter for teachers with NULL course assignments. 

select t.first_name, t.last_name
from Teacher t
left join  Courses c on t.teacher_id = c.teacher_id
WHERE c.course_id is null;

------TASK 4----
-- 1. Write an SQL query to calculate the average number of students enrolled in each course. Use aggregate functions and subqueries to achieve this. 

select  avg(EnrollCount) AS avg_enrollments
from (
    select count(*) AS EnrollCount
    from Enrollments
    group by course_id
) as sub;

-- 2. Identify the student(s) who made the highest payment. Use a subquery to find the maximum payment amount and then retrieve the student(s) associated with that amount. 

select s.first_name, p.amount
from Students s
join Payments p on s.student_id = p.student_id
where p.amount = (select MAX(amount) from Payments);

-- 3.Retrieve a list of courses with the highest number of enrollments. Use subqueries to find the course(s) with the maximum enrollment count. 

select course_id,count(*) AS total
from Enrollments
group by course_id
having count(*) = (
    select MAX(cnt)
   from (select count(*) as cnt from Enrollments group by course_id) AS sub
);

-- 4. Calculate the total payments made to courses taught by each teacher. Use subqueries to sum payments for each teacher's courses. 

select t.first_name, SUM(p.amount) AS total_payments
from Teacher t
join Courses c ON t.teacher_id = c.teacher_id
join Enrollments e ON c.course_id = e.course_id
join  Payments p ON e.student_id = p.student_id
group by t.first_name;

-- 5. Identify students who are enrolled in all available courses. Use subqueries to compare a student's enrollments with the total number of courses. 

select s.student_id, s.first_name
from Students s
WHERE NOT EXISTS (
    select course_id FROM Courses
    EXCEPT
    select course_id from Enrollments e where e.student_id = s.student_id
);

-- 6. Retrieve the names of teachers who have not been assigned to any courses. Use subqueries to find teachers with no course assignments

select first_name from Teacher
where teacher_id not in (select teacher_id from Courses where teacher_id is not null);

-- 7.Calculate the average age of all students. Use subqueries to calculate the age of each student based on their date of birth. 

select  AVG(DATEDIFF(YEAR, date_of_birth, GETDATE())) as avg_age
from Students;

-- 8.Identify courses with no enrollments. Use subqueries to find courses without enrollment records. 

select course_name FROM Courses
where course_id not in (select course_id from Enrollments);

-- 9. Calculate the total payments made by each student for each course they are enrolled in. Use subqueries and aggregate functions to sum payments. 

select s.first_name, c.course_name, SUM(p.amount) AS total
from Payments p
join Enrollments e ON p.student_id = e.student_id
join Students s ON s.student_id = p.student_id
join Courses c ON e.course_id = c.course_id
group by s.first_name, c.course_name;

-- 10. Identify students who have made more than one payment. Use subqueries and aggregate functions to count payments per student and filter for those with counts greater than one. 

select  s.first_name, COUNT(p.payment_id) AS payments
from Students s
join Payments p ON s.student_id = p.student_id
group by s.first_name
having count(p.payment_id) > 1;

-- 11. Total payments by each student
select s.first_name, SUM(p.amount) AS total
from Students s
join Payments p ON s.student_id = p.student_id
group by s.first_name;

-- 12.  Retrieve a list of course names along with the count of students enrolled in each course. Use JOIN operations between the "Courses" table and the "Enrollments" table and GROUP BY to Count enrollments. 

select c.course_name, count(e.enrollment_id) AS student_count
from Courses c
left join Enrollments e ON c.course_id = e.course_id
group by c.course_name;

-- 13. Calculate the average payment amount made by students. Use JOIN operations between the "Students" table and the "Payments" table and GROUP BY to calculate the average.

select AVG(p.amount) AS avg_payment
from Students s
join Payments p ON s.student_id = p.student_id;
