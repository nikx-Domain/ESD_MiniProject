-- Add more Faculty
INSERT INTO faculty (id, f_name, f_email) VALUES
(11, 'Dr. Rakesh Kumar', 'rakesh.kumar@iiitb.ac.in'),
(12, 'Prof. Neha Gupta', 'neha.gupta@iiitb.ac.in'),
(13, 'Dr. Sanjay Singh', 'sanjay.singh@iiitb.ac.in'),
(14, 'Prof. Anitha Rao', 'anitha.rao@iiitb.ac.in'),
(15, 'Dr. Manish Sharma', 'manish.sharma@iiitb.ac.in');

-- Add more Courses
INSERT INTO course (id, name, c_code, credit, description, faculty_id) VALUES
(111, 'Software Engineering', 'CS203', 4, 'Software development lifecycle and methodologies', 11),
(112, 'Operating Systems', 'CS204', 4, 'Process management, memory management, and file systems', 12),
(113, 'Computer Architecture', 'CS205', 4, 'Digital logic, instruction sets, and processor design', 13),
(114, 'Theory of Computation', 'CS206', 3, 'Automata theory and formal languages', 14),
(115, 'Machine Learning', 'CS303', 4, 'Supervised and unsupervised learning algorithms', 15),
(116, 'Analog Circuits', 'EC203', 3, 'Diode circuits, BJTs, and FETs', 11),
(117, 'Control Systems', 'EC204', 3, 'Feedback control systems and stability analysis', 12),
(118, 'Communication Systems', 'EC205', 3, 'Analog and digital communication techniques', 13),
(119, 'VLSI Design', 'EC303', 4, 'CMOS circuit design and layout', 14),
(120, 'Information Retrieval', 'DS303', 4, 'Search engines and text mining', 15);

-- Add Schedules (Filling gaps in the grid)
-- Existing: Mon 9, Tue 11, Wed 2, Thu 10, Fri 3
INSERT INTO schedule (id, time, day, room, course_id) VALUES
(11, '11:00 AM', 'Monday', 'LH-1', 111),
(12, '02:00 PM', 'Tuesday', 'LH-2', 112),
(13, '04:00 PM', 'Wednesday', 'R-101', 113),
(14, '09:00 AM', 'Thursday', 'Lab-1', 114),
(15, '11:00 AM', 'Friday', 'R-102', 115),
(16, '10:00 AM', 'Monday', 'R-103', 116),
(17, '03:00 PM', 'Tuesday', 'Lab-2', 117),
(18, '09:00 AM', 'Wednesday', 'LH-3', 118),
(19, '02:00 PM', 'Thursday', 'R-104', 119),
(20, '04:00 PM', 'Friday', 'Lab-3', 120);

-- Map Courses to Domains
-- iMTech CSE (Domain 1) gets: SE, OS, Comp Arch
INSERT INTO domain_course (domain_id, course_id) VALUES
(1, 111), (1, 112), (1, 113), (1, 114), (1, 115);

-- iMTech ECE (Domain 2) gets: Analog, Control, Comm, VLSI
INSERT INTO domain_course (domain_id, course_id) VALUES
(2, 116), (2, 117), (2, 118), (2, 119);

-- MTech CSE (Domain 4) gets: ML, IR
INSERT INTO domain_course (domain_id, course_id) VALUES
(4, 115), (4, 120), (4, 111), (4, 112);

-- Add some student enrollments
INSERT INTO student_course (student_id, course_id) VALUES
(1, 111), (1, 112), (1, 113),
(2, 111), (2, 112), (2, 113),
(3, 116), (3, 117),
(7, 115), (7, 120),
(8, 115), (8, 120);
