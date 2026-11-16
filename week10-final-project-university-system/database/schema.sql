-- University Management System schema
-- Run this script in MySQL Workbench before starting the JavaFX application.

CREATE DATABASE IF NOT EXISTS university_db;
USE university_db;

-- Table 1: Programs (degrees offered)
CREATE TABLE programs (
    program_id INT AUTO_INCREMENT PRIMARY KEY,
    program_name VARCHAR(100) NOT NULL,
    required_units INT NOT NULL
);

INSERT INTO programs (program_name, required_units) VALUES
('Bachelor of Computer Science', 56),
('Diploma in IT', 24);

-- Table 2: Students
CREATE TABLE students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    registration_number VARCHAR(20) UNIQUE NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    program_id INT,
    FOREIGN KEY (program_id) REFERENCES programs(program_id)
);

-- Optional sample data so the table is not empty on first launch
INSERT INTO students (registration_number, first_name, last_name, email, program_id) VALUES
('S101', 'Amina', 'Mwangi', 's101@university.edu', 1),
('S102', 'Brian', 'Otieno', 's102@university.edu', 2);
