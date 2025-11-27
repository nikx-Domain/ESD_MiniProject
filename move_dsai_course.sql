-- Move AI Ethics from Friday to Monday for MTech DSAI
USE academia;

-- Move AI Ethics from Friday 03:00 PM to Monday 03:00 PM
UPDATE schedule 
SET day = 'Monday', time = '03:00 PM', room = 'R-205'
WHERE id = 34 AND course_id = 30;

SELECT 'Schedule updated! AI Ethics moved from Friday to Monday.' AS Status;
