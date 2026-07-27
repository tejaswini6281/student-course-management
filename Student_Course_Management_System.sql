-- STUDENT COURSE MANAGEMENT SYSTEM
-- SQL Project
-- Database: MySQL

CREATE DATABASE IF NOT EXISTS student_course_management;
USE student_course_management;

CREATE TABLE students (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    student_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    department VARCHAR(50),
    year_of_study INT,
    city VARCHAR(50)
);

CREATE TABLE courses (
    course_id INT PRIMARY KEY AUTO_INCREMENT,
    course_name VARCHAR(100) NOT NULL,
    instructor VARCHAR(100),
    credits INT
);

CREATE TABLE enrollments (
    enrollment_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT,
    course_id INT,
    enrollment_date DATE,
    marks INT,
    grade VARCHAR(2),
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

INSERT INTO students (student_name, email, department, year_of_study, city) VALUES
('Tejaswini Elati', 'tejaswini@example.com', 'Information Technology', 4, 'Hyderabad'),
('Rahul Sharma', 'rahul@example.com', 'Computer Science', 3, 'Hyderabad'),
('Ananya Reddy', 'ananya@example.com', 'Information Technology', 4, 'Warangal'),
('Kiran Kumar', 'kiran@example.com', 'Electronics', 3, 'Vijayawada'),
('Sneha Rao', 'sneha@example.com', 'Computer Science', 2, 'Hyderabad');

INSERT INTO courses (course_name, instructor, credits) VALUES
('Database Management Systems', 'Dr. Ramesh', 4),
('Data Structures', 'Dr. Priya', 4),
('Web Development', 'Prof. Suresh', 3),
('Machine Learning', 'Dr. Anil', 4);

INSERT INTO enrollments (student_id, course_id, enrollment_date, marks, grade) VALUES
(1, 1, '2026-01-10', 92, 'A+'),
(1, 2, '2026-01-10', 88, 'A'),
(1, 3, '2026-01-11', 90, 'A+'),
(2, 1, '2026-01-12', 78, 'B+'),
(2, 2, '2026-01-12', 85, 'A'),
(3, 1, '2026-01-13', 95, 'A+'),
(3, 4, '2026-01-13', 91, 'A+'),
(4, 2, '2026-01-14', 72, 'B'),
(5, 3, '2026-01-15', 87, 'A');

SELECT * FROM students;
SELECT * FROM courses;
SELECT * FROM enrollments;

SELECT student_name, email
FROM students
WHERE department = 'Information Technology';

SELECT student_name, department
FROM students
WHERE city = 'Hyderabad';

SELECT *
FROM students
ORDER BY student_name ASC;

SELECT s.student_name, c.course_name, e.marks, e.grade
FROM enrollments e
JOIN students s ON e.student_id = s.student_id
JOIN courses c ON e.course_id = c.course_id;

SELECT s.student_name, c.course_name, e.marks
FROM enrollments e
JOIN students s ON e.student_id = s.student_id
JOIN courses c ON e.course_id = c.course_id
WHERE e.marks > 85;

SELECT c.course_name, AVG(e.marks) AS average_marks
FROM enrollments e
JOIN courses c ON e.course_id = c.course_id
GROUP BY c.course_name;

SELECT department, COUNT(*) AS total_students
FROM students
GROUP BY department;

SELECT MAX(marks) AS highest_marks FROM enrollments;
SELECT MIN(marks) AS lowest_marks FROM enrollments;

SELECT DISTINCT s.student_name
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
WHERE e.marks > (SELECT AVG(marks) FROM enrollments);

CREATE VIEW student_performance AS
SELECT s.student_name, s.department, c.course_name, e.marks, e.grade
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
JOIN courses c ON e.course_id = c.course_id;

SELECT * FROM student_performance;

UPDATE students
SET city = 'Secunderabad'
WHERE student_id = 1;

SELECT s.student_name,
       COUNT(e.course_id) AS courses_enrolled,
       AVG(e.marks) AS average_marks
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
GROUP BY s.student_id, s.student_name
ORDER BY average_marks DESC;
