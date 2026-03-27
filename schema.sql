CREATE DATABASE IF NOT EXISTS smart_garbage_db;
USE smart_garbage_db;

-- Users table
CREATE TABLE IF NOT EXISTS Users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    role ENUM('user', 'admin', 'worker') DEFAULT 'user',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Complaints table
CREATE TABLE IF NOT EXISTS Complaints (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    location VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    image VARCHAR(255),
    status ENUM('Pending', 'Assigned', 'Completed') DEFAULT 'Pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(id) ON DELETE CASCADE
);

-- Workers table
CREATE TABLE IF NOT EXISTS Workers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    name VARCHAR(100) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    area VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(id) ON DELETE CASCADE
);

-- Assignments table
CREATE TABLE IF NOT EXISTS Assignments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    complaint_id INT NOT NULL,
    worker_id INT NOT NULL,
    status ENUM('Assigned', 'In Progress', 'Completed') DEFAULT 'Assigned',
    assigned_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    completed_at TIMESTAMP NULL,
    proof_image VARCHAR(255),
    FOREIGN KEY (complaint_id) REFERENCES Complaints(id) ON DELETE CASCADE,
    FOREIGN KEY (worker_id) REFERENCES Workers(id) ON DELETE CASCADE
);

-- Smart Bin Status table
CREATE TABLE IF NOT EXISTS SmartBins (
    id INT AUTO_INCREMENT PRIMARY KEY,
    location VARCHAR(255) NOT NULL,
    status ENUM('Empty', 'Half', 'Full') DEFAULT 'Empty',
    last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- ========== DUMMY DATA ==========

-- Insert dummy users
-- Admin: email=admin@garbage.com, password=admin123
-- User1: email=user1@gmail.com, password=user123
-- User2: email=user2@gmail.com, password=user123
-- Worker1: email=worker1@garbage.com, password=worker123
-- Worker2: email=worker2@garbage.com, password=worker123

INSERT INTO Users (name, email, password, role) VALUES
('Admin Manager', 'admin@garbage.com', '$2a$10$YourHashedPasswordHere1', 'admin'),
('John User', 'user1@gmail.com', '$2a$10$YourHashedPasswordHere2', 'user'),
('Sarah User', 'user2@gmail.com', '$2a$10$YourHashedPasswordHere3', 'user'),
('Mike Worker', 'worker1@garbage.com', '$2a$10$YourHashedPasswordHere4', 'worker'),
('Tom Worker', 'worker2@garbage.com', '$2a$10$YourHashedPasswordHere5', 'worker');

-- Insert dummy complaints
INSERT INTO Complaints (user_id, location, description, status) VALUES
(2, 'Main Street, Sector 5', 'Garbage overflowing near residential complex', 'Completed'),
(3, 'Park Avenue, Downtown', 'Dirty accumulated waste in park area', 'Assigned'),
(2, 'Market Square', 'Broken garbage bin needs replacement', 'Pending'),
(3, 'Hospital Road', 'Medical waste scattered on sidewalk', 'Completed'),
(2, 'School Street', 'Garbage not collected for 3 days', 'Pending');

-- Insert dummy workers
INSERT INTO Workers (user_id, name, phone, area) VALUES
(4, 'Mike Worker', '9876543210', 'Sector 5'),
(5, 'Tom Worker', '8765432109', 'Downtown');

-- Insert dummy assignments
INSERT INTO Assignments (complaint_id, worker_id, status, completed_at) VALUES
(1, 1, 'Completed', NOW()),
(2, 2, 'In Progress', NULL),
(4, 1, 'Completed', DATE_SUB(NOW(), INTERVAL 2 DAY));

-- Insert dummy smart bins
INSERT INTO SmartBins (location, status) VALUES
('Main Street', 'Full'),
('Park Avenue', 'Half'),
('Market Square', 'Empty'),
('Hospital Road', 'Full'),
('School Street', 'Half');
