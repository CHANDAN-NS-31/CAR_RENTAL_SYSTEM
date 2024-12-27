CREATE DATABASE car_rental;

USE car_rental;

-- Employee Table
CREATE TABLE employees (
    empID INT AUTO_INCREMENT PRIMARY KEY,
    fname VARCHAR(50),
    lname VARCHAR(50),
    salary DECIMAL(10, 2),
    joined_date DATE,
    responsibility VARCHAR(100),
    houseNumber VARCHAR(10),
    city VARCHAR(50),
    country VARCHAR(50),
    contactNumber VARCHAR(15)
);

-- Customer Table
CREATE TABLE customers (
    custID INT AUTO_INCREMENT PRIMARY KEY,
    fname VARCHAR(50),
    lname VARCHAR(50),
    drivingLicence VARCHAR(50),
    houseNumber VARCHAR(10),
    city VARCHAR(50),
    country VARCHAR(50),
    contactNO VARCHAR(15)
);

-- Car Table
CREATE TABLE cars (
    vehicleID INT AUTO_INCREMENT PRIMARY KEY,
    mileage INT,
    plateNo VARCHAR(20),
    dailyPrice DECIMAL(10, 2),
    car_condition VARCHAR(50),
    model VARCHAR(50)
);

-- Location Table
CREATE TABLE locations (
    locationId INT AUTO_INCREMENT PRIMARY KEY,
    address VARCHAR(255),
    startTime TIME,
    endTime TIME,
    noOfCarsAvailable INT
);

-- User Details Table
CREATE TABLE userDetails (
    uid INT AUTO_INCREMENT PRIMARY KEY,
    driverLicence VARCHAR(50),
    address VARCHAR(255),
    preferredInsurance VARCHAR(100)
);

-- Rent Table
CREATE TABLE rent (
    rentID INT AUTO_INCREMENT PRIMARY KEY,
    refund DECIMAL(10, 2),
    downPay DECIMAL(10, 2),
    payMethod VARCHAR(50),
    totalPay DECIMAL(10, 2),
    payDate DATE,
    damageCompensation DECIMAL(10, 2),
    custID INT,
    FOREIGN KEY (custID) REFERENCES customers(custID)
);

-- Reservation Table
CREATE TABLE reservations (
    reserveID INT AUTO_INCREMENT PRIMARY KEY,
    reserveDate DATE,
    returnDate DATE,
    noOfDays INT,
    cancellationDetails VARCHAR(255),
    pickupLocation VARCHAR(100),
    pickupDate DATE,
    custID INT,
    vehicleID INT,
    FOREIGN KEY (custID) REFERENCES customers(custID),
    FOREIGN KEY (vehicleID) REFERENCES cars(vehicleID)
);



-- Insert sample records into employees
INSERT INTO employees (fname, lname, salary, joined_date, responsibility, houseNumber, city, country, contactNumber)
VALUES 
('John', 'Doe', 50000, '2020-01-15', 'Manager', '101', 'New York', 'USA', '1234567890'),
('Jane', 'Smith', 45000, '2019-03-10', 'Sales', '202', 'Los Angeles', 'USA', '2345678901'),
('Robert', 'Brown', 48000, '2021-07-22', 'Mechanic', '303', 'Chicago', 'USA', '3456789012'),
('Emily', 'Davis', 42000, '2018-11-30', 'Customer Service', '404', 'Houston', 'USA', '4567890123'),
('Michael', 'Wilson', 52000, '2020-06-18', 'Manager', '505', 'Phoenix', 'USA', '5678901234'),
('Sarah', 'Taylor', 47000, '2021-02-15', 'Sales', '606', 'Philadelphia', 'USA', '6789012345'),
('David', 'Jones', 49000, '2019-09-20', 'Mechanic', '707', 'San Antonio', 'USA', '7890123456'),
('Laura', 'Miller', 43000, '2018-05-25', 'Customer Service', '808', 'San Diego', 'USA', '8901234567'),
('Daniel', 'Garcia', 51000, '2020-03-18', 'Manager', '909', 'Dallas', 'USA', '9012345678'),
('Jessica', 'Martinez', 46000, '2021-10-10', 'Sales', '1001', 'San Jose', 'USA', '0123456789');

-- Insert sample records into customers
INSERT INTO customers (fname, lname, drivingLicence, houseNumber, city, country, contactNO)
VALUES 
('Alice', 'White', 'DL123456', '1A', 'New York', 'USA', '1111111111'),
('Bob', 'Green', 'DL234567', '2B', 'Los Angeles', 'USA', '2222222222'),
('Charlie', 'Black', 'DL345678', '3C', 'Chicago', 'USA', '3333333333'),
('David', 'Blue', 'DL456789', '4D', 'Houston', 'USA', '4444444444'),
('Eve', 'Yellow', 'DL567890', '5E', 'Phoenix', 'USA', '5555555555'),
('Frank', 'Purple', 'DL678901', '6F', 'Philadelphia', 'USA', '6666666666'),
('Grace', 'Brown', 'DL789012', '7G', 'San Antonio', 'USA', '7777777777'),
('Hank', 'Orange', 'DL890123', '8H', 'San Diego', 'USA', '8888888888'),
('Ivy', 'Pink', 'DL901234', '9I', 'Dallas', 'USA', '9999999999'),
('Jack', 'Gray', 'DL012345', '10J', 'San Jose', 'USA', '0000000000');

