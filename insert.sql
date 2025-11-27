-- Repopulate Domain-Course Mappings and Schedules

-- Clear existing mappings to start fresh
DELETE FROM domain_course;

-- iMTech CSE (Domain 1)
INSERT INTO domain_course (domain_id, course_id) VALUES
(1, 101), (1, 104), (1, 107), (1, 111), (1, 112), (1, 113);

-- iMTech ECE (Domain 2)
INSERT INTO domain_course (domain_id, course_id) VALUES
(2, 102), (2, 106), (2, 110), (2, 116), (2, 117), (2, 118);

-- iMTech DSAI (Domain 3)
INSERT INTO domain_course (domain_id, course_id) VALUES
(3, 103), (3, 109), (3, 115), (3, 120);

-- MTech CSE (Domain 4)
INSERT INTO domain_course (domain_id, course_id) VALUES
(4, 104), (4, 107), (4, 108), (4, 111), (4, 112), (4, 115);

-- MTech ECE (Domain 5)
INSERT INTO domain_course (domain_id, course_id) VALUES
(5, 102), (5, 106), (5, 110), (5, 116), (5, 119);

-- MTech DSAI (Domain 6)
INSERT INTO domain_course (domain_id, course_id) VALUES
(6, 105), (6, 109), (6, 115), (6, 120), (6, 113);

-- Ensure Schedules exist for new courses (111-120)
-- Using INSERT IGNORE to skip if they already exist
INSERT IGNORE INTO schedule (id, time, day, room, course_id) VALUES
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
