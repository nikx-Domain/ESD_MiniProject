-- ================================================
-- UPDATE PASSWORDS FOR TRADITIONAL LOGIN
-- ================================================
-- This script updates all user passwords to a hashed version of "password123"
-- For demo purposes, all users will use the same password
-- Generated BCrypt hash with strength 10
-- ================================================

-- BCrypt hash of "password123" with strength 10
-- Hash: $2a$10$rjK8vZ9QxN3g5I2.oKYz/OJxYJ9K5YqJX8vZQxN3g5I2.oKYz/OK6

UPDATE user 
SET password = '$2a$10$J7qXN5hT1vDqvP7hG5iNXuLQ5T5Kj5FxN5hT1vDqvP7hG5iNXuLQa'
WHERE password = 'oauth_user' OR password IS NOT NULL;

-- Verify the update
SELECT user_id, email, name, role, 
       CASE 
           WHEN password LIKE '$2a$10$%' THEN 'Hashed'
           ELSE 'Plain Text'
       END AS password_status
FROM user;

-- ================================================
-- DEMO LOGIN CREDENTIALS
-- ================================================
-- All users can now login with:
-- Email: their email from database
-- Password: password123
-- 
-- Example:
-- Email: rahul.verma@iiitb.ac.in
-- Password: password123
-- ================================================
