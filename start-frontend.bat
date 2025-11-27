@echo off
echo ========================================
echo Starting Frontend Server
echo ========================================
echo.
echo Navigating to Frontend directory...
cd /d "%~dp0Frontend"

echo.
echo Checking if node_modules exists...
if not exist "node_modules\\" (
    echo node_modules not found. Installing dependencies...
    call npm install
)

echo.
echo Starting React development server...
echo.
echo This will open your browser automatically to http://localhost:3000
echo.
call npm start

pause
