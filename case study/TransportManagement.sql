CREATE DATABASE TRANSPORTMANAGEMENT;
GO;

USE TRANSPORTMANAGEMENT;
GO

-- 1. Vehicles Table
CREATE TABLE Vehicles (
    VehicleID INT IDENTITY(1,1) PRIMARY KEY,
    Model NVARCHAR(255) NOT NULL,
    Capacity DECIMAL(10, 2) NOT NULL,
    Type NVARCHAR(50) NOT NULL,           
    Status NVARCHAR(50) NOT NULL           
);

-- 2. Routes Table
CREATE TABLE Routes (
    RouteID INT IDENTITY(1,1) PRIMARY KEY,
    StartDestination NVARCHAR(255) NOT NULL,
    EndDestination NVARCHAR(255) NOT NULL,
    Distance DECIMAL(10, 2) NOT NULL
);

-- 3. Trips Table
CREATE TABLE Trips (
    TripID INT IDENTITY(1,1) PRIMARY KEY,
    VehicleID INT NOT NULL,
    RouteID INT NOT NULL,
    DepartureDate DATETIME NOT NULL,
    ArrivalDate DATETIME NOT NULL,
    Status NVARCHAR(50) NOT NULL,         
    TripType NVARCHAR(50) DEFAULT 'Freight', 
    MaxPassengers INT,
    
    FOREIGN KEY (VehicleID) REFERENCES Vehicles(VehicleID),
    FOREIGN KEY (RouteID) REFERENCES Routes(RouteID)
);

-- 4. Passengers Table
CREATE TABLE Passengers (
    PassengerID INT IDENTITY(1,1) PRIMARY KEY,
    FirstName NVARCHAR(255) NOT NULL,
    Gender NVARCHAR(255) NOT NULL,
    Age INT NOT NULL,
    Email NVARCHAR(255) UNIQUE NOT NULL,
    PhoneNumber NVARCHAR(50) NOT NULL
);

-- 5. Bookings Table
CREATE TABLE Bookings (
    BookingID INT IDENTITY(1,1) PRIMARY KEY,
    TripID INT NOT NULL,
    PassengerID INT NOT NULL,
    BookingDate DATETIME NOT NULL DEFAULT GETDATE(),
    Status NVARCHAR(50) NOT NULL,         

    FOREIGN KEY (TripID) REFERENCES Trips(TripID),
    FOREIGN KEY (PassengerID) REFERENCES Passengers(PassengerID)
);

SELECT*FROM Vehicles

SELECT*FROM Routes

SELECT*FROM Trips

SELECT*FROM Passengers

SELECT*FROM Bookings