
-- Create Database
CREATE DATABASE TicketBookingSystem;
GO

USE TicketBookingSystem;
GO

-- Create Venue Table
CREATE TABLE Venue (
    venue_id INT PRIMARY KEY,
    venue_name VARCHAR(255),
    address TEXT
);

-- Create Booking Table
CREATE TABLE Booking (
    booking_id INT PRIMARY KEY,
    customer_id INT,
    event_id INT,
    num_tickets INT,
    total_cost DECIMAL(10,2),
    booking_date DATE
);

-- Create Event Table
CREATE TABLE Event (
    event_id INT PRIMARY KEY,
    event_name VARCHAR(255),
    event_date DATE,
    event_time TIME,
    venue_id INT,
    total_seats INT,
    available_seats INT,
    ticket_price DECIMAL(10,2),
    event_type VARCHAR(50),
    booking_id INT,
    FOREIGN KEY (venue_id) REFERENCES Venue(venue_id),
    FOREIGN KEY (booking_id) REFERENCES Booking(booking_id)
);

-- Create Customer Table
CREATE TABLE Customer (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(255),
    email VARCHAR(255) UNIQUE,
    phone_number VARCHAR(20),
    booking_id INT,
    FOREIGN KEY (booking_id) REFERENCES Booking(booking_id)
);

-- Insert Venue Data
INSERT INTO Venue VALUES
(1, 'City Arena', 'Downtown Ave, NY'),
(2, 'Sunshine Theater', 'Main St, LA');

-- Insert Booking Data
INSERT INTO Booking VALUES
(1, 1, 1, 2, 2000.00, '2025-04-01'),
(2, 2, 2, 3, 4500.00, '2025-04-03'),
(3, 3, 3, 1, 1500.00, '2025-04-05'),
(4, 4, 4, 4, 4000.00, '2025-04-07'),
(5, 5, 5, 5, 6250.00, '2025-04-10');

-- Insert Customer Data
INSERT INTO Customer VALUES
(1, 'Alice Johnson', 'alice@example.com', '123450000', 1),
(2, 'Bob Smith', 'bob@example.com', '987650000', 2),
(3, 'Charlie Brown', 'charlie@example.com', '112230000', 3),
(4, 'Diana Prince', 'diana@example.com', '667780000', 4),
(5, 'Evan Lee', 'evan@example.com', '998870000', 5);

-- Insert Event Data
INSERT INTO Event VALUES
(1, 'World Cup Match', '2025-05-01', '18:00', 1, 20000, 15000, 1000.00, 'Sports', 1),
(2, 'Rock Concert', '2025-05-10', '20:00', 2, 10000, 5000, 1500.00, 'Concert', 2),
(3, 'Movie Premiere', '2025-05-15', '21:00', 2, 500, 100, 1200.00, 'Movie', 3),
(4, 'Jazz Night Concert', '2025-05-20', '19:00', 1, 7000, 3000, 1800.00, 'Concert', 4),
(5, 'Broadway Play', '2025-06-01', '17:00', 1, 1500, 800, 1250.00, 'Play', 5);

-- Task 2: Select, Where, Between, AND, LIKE
-- Sample Data Insertions
INSERT INTO Booking VALUES
(1, 1, 1, 2, 2000.00, '2025-04-01'),
(2, 2, 2, 3, 4500.00, '2025-04-03'),
(3, 3, 3, 1, 1500.00, '2025-04-05'),
(4, 4, 4, 4, 4000.00, '2025-04-07'),
(5, 5, 5, 5, 6250.00, '2025-04-10');

INSERT INTO Customer VALUES
(1, 'Alice Johnson', 'alice@example.com', '123450000', 1),
(2, 'Bob Smith', 'bob@example.com', '987650000', 2),
(3, 'Charlie Brown', 'charlie@example.com', '112230000', 3),
(4, 'Diana Prince', 'diana@example.com', '667780000', 4),
(5, 'Evan Lee', 'evan@example.com', '998870000', 5);

INSERT INTO Event VALUES
(1, 'World Cup Match', '2025-05-01', '18:00', 1, 20000, 15000, 1000.00, 'Sports', 1),
(2, 'Rock Concert', '2025-05-10', '20:00', 2, 10000, 5000, 1500.00, 'Concert', 2),
(3, 'Movie Premiere', '2025-05-15', '21:00', 2, 500, 100, 1200.00, 'Movie', 3),
(4, 'Jazz Night Concert', '2025-05-20', '19:00', 1, 7000, 3000, 1800.00, 'Concert', 4),
(5, 'Broadway Play', '2025-06-01', '17:00', 1, 1500, 800, 1250.00, 'Play', 5);