-- Insert sample records into cars
INSERT INTO cars (mileage, plateNo, dailyPrice, car_condition, model)
VALUES 
(20000, 'NYC1234', 50.00, 'Excellent', 'Toyota Corolla'),
(15000, 'LAX5678', 60.00, 'Good', 'Honda Civic'),
(25000, 'CHI9012', 55.00, 'Fair', 'Ford Focus'),
(30000, 'HOU3456', 70.00, 'Excellent', 'Chevrolet Malibu'),
(10000, 'PHX7890', 65.00, 'Good', 'Nissan Sentra'),
(18000, 'PHI2345', 60.00, 'Excellent', 'Hyundai Elantra'),
(22000, 'SAT6789', 50.00, 'Fair', 'Kia Forte'),
(12000, 'SAN0123', 75.00, 'Good', 'Volkswagen Jetta'),
(14000, 'DAL4567', 80.00, 'Excellent', 'Subaru Impreza'),
(16000, 'SJO8901', 55.00, 'Good', 'Mazda 3');

-- Insert sample records into locations
INSERT INTO locations (address, startTime, endTime, noOfCarsAvailable)
VALUES 
('123 Main St, New York, NY', '08:00:00', '20:00:00', 10),
('456 Elm St, Los Angeles, CA', '09:00:00', '21:00:00', 8),
('789 Pine St, Chicago, IL', '08:00:00', '20:00:00', 12),
('101 Maple St, Houston, TX', '09:00:00', '21:00:00', 9),
('202 Oak St, Phoenix, AZ', '08:00:00', '20:00:00', 7),
('303 Cedar St, Philadelphia, PA', '09:00:00', '21:00:00', 10),
('404 Birch St, San Antonio, TX', '08:00:00', '20:00:00', 11),
('505 Walnut St, San Diego, CA', '09:00:00', '21:00:00', 8),
('606 Spruce St, Dallas, TX', '08:00:00', '20:00:00', 10),
('707 Cherry St, San Jose, CA', '09:00:00', '21:00:00', 9);

-- Insert sample records into userDetails
INSERT INTO userDetails (driverLicence, address, preferredInsurance)
VALUES 
('DL123456', '123 Main St, New York, NY', 'Full Coverage'),
('DL234567', '456 Elm St, Los Angeles, CA', 'Liability Only'),
('DL345678', '789 Pine St, Chicago, IL', 'Full Coverage'),
('DL456789', '101 Maple St, Houston, TX', 'Liability Only'),
('DL567890', '202 Oak St, Phoenix, AZ', 'Full Coverage'),
('DL678901', '303 Cedar St, Philadelphia, PA', 'Liability Only'),
('DL789012', '404 Birch St, San Antonio, TX', 'Full Coverage'),
('DL890123', '505 Walnut St, San Diego, CA', 'Liability Only'),
('DL901234', '606 Spruce St, Dallas, TX', 'Full Coverage'),
('DL012345', '707 Cherry St, San Jose, CA', 'Liability Only');

-- Insert sample records into rent
INSERT INTO rent (refund, downPay, payMethod, totalPay, payDate, damageCompensation, custID)
VALUES 
(50.00, 200.00, 'Credit Card', 250.00, '2024-05-01', 0.00, 1),
(0.00, 150.00, 'Cash', 150.00, '2024-05-02', 10.00, 2),
(20.00, 300.00, 'Debit Card', 320.00, '2024-05-03', 0.00, 3),
(30.00, 250.00, 'Credit Card', 280.00, '2024-05-04', 5.00, 4),
(0.00, 200.00, 'Cash', 200.00, '2024-05-05', 20.00, 5),
(40.00, 350.00, 'Debit Card', 390.00, '2024-05-06', 0.00, 6),
(0.00, 100.00, 'Cash', 100.00, '2024-05-07', 15.00, 7),
(60.00, 400.00, 'Credit Card', 460.00, '2024-05-08', 0.00, 8),
(0.00, 250.00, 'Cash', 250.00, '2024-05-09', 25.00, 9),
(50.00, 300.00, 'Debit Card', 350.00, '2024-05-10', 0.00, 10);

-- Insert sample records into reservations
INSERT INTO reservations (reserveDate, returnDate, noOfDays, cancellationDetails, pickupLocation, pickupDate, custID, vehicleID)
VALUES 
('2024-06-01', '2024-06-10', 9, 'None', 'New York', '2024-06-01', 1, 1),
('2024-06-02', '2024-06-08', 6, 'None', 'Los Angeles', '2024-06-02', 2, 2),
('2024-06-03', '2024-06-12', 9, 'Late pickup', 'Chicago', '2024-06-03', 3, 3),
('2024-06-04', '2024-06-09', 5, 'Early return', 'Houston', '2024-06-04', 4, 4),
('2024-06-05', '2024-06-11', 6, 'None', 'Phoenix', '2024-06-05', 5, 5),
('2024-06-06', '2024-06-14', 8, 'None', 'Philadelphia', '2024-06-06', 6, 6),
('2024-06-07', '2024-06-13', 6, 'Cancellation fee applied', 'San Antonio', '2024-06-07', 7, 7),
('2024-06-08', '2024-06-15', 7, 'None', 'San Diego', '2024-06-08', 8, 8),
('2024-06-09', '2024-06-16', 7, 'None', 'Dallas', '2024-06-09', 9, 9),
('2024-06-10', '2024-06-17', 7, 'None', 'San Jose', '2024-06-10', 10, 10);

DELIMITER //
CREATE TRIGGER calculate_total_amount BEFORE INSERT ON rentals
FOR EACH ROW
BEGIN
    DECLARE days INT;
    DECLARE rate DECIMAL(10,2);

    SET days = DATEDIFF(NEW.return_date, NEW.rental_date);
    SELECT daily_rate INTO rate FROM cars WHERE car_id = NEW.car_id;
    SET NEW.total_amount = days * rate;
END;
//
DELIMITER ;
