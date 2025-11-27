@echo off
echo ========================================
echo Quick Admin User Creation
echo ========================================
echo.
echo This will create an admin user in the database.
echo.
set /p EMAIL="Enter your Google email address (the one you just tried to login with): "
echo.

echo Inserting user into database...
mysql -u nikx -pnikx@12 -e "USE academia; INSERT INTO User (name, email, role, password) VALUES ('Admin User', '%EMAIL%', 'Admin', 'oauth_not_used') ON DUPLICATE KEY UPDATE role = 'Admin'; SELECT user_id, name, email, role FROM User WHERE email = '%EMAIL%';"

if %ERRORLEVEL% EQU 0 (
    echo.
    echo ========================================
    echo SUCCESS! Admin user created!
    echo ========================================
    echo.
    echo Email: %EMAIL%
    echo Role: Admin
    echo.
    echo You can now go back to the browser and login!
    echo Just refresh the page and click "Sign in with Google"
    echo.
) else (
    echo.
    echo ERROR: Could not create user.
    echo Please make sure MySQL is running and credentials are correct.
    echo.
)

pause
