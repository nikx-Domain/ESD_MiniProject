-- ================================================
-- INSERT SAMPLE DATA FOR COURSE TIMETABLE MODULE
-- ================================================
-- This script inserts sample data for testing the Course TimeTable functionality
-- Generated for: ESD Mini-Project Deliverable #2
-- Module: 2.5 Course TimeTable
-- ================================================

-- ================================================
-- INSERT DOMAINS
-- ================================================
INSERT INTO domain (id, program, batch) VALUES
(1, 'iMTech CSE', '2025'),
(2, 'iMTech ECE', '2025'),
(3, 'iMTech DSAI', '2025'),
(4, 'MTech CSE', '2025'),
(5, 'MTech ECE', '2025'),
(6, 'MTech DSAI', '2025');

-- ================================================
-- INSERT FACULTY
-- ================================================
INSERT INTO faculty (id, f_name, f_email) VALUES
(1, 'Dr. Amit Sharma', 'amit.sharma@iiitb.ac.in'),
(2, 'Prof. Meera Rao', 'meera.rao@iiitb.ac.in'),
(3, 'Dr. Rajesh Iyer', 'rajesh.iyer@iiitb.ac.in'),
(4, 'Prof. Sunita Gupta', 'sunita.gupta@iiitb.ac.in'),
(5, 'Dr. Vikram Singh', 'vikram.singh@iiitb.ac.in'),
(6, 'Prof. Anita Desai', 'anita.desai@iiitb.ac.in'),
(7, 'Dr. Karthik Menon', 'karthik.menon@iiitb.ac.in'),
(8, 'Prof. Priya Nair', 'priya.nair@iiitb.ac.in'),
(9, 'Dr. Suresh Kumar', 'suresh.kumar@iiitb.ac.in'),
(10, 'Prof. Lakshmi Iyer', 'lakshmi.iyer@iiitb.ac.in');

-- ================================================
-- INSERT COURSES
-- ================================================
INSERT INTO course (id, name, c_code, credit, description, faculty_id) VALUES
(101, 'Introduction to Programming', 'CS101', 4, 'Fundamentals of programming using Python', 1),
(102, 'Digital Circuits', 'EC101', 3, 'Digital logic design and circuits', 2),
(103, 'Linear Algebra for AI', 'DS101', 4, 'Mathematical foundations for data science', 3),
(104, 'Data Structures & Algorithms', 'CS202', 4, 'Advanced data structures and algorithm design', 4),
(105, 'Advanced Machine Learning', 'MT501', 4, 'Deep learning and neural networks', 5),
(106, 'Signal Processing', 'EC202', 3, 'Digital signal processing techniques', 6),
(107, 'Database Management Systems', 'CS301', 4, 'Relational databases and SQL', 7),
(108, 'Computer Networks', 'CS302', 3, 'Network protocols and architecture', 8),
(109, 'Statistical Methods', 'DS202', 4, 'Statistical analysis for data science', 9),
(110, 'Embedded Systems', 'EC301', 3, 'Microcontroller programming', 10);

-- ================================================
-- INSERT SCHEDULES
-- ================================================
INSERT INTO schedule (id, time, day, room, course_id) VALUES
(1, '09:00 AM', 'Monday', 'R-101', 101),
(2, '11:00 AM', 'Tuesday', 'R-102', 102),
(3, '02:00 PM', 'Wednesday', 'LH-2', 103),
(4, '10:00 AM', 'Thursday', 'LH-1', 104),
(5, '03:00 PM', 'Friday', 'Lab-3', 105),
(6, '09:00 AM', 'Tuesday', 'R-103', 106),
(7, '11:00 AM', 'Wednesday', 'Lab-1', 107),
(8, '02:00 PM', 'Thursday', 'R-104', 108),
(9, '10:00 AM', 'Friday', 'LH-3', 109),
(10, '03:00 PM', 'Monday', 'Lab-2', 110);

