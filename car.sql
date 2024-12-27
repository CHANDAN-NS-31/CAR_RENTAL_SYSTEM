CREATE DATABASE rental;


USE rental;

-- Users table
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE
);

-- Cars table
CREATE TABLE cars (
    car_id INT AUTO_INCREMENT PRIMARY KEY,
    make VARCHAR(50) NOT NULL,
    model VARCHAR(50) NOT NULL,
    year YEAR NOT NULL,
    daily_rate DECIMAL(10, 2) NOT NULL
);

-- Locations table
CREATE TABLE locations (
    location_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    address VARCHAR(255) NOT NULL
);

-- Rentals table
CREATE TABLE rentals (
    rental_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    car_id INT,
    location_id INT,
    rental_date DATE NOT NULL,
    return_date DATE NOT NULL,
    total_amount DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (car_id) REFERENCES cars(car_id),
    FOREIGN KEY (location_id) REFERENCES locations(location_id)
);

-- Payments table
CREATE TABLE payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    rental_id INT,
    payment_date DATE NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (rental_id) REFERENCES rentals(rental_id)
);

-- Insert sample data into users table
INSERT INTO users (username, password, email) VALUES
('john_doe', 'password123', 'john@example.com'),
('jane_smith', 'password456', 'jane@example.com'),
('alice_jones', 'password789', 'alice@example.com'),
('bob_brown', 'password101', 'bob@example.com'),
('charlie_black', 'password102', 'charlie@example.com'),
('chandan', 'password109', 'charlie@.com');
-- Insert sample data into cars table
INSERT INTO cars (make, model, year, daily_rate) VALUES
('Toyota', 'Camry', 2020, 50.00),
('Honda', 'Civic', 2019, 45.00),
('Ford', 'Focus', 2018, 40.00),
('Chevrolet', 'Malibu', 2021, 55.00),
('Nissan', 'Altima', 2022, 60.00);

-- Insert sample data into locations table
INSERT INTO locations (name, address) VALUES
('Downtown', '123 Main St, Cityville'),
('Airport', '456 Airport Rd, Cityville'),
('Suburbs', '789 Suburb Ln, Cityville'),
('University', '101 College Ave, Cityville'),
('Mall', '202 Mall Dr, Cityville');

-- Insert sample data into rentals table
INSERT INTO rentals (user_id, car_id, location_id, rental_date, return_date, total_amount) VALUES
(1, 1, 1, '2024-05-01', '2024-05-05', 200.00),
(2, 2, 2, '2024-05-02', '2024-05-06', 180.00),
(3, 3, 3, '2024-05-03', '2024-05-07', 160.00),
(4, 4, 4, '2024-05-04', '2024-05-08', 220.00),
(5, 5, 5, '2024-05-05', '2024-05-09', 240.00);

-- Insert sample data into payments table
INSERT INTO payments (rental_id, payment_date, amount) VALUES
(1, '2024-05-01', 200.00),
(2, '2024-05-02', 180.00),
(3, '2024-05-03', 160.00),
(4, '2024-05-04', 220.00),
(5, '2024-05-05', 240.00);

-- Trigger to update total_amount on insert into rentals
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

select * from cars;

