-- ================================================
-- CREATE TABLES SCRIPT FOR COURSE TIMETABLE MODULE
-- ================================================
-- This script creates all necessary tables for the Course TimeTable functionality
-- Generated for: ESD Mini-Project Deliverable #2
-- Module: 2.5 Course TimeTable
-- ================================================

-- Drop tables if they exist (for clean installation)
DROP TABLE IF EXISTS student_course;
DROP TABLE IF EXISTS domain_course;
DROP TABLE IF EXISTS schedule;
DROP TABLE IF EXISTS student;
DROP TABLE IF EXISTS course;
DROP TABLE IF EXISTS faculty;
DROP TABLE IF EXISTS domain;

-- ================================================
-- DOMAIN TABLE
-- ================================================
-- Stores academic program information (MTech CSE, IMTech ECE, etc.)
CREATE TABLE domain (
    id INT AUTO_INCREMENT PRIMARY KEY,
    program VARCHAR(255) NOT NULL COMMENT 'Program name (e.g., MTech CSE, IMTech ECE)',
    batch VARCHAR(255) NOT NULL COMMENT 'Year of admission (e.g., 2025)',
    INDEX idx_program (program)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Academic programs/domains';

-- ================================================
-- FACULTY TABLE
-- ================================================
-- Stores faculty information
CREATE TABLE faculty (
    id INT AUTO_INCREMENT PRIMARY KEY,
    f_name VARCHAR(255) NOT NULL COMMENT 'Faculty full name',
    f_email VARCHAR(255) NOT NULL UNIQUE COMMENT 'Faculty email address',
    INDEX idx_email (f_email)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Faculty members';

-- ================================================
-- COURSE TABLE
-- ================================================
-- Stores course information
CREATE TABLE course (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL COMMENT 'Course name',
    c_code VARCHAR(255) NOT NULL UNIQUE COMMENT 'Unique course code',
    credit INT NOT NULL COMMENT 'Credit hours',
    description VARCHAR(500) NULL COMMENT 'Course description',
    faculty_id INT NULL COMMENT 'Faculty teaching this course',
    FOREIGN KEY (faculty_id) REFERENCES faculty(id) ON DELETE SET NULL,
    INDEX idx_course_code (c_code),
    INDEX idx_faculty (faculty_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Courses offered';

-- ================================================
-- SCHEDULE TABLE
-- ================================================
-- Stores course schedule information
CREATE TABLE schedule (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    time VARCHAR(50) NOT NULL COMMENT 'Class timing (e.g., 09:00 AM)',
    day VARCHAR(50) NOT NULL COMMENT 'Day of week',
    room VARCHAR(50) NOT NULL COMMENT 'Room/location',
    course_id BIGINT NULL COMMENT 'Course this schedule belongs to',
    FOREIGN KEY (course_id) REFERENCES course(id) ON DELETE CASCADE,
    INDEX idx_course (course_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Course schedules';

-- ================================================
-- STUDENT TABLE
-- ================================================
-- Stores student information
CREATE TABLE student (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL COMMENT 'Student full name',
    rno VARCHAR(50) NOT NULL COMMENT 'Roll number',
    email VARCHAR(255) NOT NULL COMMENT 'Student email',
    domain_id INT NULL COMMENT 'Domain/program student belongs to',
    FOREIGN KEY (domain_id) REFERENCES domain(id) ON DELETE SET NULL,
    INDEX idx_domain (domain_id),
    INDEX idx_email (email)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Enrolled students';

-- ================================================
-- DOMAIN_COURSE TABLE (Junction)
-- ================================================
-- Maps many-to-many relationship between domains and courses
CREATE TABLE domain_course (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    domain_id INT NOT NULL COMMENT 'Domain offering the course',
    course_id BIGINT NOT NULL COMMENT 'Course being offered',
    FOREIGN KEY (domain_id) REFERENCES domain(id) ON DELETE CASCADE,
    FOREIGN KEY (course_id) REFERENCES course(id) ON DELETE CASCADE,
    UNIQUE KEY unique_domain_course (domain_id, course_id),
    INDEX idx_domain (domain_id),
    INDEX idx_course (course_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Domain-Course mapping';

-- ================================================
-- STUDENT_COURSE TABLE (Junction)
-- ================================================
-- Maps many-to-many relationship between students and courses (enrollment)
CREATE TABLE student_course (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL COMMENT 'Enrolled student',
    course_id BIGINT NOT NULL COMMENT 'Course enrolled in',
    FOREIGN KEY (student_id) REFERENCES student(id) ON DELETE CASCADE,
    FOREIGN KEY (course_id) REFERENCES course(id) ON DELETE CASCADE,
    UNIQUE KEY unique_student_course (student_id, course_id),
    INDEX idx_student (student_id),
    INDEX idx_course (course_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Student-Course enrollment';

-- ================================================
-- SEQUENCE TABLES (For Hibernate)
-- ================================================
-- These tables are used by Hibernate for ID generation
CREATE TABLE IF NOT EXISTS domain_seq (next_val BIGINT) ENGINE=InnoDB;
CREATE TABLE IF NOT EXISTS faculty_seq (next_val BIGINT) ENGINE=InnoDB;
CREATE TABLE IF NOT EXISTS course_seq (next_val BIGINT) ENGINE=InnoDB;
CREATE TABLE IF NOT EXISTS schedule_seq (next_val BIGINT) ENGINE=InnoDB;
CREATE TABLE IF NOT EXISTS student_seq (next_val BIGINT) ENGINE=InnoDB;
CREATE TABLE IF NOT EXISTS domain_course_seq (next_val BIGINT) ENGINE=InnoDB;
CREATE TABLE IF NOT EXISTS student_course_seq (next_val BIGINT) ENGINE=InnoDB;

-- Initialize sequence values
INSERT INTO domain_seq VALUES (1) ON DUPLICATE KEY UPDATE next_val=next_val;
INSERT INTO faculty_seq VALUES (1) ON DUPLICATE KEY UPDATE next_val=next_val;
INSERT INTO course_seq VALUES (1) ON DUPLICATE KEY UPDATE next_val=next_val;
INSERT INTO schedule_seq VALUES (1) ON DUPLICATE KEY UPDATE next_val=next_val;
INSERT INTO student_seq VALUES (1) ON DUPLICATE KEY UPDATE next_val=next_val;
INSERT INTO domain_course_seq VALUES (1) ON DUPLICATE KEY UPDATE next_val=next_val;
INSERT INTO student_course_seq VALUES (1) ON DUPLICATE KEY UPDATE next_val=next_val;

-- ================================================
-- END OF CREATE TABLES SCRIPT
-- ================================================
