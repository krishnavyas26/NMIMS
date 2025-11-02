DROP DATABASE IF EXISTS elearning_platform;
CREATE DATABASE elearning_platform;
USE elearning_platform;

CREATE TABLE courses(
    course_id INT PRIMARY KEY,
    title VARCHAR(100),
    category VARCHAR(100),
    duration_weeks INT,
    price DECIMAL(5,2)
);

CREATE TABLE instructors(
    instructor_id INT PRIMARY KEY,
    instructor_name VARCHAR(100),
    instructor_email VARCHAR(100),
    speciality VARCHAR(100)
);

CREATE TABLE students(
    student_id INT PRIMARY KEY,
    student_name VARCHAR(100),
    student_email VARCHAR(100),
    student_city VARCHAR(100)
);

CREATE TABLE enrollments(
    enrollment_id INT PRIMARY KEY,
    student_id INT,
    course_id INT,
    enroll_date DATE,
    enroll_status VARCHAR(50),
    FOREIGN KEY (course_id) REFERENCES courses(course_id),
    FOREIGN KEY (student_id) REFERENCES students(student_id)
);

CREATE TABLE assignments(
    assignment_id INT PRIMARY KEY,
    course_id INT,
    assignment_title VARCHAR(100),
    due_date DATE,
    maxmarks INT,
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

CREATE TABLE course_instructors (
    course_id INT,
    instructor_id INT,
    PRIMARY KEY (course_id, instructor_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id),
    FOREIGN KEY (instructor_id) REFERENCES instructors(instructor_id)
);

CREATE TABLE student_assignments (
    submission_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT,
    assignment_id INT,
    submission_date DATE,
    marks_obtained INT,
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (assignment_id) REFERENCES assignments(assignment_id)
);

INSERT INTO instructors VALUES
(1, "Hiren", "hiren@gmail.com", "breathing"),
(2, "Sheetal", "sheetal@gmail.com", "breathing"),
(3, "Rishabh", "rishabh@gmail.com", "poses"),
(4, "Pratham", "pratham@gmail.com", "asanas"),
(5, "Adithi", "adithi@gmail.com", "mind");

INSERT INTO courses VALUES
(1, "Differential_Calculus", "maths", 5, 100.00),
(2, "Data_Science", "Statistics", 7, 200.00),
(3, "Python", "coding", 10, 250.00),
(4, "Effective_Communication", "Language", 1, 500.00),
(5, "Yoga", "physical", 2, 300.00);

INSERT INTO students VALUES
(1, "Krishna", "krishna@gmail.com", "Mumbai"),
(2, "Nafsiha", "nafsiha@gmail.com", "Mumbai"),
(3, "Muskan", "muskan@gmail.com", "Delhi"),
(4, "Advait", "advait@gmail.com", "Delhi"),
(5, "Sanea", "sanea@gmail.com", "Assam");

INSERT INTO enrollments VALUES
(1, 1, 1, "2008-11-06", "done"),
(2, 2, 2, "2008-11-07", "notdone"),
(3, 3, 3, "2008-11-08", "notdone"),
(4, 4, 4, "2008-11-09", "notdone"),
(5, 5, 5, "2008-11-10", "notdone");

INSERT INTO assignments VALUES
(1, 1, "integration", "2009-04-05", 100),
(2, 2, "binomial", "2009-04-06", 100),
(3, 3, "for_loop", "2009-04-07", 100),
(4, 4, "speaking", "2009-04-08", 100),
(5, 5, "asanas", "2009-04-09", 100);

INSERT INTO course_instructors VALUES
(1, 1),
(1, 2),
(2, 1),
(3, 3),
(4, 4),
(5, 5);

INSERT INTO student_assignments VALUES
(1, 1, 1, "2009-04-04", 95),
(2, 1, 2, "2009-04-05", 88),
(3, 2, 3, "2009-04-06", 75),
(4, 3, 3, "2009-04-07", 90),
(5, 4, 4, "2009-04-08", 80),
(6, 5, 5, "2009-04-09", 92);

-- 1
SELECT * FROM courses WHERE category = 'Data Science';

-- 2
SELECT * FROM instructors WHERE speciality = 'Python';

-- 3
SELECT student_name FROM students WHERE student_city = 'Mumbai';

-- 4
SELECT * FROM enrollments WHERE enroll_date >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH);

-- 5
SELECT * FROM courses WHERE duration_weeks > 8;

-- 6
SELECT * FROM courses ORDER BY price DESC LIMIT 3;

-- 7
SELECT student_name FROM students 
WHERE student_id IN (
  SELECT student_id FROM enrollments
  WHERE course_id = (
    SELECT course_id FROM courses WHERE title = 'Python'
  )
);

-- 8
SELECT instructor_name FROM instructors 
WHERE instructor_id IN (
  SELECT instructor_id FROM course_instructors
  GROUP BY instructor_id
  HAVING COUNT(course_id) > 1
);

-- 9
SELECT * FROM assignments
WHERE due_date BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 7 DAY);


-- 11
SELECT title, (
  SELECT AVG(marks_obtained)
  FROM assignments a JOIN student_assignments sa
    ON a.assignment_id = sa.assignment_id
  WHERE a.course_id = c.course_id
) AS average_marks
FROM courses c;

-- 12
SELECT student_name FROM students WHERE student_id NOT IN (
  SELECT student_id FROM enrollments
);

-- 13
SELECT title, (
  SELECT COUNT(*) FROM enrollments e WHERE e.course_id = c.course_id
) AS total_enrollments
FROM courses c;

-- 14
SELECT instructor_name FROM instructors WHERE instructor_id NOT IN (
  SELECT instructor_id FROM course_instructors
);

-- 15
SELECT student_name FROM students WHERE student_id IN (
  SELECT student_id FROM enrollments GROUP BY student_id HAVING COUNT(*) > 3
);

-- 16
SELECT title FROM courses WHERE course_id NOT IN (
  SELECT course_id FROM enrollments
);

-- 17
SELECT title FROM courses WHERE course_id = (
  SELECT course_id FROM enrollments
  GROUP BY course_id
  ORDER BY COUNT(*) DESC LIMIT 1
);

-- 18
SELECT title, (
  SELECT GROUP_CONCAT(a.assignment_title SEPARATOR ', ')
  FROM assignments a WHERE a.course_id = c.course_id
) AS assignments_list
FROM courses c;



-- 20
SELECT title, (
  SELECT GROUP_CONCAT(instructor_name SEPARATOR ', ')
  FROM instructors i WHERE i.instructor_id IN (
    SELECT instructor_id FROM course_instructors ci
    WHERE ci.course_id = c.course_id
  )
) AS instructors
FROM courses c;

-- 21
SELECT * FROM courses WHERE price < 5000;

-- 22
SELECT * FROM courses WHERE title LIKE '%Al%';

-- 24
SELECT YEAR(enroll_date) AS enrollment_year, MONTH(enroll_date) AS enrollment_month, COUNT(*) AS total_enrollments
FROM enrollments
GROUP BY YEAR(enroll_date), MONTH(enroll_date)
ORDER BY YEAR(enroll_date), MONTH(enroll_date);


