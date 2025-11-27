-- Add students for EXISTING courses only
USE academia;

-- Add 50 sample students  
INSERT IGNORE INTO student (id, name, rno, email) VALUES
(1, 'Rahul Sharma', 'IMT2020001', 'rahul.sharma@iiitb.ac.in'),
(2, 'Priya Patel', 'IMT2020002', 'priya.patel@iiitb.ac.in'),
(3, 'Amit Kumar', 'IMT2020003', 'amit.kumar@iiitb.ac.in'),
(4, 'Sneha Reddy', 'IMT2020004', 'sneha.reddy@iiitb.ac.in'),
(5, 'Vikram Singh', 'IMT2020005', 'vikram.singh@iiitb.ac.in'),
(6, 'Anjali Desai', 'IMT2020006', 'anjali.desai@iiitb.ac.in'),
(7, 'Rohan Mehta', 'IMT2020007', 'rohan.mehta@iiitb.ac.in'),
(8, 'Pooja Iyer', 'IMT2020008', 'pooja.iyer@iiitb.ac.in'),
(9, 'Karan Joshi', 'IMT2020009', 'karan.joshi@iiitb.ac.in'),
(10, 'Divya Nair', 'IMT2020010', 'divya.nair@iiitb.ac.in'),
(11, 'Aditya Gupta', 'IMT2020011', 'aditya.gupta@iiitb.ac.in'),
(12, 'Neha Shah', 'IMT2020012', 'neha.shah@iiitb.ac.in'),
(13, 'Siddharth Rao', 'IMT2020013', 'siddharth.rao@iiitb.ac.in'),
(14, 'Riya Kapoor', 'IMT2020014', 'riya.kapoor@iiitb.ac.in'),
(15, 'Arjun Verma', 'IMT2020015', 'arjun.verma@iiitb.ac.in'),
(16, 'Kavya Agarwal', 'IMT2020016', 'kavya.agarwal@iiitb.ac.in'),
(17, 'Nikhil Bhat', 'IMT2020017', 'nikhil.bhat@iiitb.ac.in'),
(18, 'Shruti Menon', 'IMT2020018', 'shruti.menon@iiitb.ac.in'),
(19, 'Varun Pillai', 'IMT2020019', 'varun.pillai@iiitb.ac.in'),
(20, 'Tanya Chopra', 'IMT2020020', 'tanya.chopra@iiitb.ac.in'),
(21, 'Abhishek Dubey', 'IMT2020021', 'abhishek.dubey@iiitb.ac.in'),
(22, 'Megha Kulkarni', 'IMT2020022', 'megha.kulkarni@iiitb.ac.in'),
(23, 'Sanjay Malhotra', 'IMT2020023', 'sanjay.malhotra@iiitb.ac.in'),
(24, 'Ishita Bansal', 'IMT2020024', 'ishita.bansal@iiitb.ac.in'),
(25, 'Harsh Agrawal', 'IMT2020025', 'harsh.agrawal@iiitb.ac.in'),
(26, 'Simran Kaur', 'IMT2020026', 'simran.kaur@iiitb.ac.in'),
(27, 'Manish Jain', 'IMT2020027', 'manish.jain@iiitb.ac.in'),
(28, 'Aarti Pandey', 'IMT2020028', 'aarti.pandey@iiitb.ac.in'),
(29, 'Gaurav Saxena', 'IMT2020029', 'gaurav.saxena@iiitb.ac.in'),
(30, 'Ritika Sinha', 'IMT2020030', 'ritika.sinha@iiitb.ac.in'),
(31, 'Vivek Mishra', 'IMT2020031', 'vivek.mishra@iiitb.ac.in'),
(32, 'Pallavi Sharma', 'IMT2020032', 'pallavi.sharma@iiitb.ac.in'),
(33, 'Karthik Reddy', 'IMT2020033', 'karthik.reddy@iiitb.ac.in'),
(34, 'Swati Verma', 'IMT2020034', 'swati.verma@iiitb.ac.in'),
(35, 'Deepak Kumar', 'IMT2020035', 'deepak.kumar@iiitb.ac.in'),
(36, 'Ananya Das', 'IMT2020036', 'ananya.das@iiitb.ac.in'),
(37, 'Rajat Khanna', 'IMT2020037',  'rajat.khanna@iiitb.ac.in'),
(38, 'Nisha Joshi', 'IMT2020038', 'nisha.joshi@iiitb.ac.in'),
(39, 'Akash Tiwari', 'IMT2020039', 'akash.tiwari@iiitb.ac.in'),
(40, 'Preeti Gupta', 'IMT2020040', 'preeti.gupta@iiitb.ac.in'),
(41, 'Sahil Chawla', 'IMT2020041', 'sahil.chawla@iiitb.ac.in'),
(42, 'Madhuri Rao', 'IMT2020042', 'madhuri.rao@iiitb.ac.in'),
(43, 'Yash Patil', 'IMT2020043', 'yash.patil@iiitb.ac.in'),
(44, 'Sakshi Bhatt', 'IMT2020044', 'sakshi.bhatt@iiitb.ac.in'),
(45, 'Mohit Chauhan', 'IMT2020045', 'mohit.chauhan@iiitb.ac.in'),
(46, 'Tanvi Malhotra', 'MT2021001', 'tanvi.malhotra@iiitb.ac.in'),
(47, 'Sameer Bose', 'MT2021002', 'sameer.bose@iiitb.ac.in'),
(48, 'Kritika Arora', 'MT2021003', 'kritika.arora@iiitb.ac.in'),
(49, 'Ayush Thakur', 'MT2021004', 'ayush.thakur@iiitb.ac.in'),
(50, 'Poornima Hegde', 'MT2021005', 'poornima.hegde@iiitb.ac.in');

