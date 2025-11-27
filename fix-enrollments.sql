USE academia;

-- 1. Remove iMTech students (rno starts with 'IMT') from MTech courses
-- MTech domains are 4, 5, 6
DELETE sc 
FROM student_course sc
JOIN course c ON sc.course_id = c.id
JOIN domain_course dc ON c.id = dc.course_id
JOIN student s ON sc.student_id = s.id
WHERE s.rno LIKE 'IMT%' 
AND dc.domain_id IN (4, 5, 6);

SELECT ROW_COUNT() as 'Deleted iMTech enrollments from MTech courses';

-- 2. Populate MTech courses with MTech students
-- Enroll every MTech student into all courses of their domain
INSERT IGNORE INTO student_course (student_id, course_id)
SELECT s.id, dc.course_id
FROM student s
JOIN domain_course dc ON s.domain_id = dc.domain_id
WHERE s.domain_id IN (4, 5, 6);

SELECT ROW_COUNT() as 'Added MTech enrollments';

-- Verify results
SELECT 
    c.name as Course, 
    d.program as Domain,
    COUNT(s.id) as Student_Count,
    SUM(CASE WHEN s.rno LIKE 'IMT%' THEN 1 ELSE 0 END) as iMTech_Students,
    SUM(CASE WHEN s.rno LIKE 'MT%' THEN 1 ELSE 0 END) as MTech_Students
FROM course c
JOIN domain_course dc ON c.id = dc.course_id
JOIN domain d ON dc.domain_id = d.id
LEFT JOIN student_course sc ON c.id = sc.course_id
LEFT JOIN student s ON sc.student_id = s.id
WHERE d.id IN (4, 5, 6)
GROUP BY c.id, d.program;
