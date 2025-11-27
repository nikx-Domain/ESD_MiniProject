-- Create a test admin user for Google OAuth login
-- Replace 'your.email@gmail.com' with your actual Google email

-- First, check if the user table exists and what columns it has
DESCRIBE User;

-- Insert an admin user
-- Adjust the column names based on your actual User table structure
INSERT INTO User (name, email, role, password) 
VALUES (
    'Admin User', 
    'your.email@gmail.com',  -- Replace with your Google account email
    'Admin',
    'dummy_password_not_used'  -- Password not used for Google OAuth
)
ON DUPLICATE KEY UPDATE role = 'Admin';

-- Verify the user was created
SELECT * FROM User WHERE email = 'your.email@gmail.com';
