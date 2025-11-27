-- Populate comprehensive data for all domains matching your schema
USE academia;

-- Note: Using faculty_id (not f_id), and student table has 'name' and 'rno' columns

-- Clear existing domain_course mappings
DELETE FROM domain_course;

-- Add more faculty members
INSERT IGNORE INTO faculty (id, f_name, f_email) VALUES
(21, 'Dr. Amit Sharma', 'amit.sharma@iiitb.ac.in'),
(22, 'Prof. Neha Patel', 'neha.patel@iiitb.ac.in'),
(23, 'Dr. Rajesh Kumar', 'rajesh.kumar@iiitb.ac.in'),
(24, 'Prof. Sneha Iyer', 'sneha.iyer@iiitb.ac.in'),
(25, 'Dr. Vikram Singh', 'vikram.singh@iiitb.ac.in'),
(26, 'Prof. Pooja Mehta', 'pooja.mehta@iiitb.ac.in'),
(27, 'Dr. Arun Desai', 'arun.desai@iiitb.ac.in'),
(28, 'Prof. Divya Rao', 'divya.rao@iiitb.ac.in'),
(29, 'Dr. Manoj Joshi', 'manoj.joshi@iiitb.ac.in'),
(30, 'Prof. Ritu Agarwal', 'ritu.agarwal@iiitb.ac.in');

-- Add more courses (IDs 121-140) using faculty_id
INSERT IGNORE INTO course (id, credit, name, c_code, faculty_id) VALUES
-- Computer Science Courses
(121, 4, 'Artificial Intelligence', 'CS402', 21),
(122, 3, 'Advanced Algorithms', 'CS403', 22),
(123, 4, 'System Design', 'CS404', 23),
(124, 3, 'Cyber Security', 'CS405', 1),
(125, 4, 'Big Data Analytics', 'CS406', 2),

-- Electronics Courses
(126, 4, 'VLSI Design', 'EC301', 24),
(127, 3, 'Embedded Systems', 'EC302', 25),
(128, 4, 'Communication Systems', 'EC303', 26),
(129, 3, 'Microprocessors', 'EC304', 4),
(130, 4, 'Control Systems', 'EC305', 5),

-- Data Science Courses
(131, 4, 'Deep Learning', 'DS301', 27),
(132, 3, 'Natural Language Processing', 'DS302', 28),
(133, 4, 'Computer Vision', 'DS303', 29),
(134, 3, 'Statistical Methods', 'DS304', 30),
(135, 4, 'Data Visualization', 'DS305', 10),

-- Additional General Courses
(136, 3, 'Research Methodology', 'GEN101', 21),
(137, 3, 'Technical Writing', 'GEN102', 22),
(138, 4, 'Innovation Management', 'GEN103', 23),
(139, 3, 'Ethics in Technology', 'GEN104', 24),
(140, 4, 'Project Management', 'GEN105', 25);

-- Add schedules for new courses - using course_id
INSERT IGNORE INTO schedule (id, time, day, room, course_id) VALUES
-- Monday schedules
(121, '09:00 AM', 'Monday', 'R-301', 121),
(122, '10:00 AM', 'Monday', 'Lab-2', 122),
(123, '12:00 PM', 'Monday', 'LH-2', 123),
(124, '01:00 PM', 'Monday', 'R-105', 124),
(125, '03:00 PM', 'Monday', 'Lab-3', 125),

-- Tuesday schedules
(126, '09:00 AM', 'Tuesday', 'R-106', 126),
(127, '11:00 AM', 'Tuesday', 'Lab-1', 127),
(128, '01:00 PM', 'Tuesday', 'LH-1', 128),
(129, '03:00 PM', 'Tuesday', 'R-107', 129),
(130, '04:00 PM', 'Tuesday', 'Lab-2', 130),

-- Wednesday schedules
(131, '09:00 AM', 'Wednesday', 'R-108', 131),
(132, '10:00 AM', 'Wednesday', 'Lab-3', 132),
(133, '12:00 PM', 'Wednesday', 'LH-2', 133),
(134, '02:00 PM', 'Wednesday', 'R-109', 134),
(135, '04:00 PM', 'Wednesday', 'Lab-1', 135),

-- Thursday schedules
(136, '09:00 AM', 'Thursday', 'R-110', 136),
(137, '11:00 AM', 'Thursday', 'LH-1', 137),
(138, '01:00 PM', 'Thursday', 'R-111', 138),
(139, '03:00 PM', 'Thursday', 'Lab-2', 139),
(140, '04:00 PM', 'Thursday', 'R-112', 140);

-- Populate domain_course mappings for ALL domains
-- Domain IDs: 1=iMTech CSE, 2=iMTech ECE, 3=iMTech DSAI, 4=MTech CSE, 5=MTech ECE, 6=MTech DSAI

-- iMTech CSE (Domain 1)
INSERT IGNORE INTO domain_course (domain_id, course_id) VALUES
(1, 101), (1, 102), (1, 103), (1, 104), (1, 107), (1, 108), (1, 111), (1, 112), 
(1, 115), (1, 121), (1, 122), (1, 123), (1, 124), (1, 125), (1, 136), (1, 137), 
(1, 138), (1, 139), (1, 140);

-- iMTech ECE (Domain 2)
INSERT IGNORE INTO domain_course (domain_id, course_id) VALUES
(2, 105), (2, 106), (2, 113), (2, 114), (2, 116), (2, 126), (2, 127), (2, 128), 
(2, 129), (2, 130), (2, 136), (2, 137), (2, 138), (2, 139), (2, 140);

-- iMTech DSAI (Domain 3)
INSERT IGNORE INTO domain_course (domain_id, course_id) VALUES
(3, 109), (3, 110), (3, 117), (3, 118), (3, 119), (3, 120), (3, 131), (3, 132), 
(3, 133), (3, 134), (3, 135), (3, 121), (3, 125), (3, 136), (3, 137), (3, 138), 
(3, 139), (3, 140);

-- MTech CSE (Domain 4)
INSERT IGNORE INTO domain_course (domain_id, course_id) VALUES
(4, 104), (4, 107), (4, 108), (4, 111), (4, 112), (4, 115), (4, 121), (4, 122), 
(4, 123), (4, 124), (4, 125), (4, 136), (4, 137), (4, 138), (4, 139), (4, 140);

-- MTech ECE (Domain 5)
INSERT IGNORE INTO domain_course (domain_id, course_id) VALUES
(5, 105), (5, 106), (5, 113), (5, 114), (5, 116), (5, 126), (5, 127), (5, 128), 
(5, 129), (5, 130), (5, 136), (5, 137), (5, 138), (5, 139), (5, 140);

-- MTech DSAI (Domain 6)
INSERT IGNORE INTO domain_course (domain_id, course_id) VALUES
(6, 109), (6, 110), (6, 117), (6, 118), (6, 119), (6, 120), (6, 131), (6, 132), 
(6, 133), (6, 134), (6, 135), (6, 125), (6, 136), (6, 137), (6, 138), (6, 139), 
(6, 140);

SELECT 'Data population complete!' AS Status;
SELECT 
    d.program AS Domain,
    COUNT(dc.course_id) AS 'Total Courses'
FROM domain d
LEFT JOIN domain_course dc ON d.id = dc.domain_id
GROUP BY d.id, d.program
ORDER BY d.id;
