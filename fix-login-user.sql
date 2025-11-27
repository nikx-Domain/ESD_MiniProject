USE academia;

-- Insert or update a demo admin user
-- Password is 'password123' hashed with BCrypt
INSERT INTO User (name, email, password, role) 
VALUES ('Demo Admin', 'admin@iiitb.ac.in', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOcd7qa8qkrBm', 'Admin') 
ON DUPLICATE KEY UPDATE 
    password = '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOcd7qa8qkrBm',
    role = 'Admin';

-- Also update the user created by the batch script if they used a specific email
-- (We don't know the email, but we can update any user with 'oauth_not_used' password if we wanted, 
-- but safer to just provide a known working user).

SELECT user_id, name, email, role FROM User WHERE email = 'admin@iiitb.ac.in';
