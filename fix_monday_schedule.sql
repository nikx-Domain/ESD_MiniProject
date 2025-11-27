-- Move Research Methodology from Monday to Friday to reduce Monday courses
USE academia;

UPDATE schedule SET day='Friday', time='05:00 PM' WHERE id=7 AND course_id=31;

SELECT 'Course schedule updated! Research Methodology moved from Monday to Friday.' AS Status;