-- Task 2 Queries
-- 2
SELECT * FROM Event;
-- 3
SELECT * FROM Event WHERE available_seats > 0;
-- 4
SELECT * FROM Event WHERE event_name LIKE '%cup%';
-- 5
SELECT * FROM Event WHERE ticket_price BETWEEN 1000 AND 2500;
-- 6
SELECT * FROM Event WHERE event_date BETWEEN '2025-05-01' AND '2025-05-31';
-- 7
SELECT * FROM Event WHERE available_seats > 0 AND event_name LIKE '%Concert%';
-- 8
SELECT * FROM Customer ORDER BY customer_id OFFSET 5 ROWS FETCH NEXT 5 ROWS ONLY;
-- 9
SELECT * FROM Booking WHERE num_tickets > 4;
-- 10
SELECT * FROM Customer WHERE phone_number LIKE '%000';
-- 11
SELECT * FROM Event WHERE total_seats > 15000 ORDER BY total_seats;
-- 12
SELECT * FROM Event WHERE event_name NOT LIKE 'x%' AND event_name NOT LIKE 'y%' AND event_name NOT LIKE 'z%';

-- Task 3: Aggregates and Joins
-- 1
SELECT event_name, AVG(ticket_price) AS avg_price FROM Event GROUP BY event_name;
-- 2
SELECT SUM(total_cost) AS total_revenue FROM Booking;
-- 3
SELECT TOP 1 event_id, SUM(num_tickets) AS total_sales FROM Booking GROUP BY event_id ORDER BY total_sales DESC;
-- 4
SELECT event_id, SUM(num_tickets) AS tickets_sold FROM Booking GROUP BY event_id;
-- 5
SELECT e.event_id, e.event_name FROM Event e LEFT JOIN Booking b ON e.event_id = b.event_id WHERE b.event_id IS NULL;
-- 6
SELECT TOP 1 customer_id, SUM(num_tickets) AS total_tickets FROM Booking GROUP BY customer_id ORDER BY total_tickets DESC;
-- 7
SELECT FORMAT(booking_date, 'yyyy-MM') AS month, event_id, SUM(num_tickets) FROM Booking GROUP BY FORMAT(booking_date, 'yyyy-MM'), event_id;
-- 8
SELECT venue_id, AVG(ticket_price) AS avg_price FROM Event GROUP BY venue_id;
-- 9
SELECT event_type, SUM(num_tickets) FROM Event e JOIN Booking b ON e.event_id = b.event_id GROUP BY event_type;
-- 10
SELECT YEAR(booking_date) AS year, SUM(total_cost) FROM Booking GROUP BY YEAR(booking_date);
-- 11
SELECT customer_id FROM Booking GROUP BY customer_id HAVING COUNT(DISTINCT event_id) > 1;
-- 12
SELECT customer_id, SUM(total_cost) FROM Booking GROUP BY customer_id;
-- 13
SELECT event_type, venue_id, AVG(ticket_price) FROM Event GROUP BY event_type, venue_id;
-- 14
SELECT customer_id, SUM(num_tickets) AS total_tickets FROM Booking WHERE booking_date >= DATEADD(DAY, -30, GETDATE()) GROUP BY customer_id;

-- Task 4: Subqueries
-- 1
SELECT venue_id, (SELECT AVG(ticket_price) FROM Event e2 WHERE e1.venue_id = e2.venue_id) AS avg_price FROM Event e1 GROUP BY venue_id;
-- 2
SELECT * FROM Event WHERE (total_seats - available_seats) > (0.5 * total_seats);
-- 3
SELECT event_id, SUM(num_tickets) AS total_sold FROM Booking GROUP BY event_id;
-- 4
SELECT * FROM Customer c WHERE NOT EXISTS (SELECT 1 FROM Booking b WHERE c.customer_id = b.customer_id);
-- 5
SELECT * FROM Event WHERE event_id NOT IN (SELECT DISTINCT event_id FROM Booking);
-- 6
SELECT event_type, SUM(tickets) FROM (SELECT e.event_type, b.num_tickets AS tickets FROM Event e JOIN Booking b ON e.event_id = b.event_id) sub GROUP BY event_type;
-- 7
SELECT * FROM Event WHERE ticket_price > (SELECT AVG(ticket_price) FROM Event);
-- 8
SELECT customer_id, (SELECT SUM(total_cost) FROM Booking b2 WHERE b2.customer_id = b1.customer_id) AS total_spent FROM Booking b1 GROUP BY customer_id;
-- 9
SELECT * FROM Customer WHERE customer_id IN (SELECT b.customer_id FROM Booking b JOIN Event e ON b.event_id = e.event_id WHERE e.venue_id = 1);
-- 10
SELECT event_type, SUM(tickets) FROM (SELECT e.event_type, b.num_tickets AS tickets FROM Event e JOIN Booking b ON e.event_id = b.event_id) sub GROUP BY event_type;
-- 11
SELECT customer_id FROM Booking WHERE MONTH(booking_date) = MONTH(GETDATE()) GROUP BY customer_id;
-- 12
SELECT venue_id, (SELECT AVG(ticket_price) FROM Event e2 WHERE e1.venue_id = e2.venue_id) AS avg_price FROM Event e1 GROUP BY venue_id;
