@echo off
echo ========================================
echo Creating Admin User in Database
echo ========================================
echo.
echo This script will create an admin user for Google OAuth login.
echo.
set /p EMAIL="Enter your Google email address: "
echo.
echo Creating user with email: %EMAIL%
echo.

mysql -u nikx -pnikx@12 -e "USE academia; INSERT INTO User (name, email, role, password) VALUES ('Admin User', '%EMAIL%', 'Admin', 'oauth_not_used') ON DUPLICATE KEY UPDATE role = 'Admin'; SELECT * FROM User WHERE email = '%EMAIL%';"

echo.
if %ERRORLEVEL% EQU 0 (
    echo SUCCESS: Admin user created/updated!
) else (
    echo ERROR: Failed to create user. Please check:
    echo   1. MySQL is running
    echo   2. Database 'academia' exists
    echo   3. User credentials are correct ^(nikx/nikx@12^)
)
echo.
pause
