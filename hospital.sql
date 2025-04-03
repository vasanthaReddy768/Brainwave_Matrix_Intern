CREATE DATABASE School;
USE School;

CREATE TABLE Students (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    date_of_birth DATE,
    gender ENUM('Male', 'Female', 'Other'),
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(15),
    address TEXT
);

CREATE TABLE Teachers (
    teacher_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    subject VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(15)
);

CREATE TABLE Courses (
    course_id INT PRIMARY KEY AUTO_INCREMENT,
    course_name VARCHAR(100),
    teacher_id INT,
    credits INT,
    FOREIGN KEY (teacher_id) REFERENCES Teachers(teacher_id) ON DELETE SET NULL
);

CREATE TABLE Enrollments (
    enrollment_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT,
    course_id INT,
    enrollment_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (student_id) REFERENCES Students(student_id) ON DELETE CASCADE,
    FOREIGN KEY (course_id) REFERENCES Courses(course_id) ON DELETE CASCADE
);

CREATE TABLE Attendance (
    attendance_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT,
    course_id INT,
    attendance_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    status ENUM('Present', 'Absent', 'Late'),
    FOREIGN KEY (student_id) REFERENCES Students(student_id) ON DELETE CASCADE,
    FOREIGN KEY (course_id) REFERENCES Courses(course_id) ON DELETE CASCADE
);

INSERT INTO Students (first_name, last_name, date_of_birth, gender, email, phone, address)
VALUES 
('John', 'Doe', '2005-04-10', 'Male', 'john.doe@email.com', '1234567890', '123 Main St'),
('Emma', 'Smith', '2004-08-15', 'Female', 'emma.smith@email.com', '9876543210', '456 Oak St');

INSERT INTO Teachers (first_name, last_name, subject, email, phone)
VALUES 
('Alice', 'Johnson', 'Mathematics', 'alice.johnson@email.com', '1122334455'),
('Bob', 'Brown', 'Science', 'bob.brown@email.com', '5566778899');

INSERT INTO Courses (course_name, teacher_id, credits)
VALUES 
('Algebra', 1, 3),
('Physics', 2, 4);

INSERT INTO Enrollments (student_id, course_id)
VALUES 
(1, 1), 
(2, 2);

INSERT INTO Attendance (student_id, course_id, attendance_date, status)
VALUES 
(1, 1, '2025-04-01', 'Present'),
(2, 2, '2025-04-01', 'Absent');

SELECT s.student_id, s.first_name, s.last_name, c.course_name 
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
JOIN Courses c ON e.course_id = c.course_id;

SELECT c.course_name, COUNT(e.student_id) AS total_students
FROM Courses c
LEFT JOIN Enrollments e ON c.course_id = e.course_id
GROUP BY c.course_name;

SELECT s.first_name, s.last_name, c.course_name, a.attendance_date, a.status
FROM Attendance a
JOIN Students s ON a.student_id = s.student_id
JOIN Courses c ON a.course_id = c.course_id
ORDER BY a.attendance_date DESC;

SELECT t.teacher_id, t.first_name, t.last_name, t.subject, c.course_name
FROM Teachers t
LEFT JOIN Courses c ON t.teacher_id = c.teacher_id;

















