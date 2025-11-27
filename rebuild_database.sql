-- ================================================
-- COMPLETE DATABASE RESET AND POPULATION SCRIPT
-- ================================================
-- This script completely rebuilds the academia database with clean data

DROP DATABASE IF EXISTS academia;
CREATE DATABASE academia;
USE academia;

-- ================================================
-- CREATE TABLES
-- ================================================

CREATE TABLE domain (
    id INT AUTO_INCREMENT PRIMARY KEY,
    program VARCHAR(255) NOT NULL,
    batch VARCHAR(255) NOT NULL,
    INDEX idx_program (program)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE faculty (
    id INT AUTO_INCREMENT PRIMARY KEY,
    f_name VARCHAR(255) NOT NULL,
    f_email VARCHAR(255) NOT NULL UNIQUE,
    INDEX idx_email (f_email)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE course (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    c_code VARCHAR(255) NOT NULL UNIQUE,
    credit INT NOT NULL,
    description VARCHAR(500) NULL,
    faculty_id INT NULL,
    FOREIGN KEY (faculty_id) REFERENCES faculty(id) ON DELETE SET NULL,
    INDEX idx_course_code (c_code),
    INDEX idx_faculty (faculty_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE schedule (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    time VARCHAR(50) NOT NULL,
    day VARCHAR(50) NOT NULL,
    room VARCHAR(50) NOT NULL,
    course_id BIGINT NULL,
    FOREIGN KEY (course_id) REFERENCES course(id) ON DELETE CASCADE,
    INDEX idx_course (course_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE student (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    rno VARCHAR(50) NOT NULL,
    email VARCHAR(255) NOT NULL,
    domain_id INT NULL,
    FOREIGN KEY (domain_id) REFERENCES domain(id) ON DELETE SET NULL,
    INDEX idx_domain (domain_id),
    INDEX idx_email (email)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE domain_course (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    domain_id INT NOT NULL,
    course_id BIGINT NOT NULL,
    FOREIGN KEY (domain_id) REFERENCES domain(id) ON DELETE CASCADE,
    FOREIGN KEY (course_id) REFERENCES course(id) ON DELETE CASCADE,
    UNIQUE KEY unique_domain_course (domain_id, course_id),
    INDEX idx_domain (domain_id),
    INDEX idx_course (course_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE student_course (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    course_id BIGINT NOT NULL,
    FOREIGN KEY (student_id) REFERENCES student(id) ON DELETE CASCADE,
    FOREIGN KEY (course_id) REFERENCES course(id) ON DELETE CASCADE,
    UNIQUE KEY unique_student_course (student_id, course_id),
    INDEX idx_student (student_id),
    INDEX idx_course (course_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Sequence tables for Hibernate
CREATE TABLE IF NOT EXISTS domain_seq (next_val BIGINT) ENGINE=InnoDB;
CREATE TABLE IF NOT EXISTS faculty_seq (next_val BIGINT) ENGINE=InnoDB;
CREATE TABLE IF NOT EXISTS course_seq (next_val BIGINT) ENGINE=InnoDB;
CREATE TABLE IF NOT EXISTS schedule_seq (next_val BIGINT) ENGINE=InnoDB;
CREATE TABLE IF NOT EXISTS student_seq (next_val BIGINT) ENGINE=InnoDB;
CREATE TABLE IF NOT EXISTS domain_course_seq (next_val BIGINT) ENGINE=InnoDB;
CREATE TABLE IF NOT EXISTS student_course_seq (next_val BIGINT) ENGINE=InnoDB;

INSERT INTO domain_seq VALUES (1);
INSERT INTO faculty_seq VALUES (1);
INSERT INTO course_seq VALUES (1);
INSERT INTO schedule_seq VALUES (1);
INSERT INTO student_seq VALUES (1);
INSERT INTO domain_course_seq VALUES (1);
INSERT INTO student_course_seq VALUES (1);

-- ================================================
-- POPULATE DOMAINS
-- ================================================
INSERT INTO domain (id, program, batch) VALUES
(1, 'iMTech CSE', '2025'),
(2, 'iMTech ECE', '2025'),
(3, 'iMTech DSAI', '2025'),
(4, 'MTech CSE', '2025'),
(5, 'MTech ECE', '2025'),
(6, 'MTech DSAI', '2025');

-- ================================================
-- POPULATE FACULTY
-- ================================================
INSERT INTO faculty (id, f_name, f_email) VALUES
(1, 'Dr. John Smith', 'john.smith@iiitb.ac.in'),
(2, 'Prof. Sarah Johnson', 'sarah.johnson@iiitb.ac.in'),
(3, 'Dr. Michael Brown', 'michael.brown@iiitb.ac.in'),
(4, 'Prof. Emily Davis', 'emily.davis@iiitb.ac.in'),
(5, 'Dr. Robert Wilson', 'robert.wilson@iiitb.ac.in'),
(6, 'Prof. Jennifer Garcia', 'jennifer.garcia@iiitb.ac.in'),
(7, 'Dr. David Martinez', 'david.martinez@iiitb.ac.in'),
(8, 'Prof. Lisa Anderson', 'lisa.anderson@iiitb.ac.in'),
(9, 'Dr. James Taylor', 'james.taylor@iiitb.ac.in'),
(10, 'Prof. Maria Rodriguez', 'maria.rodriguez@iiitb.ac.in'),
(11, 'Dr. Amit Sharma', 'amit.sharma@iiitb.ac.in'),
(12, 'Prof. Neha Patel', 'neha.patel@iiitb.ac.in'),
(13, 'Dr. Rajesh Kumar', 'rajesh.kumar@iiitb.ac.in'),
(14, 'Prof. Sneha Iyer', 'sneha.iyer@iiitb.ac.in'),
(15, 'Dr. Vikram Singh', 'vikram.singh@iiitb.ac.in');

-- ================================================
-- POPULATE COURSES
-- ================================================
INSERT INTO course (id, name, c_code, credit, faculty_id) VALUES
-- CS Courses (1-10)
(1, 'Programming Fundamentals', 'CS101', 4, 1),
(2, 'Data Structures', 'CS201', 4, 2),
(3, 'Algorithms', 'CS202', 4, 3),
(4, 'Database Systems', 'CS301', 3, 1),
(5, 'Operating Systems', 'CS302', 4, 2),
(6, 'Computer Networks', 'CS303', 3, 3),
(7, 'Software Engineering', 'CS401', 3, 1),
(8, 'Artificial Intelligence', 'CS402', 4, 11),
(9, 'Machine Learning', 'CS403', 4, 11),
(10, 'Cloud Computing', 'CS404', 3, 12),

-- ECE Courses (11-20)
(11, 'Digital Electronics', 'EC101', 4, 4),
(12, 'Analog Circuits', 'EC201', 4, 5),
(13, 'Signals and Systems', 'EC202', 3, 4),
(14, 'Communication Systems', 'EC301', 4, 5),
(15, 'VLSI Design', 'EC302', 3, 6),
(16, 'Embedded Systems', 'EC303', 4, 4),
(17, 'Microprocessors', 'EC401', 3, 5),
(18, 'Wireless Communication', 'EC402', 4, 6),
(19, 'Control Systems', 'EC403', 3, 4),
(20, 'IoT Systems', 'EC404', 4, 13),

-- DSAI Courses (21-30)
(21, 'Statistics', 'DS101', 3, 7),
(22, 'Data Mining', 'DS201', 4, 8),
(23, 'Deep Learning', 'DS301', 4, 9),
(24, 'Natural Language Processing', 'DS302', 3, 10),
(25, 'Computer Vision', 'DS303', 4, 7),
(26, 'Big Data Analytics', 'DS401', 4, 8),
(27, 'Data Visualization', 'DS402', 3, 9),
(28, 'Statistical Learning', 'DS403', 3, 10),
(29, 'Reinforcement Learning', 'DS404', 4, 14),
(30, 'AI Ethics', 'DS405', 3, 15),

-- General Courses (31-40)
(31, 'Research Methodology', 'GEN101', 3, 11),
(32, 'Technical Writing', 'GEN102', 2, 12),
(33, 'Innovation Management', 'GEN103', 3, 13),
(34, 'Project Management', 'GEN104', 3, 14),
(35, 'Ethics in Technology', 'GEN105', 2, 15);

-- ================================================
-- POPULATE SCHEDULES
-- ================================================
INSERT INTO schedule (id, time, day, room, course_id) VALUES
-- Monday
(1, '09:00 AM', 'Monday', 'R-101', 1),
(2, '10:00 AM', 'Monday', 'R-102', 2),
(3, '11:00 AM', 'Monday', 'Lab-1', 3),
(4, '12:00 PM', 'Monday', 'LH-1', 4),
(5, '02:00 PM', 'Monday', 'R-103', 11),
(6, '03:00 PM', 'Monday', 'Lab-2', 21),
(7, '04:00 PM', 'Monday', 'R-104', 31),

-- Tuesday  
(8, '09:00 AM', 'Tuesday', 'R-201', 5),
(9, '10:00 AM', 'Tuesday', 'Lab-3', 6),
(10, '11:00 AM', 'Tuesday', 'R-202', 12),
(11, '01:00 PM', 'Tuesday', 'LH-2', 13),
(12, '02:00 PM', 'Tuesday', 'R-203', 22),
(13, '03:00 PM', 'Tuesday', 'Lab-1', 23),
(14, '04:00 PM', 'Tuesday', 'R-204', 32),

-- Wednesday
(15, '09:00 AM', 'Wednesday', 'R-105', 7),
(16, '10:00 AM', 'Wednesday', 'R-106', 8),
(17, '11:00 AM', 'Wednesday', 'Lab-2', 14),
(18, '12:00 PM', 'Wednesday', 'LH-1', 15),
(19, '02:00 PM', 'Wednesday', 'R-107', 24),
(20, '03:00 PM', 'Wednesday', 'Lab-3', 25),
(21, '04:00 PM', 'Wednesday', 'R-108', 33),

-- Thursday
(22, '09:00 AM', 'Thursday', 'R-109', 9),
(23, '10:00 AM', 'Thursday', 'Lab-1', 10),
(24, '11:00 AM', 'Thursday', 'R-110', 16),
(25, '01:00 PM', 'Thursday', 'LH-2', 17),
(26, '02:00 PM', 'Thursday', 'R-111', 26),
(27, '03:00 PM', 'Thursday', 'Lab-2', 27),
(28, '04:00 PM', 'Thursday', 'R-112', 34),

-- Friday
(29, '09:00 AM', 'Friday', 'R-113', 18),
(30, '10:00 AM', 'Friday', 'R-114', 19),
(31, '11:00 AM', 'Friday', 'Lab-3', 20),
(32, '12:00 PM', 'Friday', 'LH-1', 28),
(33, '02:00 PM', 'Friday', 'R-115', 29),
(34, '03:00 PM', 'Friday', 'R-116', 30),
(35, '04:00 PM', 'Friday', 'R-117', 35);

-- ================================================
-- POPULATE DOMAIN-COURSE MAPPINGS
-- ================================================

-- iMTech CSE (Domain 1) - CS courses + general
INSERT INTO domain_course (domain_id, course_id) VALUES
(1, 1), (1, 2), (1, 3), (1, 4), (1, 5), (1, 6), (1, 7), (1, 8), (1, 9), (1, 10),
(1, 31), (1, 32), (1, 33), (1, 34), (1, 35);

-- iMTech ECE (Domain 2) - ECE courses + general
INSERT INTO domain_course (domain_id, course_id) VALUES
(2, 11), (2, 12), (2, 13), (2, 14), (2, 15), (2, 16), (2, 17), (2, 18), (2, 19), (2, 20),
(2, 31), (2, 32), (2, 33), (2, 34), (2, 35);

-- iMTech DSAI (Domain 3) - DSAI courses + ML courses + general
INSERT INTO domain_course (domain_id, course_id) VALUES
(3, 9), (3, 21), (3, 22), (3, 23), (3, 24), (3, 25), (3, 26), (3, 27), (3, 28), (3, 29), (3, 30),
(3, 31), (3, 32), (3, 33), (3, 34), (3, 35);

-- MTech CSE (Domain 4) - Advanced CS courses + general
INSERT INTO domain_course (domain_id, course_id) VALUES
(4, 4), (4, 5), (4, 6), (4, 7), (4, 8), (4, 9), (4, 10),
(4, 31), (4, 32), (4, 33), (4, 34), (4, 35);

-- MTech ECE (Domain 5) - Advanced ECE courses + general
INSERT INTO domain_course (domain_id, course_id) VALUES
(5, 14), (5, 15), (5, 16), (5, 17), (5, 18), (5, 19), (5, 20),
(5, 31), (5, 32), (5, 33), (5, 34), (5, 35);

-- MTech DSAI (Domain 6) - Advanced DSAI courses + general
INSERT INTO domain_course (domain_id, course_id) VALUES
(6, 23), (6, 24), (6, 25), (6, 26), (6, 27), (6, 28), (6, 29), (6, 30),
(6, 31), (6, 32), (6, 33), (6, 34), (6, 35);

-- ================================================
-- POPULATE STUDENTS
-- ================================================
INSERT INTO student (id, name, rno, email, domain_id) VALUES
-- iMTech CSE Students (1-10)
(1, 'Rahul Sharma', 'IMT2020001', 'rahul.sharma@iiitb.ac.in', 1),
(2, 'Priya Patel', 'IMT2020002', 'priya.patel@iiitb.ac.in', 1),
(3, 'Amit Kumar', 'IMT2020003', 'amit.kumar@iiitb.ac.in', 1),
(4, 'Sneha Reddy', 'IMT2020004', 'sneha.reddy@iiitb.ac.in', 1),
(5, 'Vikram Singh', 'IMT2020005', 'vikram.singh@iiitb.ac.in', 1),
(6, 'Anjali Desai', 'IMT2020006', 'anjali.desai@iiitb.ac.in', 1),
(7, 'Rohan Mehta', 'IMT2020007', 'rohan.mehta@iiitb.ac.in', 1),
(8, 'Pooja Iyer', 'IMT2020008', 'pooja.iyer@iiitb.ac.in', 1),
(9, 'Karan Joshi', 'IMT2020009', 'karan.joshi@iiitb.ac.in', 1),
(10, 'Divya Nair', 'IMT2020010', 'divya.nair@iiitb.ac.in', 1),

-- iMTech ECE Students (11-20)
(11, 'Aditya Gupta', 'IMT2020011', 'aditya.gupta@iiitb.ac.in', 2),
(12, 'Neha Shah', 'IMT2020012', 'neha.shah@iiitb.ac.in', 2),
(13, 'Siddharth Rao', 'IMT2020013', 'siddharth.rao@iiitb.ac.in', 2),
(14, 'Riya Kapoor', 'IMT2020014', 'riya.kapoor@iiitb.ac.in', 2),
(15, 'Arjun Verma', 'IMT2020015', 'arjun.verma@iiitb.ac.in', 2),
(16, 'Kavya Agarwal', 'IMT2020016', 'kavya.agarwal@iiitb.ac.in', 2),
(17, 'Nikhil Bhat', 'IMT2020017', 'nikhil.bhat@iiitb.ac.in', 2),
(18, 'Shruti Menon', 'IMT2020018', 'shruti.menon@iiitb.ac.in', 2),
(19, 'Varun Pillai', 'IMT2020019', 'varun.pillai@iiitb.ac.in', 2),
(20, 'Tanya Chopra', 'IMT2020020', 'tanya.chopra@iiitb.ac.in', 2),

-- iMTech DSAI Students (21-30)
(21, 'Vivek Mishra', 'IMT2020021', 'vivek.mishra@iiitb.ac.in', 3),
(22, 'Pallavi Sharma', 'IMT2020022', 'pallavi.sharma@iiitb.ac.in', 3),
(23, 'Karthik Reddy', 'IMT2020023', 'karthik.reddy@iiitb.ac.in', 3),
(24, 'Swati Verma', 'IMT2020024', 'swati.verma@iiitb.ac.in', 3),
(25, 'Deepak Kumar', 'IMT2020025', 'deepak.kumar@iiitb.ac.in', 3),
(26, 'Ananya Das', 'IMT2020026', 'ananya.das@iiitb.ac.in', 3),
(27, 'Rajat Khanna', 'IMT2020027', 'rajat.khanna@iiitb.ac.in', 3),
(28, 'Nisha Joshi', 'IMT2020028', 'nisha.joshi@iiitb.ac.in', 3),
(29, 'Akash Tiwari', 'IMT2020029', 'akash.tiwari@iiitb.ac.in', 3),
(30, 'Preeti Gupta', 'IMT2020030', 'preeti.gupta@iiitb.ac.in', 3),

-- MTech CSE Students (31-40)
(31, 'Sahil Chawla', 'MT2021001', 'sahil.chawla@iiitb.ac.in', 4),
(32, 'Madhuri Rao', 'MT2021002', 'madhuri.rao@iiitb.ac.in', 4),
(33, 'Yash Patil', 'MT2021003', 'yash.patil@iiitb.ac.in', 4),
(34, 'Sakshi Bhatt', 'MT2021004', 'sakshi.bhatt@iiitb.ac.in', 4),
(35, 'Mohit Chauhan', 'MT2021005', 'mohit.chauhan@iiitb.ac.in', 4),
(36, 'Tanvi Malhotra', 'MT2021006', 'tanvi.malhotra@iiitb.ac.in', 4),
(37, 'Sameer Bose', 'MT2021007', 'sameer.bose@iiitb.ac.in', 4),
(38, 'Kritika Arora', 'MT2021008', 'kritika.arora@iiitb.ac.in', 4),
(39, 'Ayush Thakur', 'MT2021009', 'ayush.thakur@iiitb.ac.in', 4),
(40, 'Poornima Hegde', 'MT2021010', 'poornima.hegde@iiitb.ac.in', 4),

-- MTech ECE Students (41-50)
(41, 'Manish Jain', 'MT2021011', 'manish.jain@iiitb.ac.in', 5),
(42, 'Aarti Pandey', 'MT2021012', 'aarti.pandey@iiitb.ac.in', 5),
(43, 'Gaurav Saxena', 'MT2021013', 'gaurav.saxena@iiitb.ac.in', 5),
(44, 'Ritika Sinha', 'MT2021014', 'ritika.sinha@iiitb.ac.in', 5),
(45, 'Abhishek Dubey', 'MT2021015', 'abhishek.dubey@iiitb.ac.in', 5),

-- MTech DSAI Students (46-50)
(46, 'Megha Kulkarni', 'MT2021016', 'megha.kulkarni@iiitb.ac.in', 6),
(47, 'Sanjay Malhotra', 'MT2021017', 'sanjay.malhotra@iiitb.ac.in', 6),
(48, 'Ishita Bansal', 'MT2021018', 'ishita.bansal@iiitb.ac.in', 6),
(49, 'Harsh Agrawal', 'MT2021019', 'harsh.agrawal@iiitb.ac.in', 6),
(50, 'Simran Kaur', 'MT2021020', 'simran.kaur@iiitb.ac.in', 6);

-- ================================================
-- POPULATE STUDENT ENROLLMENTS
-- ================================================

-- CS Courses Enrollments
INSERT INTO student_course (student_id, course_id) VALUES
(1,1),(2,1),(3,1),(4,1),(5,1),(6,1),
(1,2),(2,2),(3,2),(7,2),(8,2),
(4,3),(5,3),(6,3),(9,3),(10,3),
(1,4),(2,4),(31,4),(32,4),(33,4),
(3,5),(4,5),(34,5),(35,5),(36,5),
(5,6),(6,6),(37,6),(38,6),
(7,7),(8,7),(9,7),(31,7),(32,7),
(1,8),(3,8),(33,8),(34,8),(35,8),
(2,9),(4,9),(21,9),(22,9),(31,9),
(5,10),(36,10),(37,10),(38,10);

-- ECE Courses Enrollments
INSERT INTO student_course (student_id, course_id) VALUES
(11,11),(12,11),(13,11),(14,11),(15,11),(16,11),
(11,12),(12,12),(17,12),(18,12),
(13,13),(14,13),(19,13),(20,13),
(11,14),(15,14),(41,14),(42,14),(43,14),
(12,15),(16,15),(44,15),(45,15),
(13,16),(17,16),(41,16),(42,16),
(14,17),(18,17),(43,17),(44,17),
(15,18),(19,18),(45,18),
(16,19),(20,19),(41,19),
(11,20),(17,20),(42,20),(43,20);

-- DSAI Courses Enrollments
INSERT INTO student_course (student_id, course_id) VALUES
(21,21),(22,21),(23,21),(24,21),(25,21),
(21,22),(26,22),(27,22),(28,22),
(22,23),(23,23),(46,23),(47,23),(48,23),
(24,24),(25,24),(49,24),(50,24),
(26,25),(27,25),(46,25),(47,25),
(21,26),(28,26),(48,26),(49,26),(50,26),
(22,27),(29,27),(30,27),
(23,28),(24,28),(46,28),(47,28),
(25,29),(26,29),(48,29),(49,29),
(27,30),(28,30),(29,30),(30,30),(50,30);

-- General Courses Enrollments (everyone)
INSERT INTO student_course (student_id, course_id) VALUES
(1,31),(11,31),(21,31),(31,31),(41,31),(46,31),
(2,32),(12,32),(22,32),(32,32),(42,32),(47,32),
(3,33),(13,33),(23,33),(33,33),(43,33),(48,33),
(4,34),(14,34),(24,34),(34,34),(44,34),(49,34),
(5,35),(15,35),(25,35),(35,35),(45,35),(50,35);

-- ================================================
-- VERIFICATION QUERIES
-- ================================================
SELECT 'Database rebuild complete!' AS Status;
SELECT '=' AS Separator;
SELECT 'Domains:' AS Info, COUNT(*) AS Count FROM domain;
SELECT 'Faculty:' AS Info, COUNT(*) AS Count FROM faculty;
SELECT 'Courses:' AS Info, COUNT(*) AS Count FROM course;
SELECT 'Schedules:' AS Info, COUNT(*) AS Count FROM schedule;
SELECT 'Students:' AS Info, COUNT(*) AS Count FROM student;
SELECT '=' AS Separator;
SELECT d.program AS Domain, COUNT(dc.course_id) AS Courses
FROM domain d
LEFT JOIN domain_course dc ON d.id = dc.domain_id
GROUP BY d.id, d.program
ORDER BY d.id;