-- Clear existing enrollments
DELETE FROM student_course;

-- Enroll students ONLY in courses that exist (121-140)
-- Course 121: Artificial Intelligence
INSERT INTO student_course (student_id, course_id) VALUES
(1, 121), (2, 121), (3, 121), (4, 121), (5, 121), (11, 121), (12, 121), (13, 121);

-- Course 122: Advanced Algorithms
INSERT INTO student_course (student_id, course_id) VALUES
(6, 122), (7, 122), (8, 122), (14, 122), (15, 122), (46, 122);

-- Course 123: System Design
INSERT INTO student_course (student_id, course_id) VALUES
(9, 123), (10, 123), (16, 123), (17, 123), (47, 123), (48, 123);

-- Course 124: Cyber Security
INSERT INTO student_course (student_id, course_id) VALUES
(1, 124), (18, 124), (19, 124), (20, 124), (49, 124), (50, 124);

-- Course 125: Big Data Analytics
INSERT INTO student_course (student_id, course_id) VALUES
(21, 125), (22, 125), (31, 125), (32, 125), (33, 125), (34, 125), (35, 125);

-- Course 126: VLSI Design
INSERT INTO student_course (student_id, course_id) VALUES
(16, 126), (17, 126), (18, 126), (23, 126), (24, 126);

-- Course 127: Embedded Systems
INSERT INTO student_course (student_id, course_id) VALUES
(19, 127), (20, 127), (25, 127), (26, 127), (27, 127), (28, 127);

-- Course 128: Communication Systems
INSERT INTO student_course (student_id, course_id) VALUES
(21, 128), (22, 128), (29, 128), (30, 128);

-- Course 129: Microprocessors
INSERT INTO student_course (student_id, course_id) VALUES
(23, 129), (24, 129), (25, 129), (26, 129), (27, 129);

-- Course 130: Control Systems
INSERT INTO student_course (student_id, course_id) VALUES
(28, 130), (29, 130), (30, 130), (46, 130), (47, 130);

-- Course 131: Deep Learning
INSERT INTO student_course (student_id, course_id) VALUES
(31, 131), (32, 131), (33, 131), (34, 131), (35, 131), (36, 131), (37, 131), (38, 131);

-- Course 132: Natural Language Processing
INSERT INTO student_course (student_id, course_id) VALUES
(39, 132), (40, 132), (41, 132), (48, 132), (49, 132);

-- Course 133: Computer Vision
INSERT INTO student_course (student_id, course_id) VALUES
(42, 133), (43, 133), (44, 133), (45, 133), (50, 133);

-- Course 134: Statistical Methods
INSERT INTO student_course (student_id, course_id) VALUES
(31, 134), (32, 134), (33, 134), (34, 134), (35, 134), (36, 134);

-- Course 135: Data Visualization
INSERT INTO student_course (student_id, course_id) VALUES
(37, 135), (38, 135), (39, 135), (40, 135), (41, 135);

-- Course 136: Research Methodology
INSERT INTO student_course (student_id, course_id) VALUES
(1, 136), (2, 136), (3, 136), (4, 136), (5, 136), (11, 136), (12, 136);

-- Course 137: Technical Writing
INSERT INTO student_course (student_id, course_id) VALUES
(6, 137), (7, 137), (13, 137), (14, 137), (15, 137);

-- Course 138: Innovation Management
INSERT INTO student_course (student_id, course_id) VALUES
(8, 138), (9, 138), (10, 138), (16, 138), (17, 138), (18, 138);

-- Course 139: Ethics in Technology
INSERT INTO student_course (student_id, course_id) VALUES
(19, 139), (20, 139), (21, 139), (22, 139), (46, 139), (47, 139);

-- Course 140: Project Management
INSERT INTO student_course (student_id, course_id) VALUES
(23, 140), (24, 140), (25, 140), (48, 140), (49, 140), (50, 140);

SELECT 'Student enrollments complete! 50 students added to courses 121-140.' AS Status;
