// Quick script to insert admin user
// Run this in MySQL Workbench or command line after starting the backend

// Replace 'your.email@gmail.com' with your actual Google account email
USE academia;

INSERT INTO User (name, email, role, password) 
VALUES ('Admin User', 'your.email@gmail.com', 'Admin', 'oauth_not_used')
ON DUPLICATE KEY UPDATE role = 'Admin';

-- Verify the user was created
SELECT * FROM User WHERE role = 'Admin';
