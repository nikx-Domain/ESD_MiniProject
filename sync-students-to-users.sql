USE academia;

-- Insert missing students into the User table
-- Password is 'password123' (BCrypt hash)
INSERT INTO User (name, email, role, password)
SELECT 
    name, 
    email, 
    'Student', 
    '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOcd7qa8qkrBm'
FROM student
WHERE email NOT IN (SELECT email FROM User);

-- Verify the count of users now
SELECT COUNT(*) as total_users FROM User;
SELECT * FROM User ORDER BY user_id DESC LIMIT 5;