-- ================================================
-- INSERT STUDENTS
-- ================================================
INSERT INTO student (id, name, rno, email, domain_id) VALUES
(1, 'Rahul Verma', 'IMT2025001', 'rahul.verma@iiitb.ac.in', 1),
(2, 'Priya Sharma', 'IMT2025002', 'priya.sharma@iiitb.ac.in', 1),
(3, 'Amit Patel', 'IMT2025003', 'amit.patel@iiitb.ac.in', 2),
(4, 'Sneha Reddy', 'IMT2025004', 'sneha.reddy@iiitb.ac.in', 2),
(5, 'Vikram Singh', 'IMT2025005', 'vikram.singh.student@iiitb.ac.in', 3),
(6, 'Anjali Gupta', 'IMT2025006', 'anjali.gupta@iiitb.ac.in', 3),
(7, 'Karthik Menon', 'MT2025001', 'karthik.menon.student@iiitb.ac.in', 4),
(8, 'Divya Nair', 'MT2025002', 'divya.nair@iiitb.ac.in', 4),
(9, 'Suresh Kumar', 'MT2025003', 'suresh.kumar.student@iiitb.ac.in', 5),
(10, 'Lakshmi Iyer', 'MT2025004', 'lakshmi.iyer.student@iiitb.ac.in', 5),
(11, 'Rajesh Krishnan', 'MT2025005', 'rajesh.krishnan@iiitb.ac.in', 6),
(12, 'Meera Desai', 'MT2025006', 'meera.desai@iiitb.ac.in', 6);

-- ================================================
-- INSERT DOMAIN-COURSE MAPPINGS
-- ================================================
-- iMTech CSE courses
INSERT INTO domain_course (domain_id, course_id) VALUES
(1, 101), -- Introduction to Programming
(1, 104), -- Data Structures & Algorithms
(1, 107); -- Database Management Systems

-- iMTech ECE courses
INSERT INTO domain_course (domain_id, course_id) VALUES
(2, 102), -- Digital Circuits
(2, 106), -- Signal Processing
(2, 110); -- Embedded Systems

-- iMTech DSAI courses
INSERT INTO domain_course (domain_id, course_id) VALUES
(3, 103), -- Linear Algebra for AI
(3, 109); -- Statistical Methods

-- MTech CSE courses
INSERT INTO domain_course (domain_id, course_id) VALUES
(4, 104), -- Data Structures & Algorithms
(4, 107), -- Database Management Systems
(4, 108); -- Computer Networks

-- MTech ECE courses
INSERT INTO domain_course (domain_id, course_id) VALUES
(5, 102), -- Digital Circuits
(5, 106), -- Signal Processing
(5, 110); -- Embedded Systems

-- MTech DSAI courses
INSERT INTO domain_course (domain_id, course_id) VALUES
(6, 105), -- Advanced Machine Learning
(6, 109); -- Statistical Methods

-- ================================================
-- INSERT STUDENT-COURSE ENROLLMENTS
-- ================================================
-- iMTech CSE students
INSERT INTO student_course (student_id, course_id) VALUES
(1, 101), (1, 104), (1, 107),
(2, 101), (2, 104), (2, 107);

-- iMTech ECE students
INSERT INTO student_course (student_id, course_id) VALUES
(3, 102), (3, 106), (3, 110),
(4, 102), (4, 106), (4, 110);

-- iMTech DSAI students
INSERT INTO student_course (student_id, course_id) VALUES
(5, 103), (5, 109),
(6, 103), (6, 109);

-- MTech CSE students
INSERT INTO student_course (student_id, course_id) VALUES
(7, 104), (7, 107), (7, 108),
(8, 104), (8, 107), (8, 108);

-- MTech ECE students
INSERT INTO student_course (student_id, course_id) VALUES
(9, 102), (9, 106), (9, 110),
(10, 102), (10, 106), (10, 110);

-- MTech DSAI students
INSERT INTO student_course (student_id, course_id) VALUES
(11, 105), (11, 109),
(12, 105), (12, 109);

-- ================================================
-- END OF INSERT DATA SCRIPT
-- ================================================
