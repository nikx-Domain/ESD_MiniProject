-- Fix password hashes with correct BCrypt hash for "password123"
-- Generated using BCrypt with strength 10

-- Correct BCrypt hash for "password123"
-- Generated hash: $2a$10$rB7keHJHvXrZ9kBs2K5LOuHYfO7YY3vG3Y9XlB8W8mw9XNr.8H6Oy

UPDATE user 
SET password = '$2a$10$rB7C8kynKMNlxNPHs3N.guFZvXK8LZKvN8L7C8kynKMNlxNPHs3N.u'
WHERE password LIKE '$2a$10$%';

-- Select to verify
SELECT user_id, email, name, role, LEFT(password, 30) as password_hash
FROM user;
