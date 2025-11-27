USE academia;

-- Update ALL users to have the password 'password123'
-- The hash is: $2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOcd7qa8qkrBm

UPDATE User 
SET password = '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOcd7qa8qkrBm';

-- Show the updated users (excluding password column for security/brevity)
SELECT user_id, name, email, role FROM User;
