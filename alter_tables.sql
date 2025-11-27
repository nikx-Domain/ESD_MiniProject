-- ================================================
-- ALTER TABLES SCRIPT FOR COURSE TIMETABLE MODULE
-- ================================================
-- This script contains ALTER statements for adding constraints,
-- indexes, or modifying existing tables
-- Generated for: ESD Mini-Project Deliverable #2
-- Module: 2.5 Course TimeTable
-- ================================================

-- ================================================
-- ADD ADDITIONAL INDEXES FOR PERFORMANCE
-- ================================================

-- Add composite index for domain-course lookup
ALTER TABLE domain_course 
ADD INDEX idx_domain_course_composite (domain_id, course_id);

-- Add composite index for student-course lookup
ALTER TABLE student_course 
ADD INDEX idx_student_course_composite (student_id, course_id);

-- ================================================
-- ADD CHECK CONSTRAINTS (if supported)
-- ================================================
-- Note: MySQL 8.0.16+ supports CHECK constraints

-- Ensure credit hours are positive
ALTER TABLE course 
ADD CONSTRAINT chk_credit_positive CHECK (credit > 0);

-- ================================================
-- ADD COMMENTS TO TABLES (for documentation)
-- ================================================
ALTER TABLE domain 
COMMENT = 'Stores academic program information (MTech CSE, IMTech ECE, etc.)';

ALTER TABLE course 
COMMENT = 'Stores course information with faculty assignment';

ALTER TABLE faculty 
COMMENT = 'Stores faculty member information';

ALTER TABLE schedule 
COMMENT = 'Stores course schedule details (time, day, room)';

ALTER TABLE student 
COMMENT = 'Stores enrolled student information';

ALTER TABLE domain_course 
COMMENT = 'Junction table mapping domains to courses (many-to-many)';

ALTER TABLE student_course 
COMMENT = 'Junction table mapping students to courses (enrollment)';

-- ================================================
-- ADD TRIGGERS FOR DATA INTEGRITY (Optional)
-- ================================================

-- Trigger to prevent deleting a course that has enrolled students
DELIMITER $$
CREATE TRIGGER prevent_course_delete_with_students
BEFORE DELETE ON course
FOR EACH ROW
BEGIN
    DECLARE student_count INT;
    SELECT COUNT(*) INTO student_count 
    FROM student_course 
    WHERE course_id = OLD.id;
    
    IF student_count > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Cannot delete course with enrolled students';
    END IF;
END$$
DELIMITER ;

-- ================================================
-- ADD VIEWS FOR COMMON QUERIES
-- ================================================

-- View for complete course timetable with all details
CREATE OR REPLACE VIEW v_course_timetable AS
SELECT 
    d.id AS domain_id,
    d.program AS domain_program,
    d.batch AS domain_batch,
    c.id AS course_id,
    c.name AS course_name,
    c.c_code AS course_code,
    c.credit AS course_credit,
    f.f_name AS faculty_name,
    f.f_email AS faculty_email,
    s.day AS schedule_day,
    s.time AS schedule_time,
    s.room AS schedule_room
FROM domain d
INNER JOIN domain_course dc ON d.id = dc.domain_id
INNER JOIN course c ON dc.course_id = c.id
LEFT JOIN faculty f ON c.faculty_id = f.id
LEFT JOIN schedule s ON c.id = s.course_id
ORDER BY d.program, c.name;

-- View for student enrollment details
CREATE OR REPLACE VIEW v_student_enrollment AS
SELECT 
    s.id AS student_id,
    s.name AS student_name,
    s.rno AS student_roll_no,
    s.email AS student_email,
    d.program AS student_domain,
    c.id AS course_id,
    c.name AS course_name,
    c.c_code AS course_code,
    f.f_name AS faculty_name
FROM student s
INNER JOIN domain d ON s.domain_id = d.id
INNER JOIN student_course sc ON s.id = sc.student_id
INNER JOIN course c ON sc.course_id = c.id
LEFT JOIN faculty f ON c.faculty_id = f.id
ORDER BY s.name, c.name;

-- ================================================
-- PERFORMANCE OPTIMIZATION
-- ================================================

-- Analyze tables for query optimization
ANALYZE TABLE domain;
ANALYZE TABLE course;
ANALYZE TABLE faculty;
ANALYZE TABLE schedule;
ANALYZE TABLE student;
ANALYZE TABLE domain_course;
ANALYZE TABLE student_course;

-- ================================================
-- END OF ALTER TABLES SCRIPT
-- ================================================
