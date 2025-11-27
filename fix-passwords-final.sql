USE academia;

-- Update ALL users to have the password 'password123'
-- The hash is: $2b$10$TlV/xaozZYQieskziaRzQOipsLayGpDQvttUBg34josQHz/sNoyNy
-- This was generated using bcryptjs with cost 10

UPDATE User 
SET password = '$2b$10$TlV/xaozZYQieskziaRzQOipsLayGpDQvttUBg34josQHz/sNoyNy';

-- Show the updated users
SELECT user_id, name, email, role FROM User LIMIT 5;
