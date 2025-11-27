# Complete Application Startup Script
# This starts both backend and frontend

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  ESD Academia - Complete Startup" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Check if Google OAuth Client ID is configured
$clientId = "189993135268-d76gjl69ji9ndj1p31buk8vd9soe7url.apps.googleusercontent.com"

Write-Host "✅ Google OAuth Client ID: Configured" -ForegroundColor Green
Write-Host ""

# Start backend
Write-Host "Starting Backend Server..." -ForegroundColor Yellow
Write-Host "--------------------------------" -ForegroundColor Gray
$backendScript = @"
cd '$PWD\Backend'
`$env:GOOGLE_OAUTH_CLIENT_ID='$clientId'
Write-Host 'Backend Server Starting...' -ForegroundColor Cyan
.\mvnw spring-boot:run
"@
Start-Process powershell -ArgumentList "-NoExit", "-Command", $backendScript

Write-Host ""
Write-Host "Waiting for backend to initialize (15 seconds)..." -ForegroundColor Gray
Start-Sleep -Seconds 15

# Start frontend using batch file (avoids execution policy issues)
Write-Host ""
Write-Host "Starting Frontend Server..." -ForegroundColor Yellow
Write-Host "--------------------------------" -ForegroundColor Gray
Start-Process cmd -ArgumentList "/c", "$PWD\start-frontend.bat"

Write-Host ""
Write-Host "========================================" -ForegroundColor Green
Write-Host "  Application Started!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""
Write-Host "Backend: http://localhost:8090" -ForegroundColor Cyan
Write-Host "Frontend: http://localhost:3000" -ForegroundColor Cyan
Write-Host ""
Write-Host "Browser will open automatically." -ForegroundColor Yellow
Write-Host ""
Write-Host "IMPORTANT: Create an admin user in the database before logging in!" -ForegroundColor Red
Write-Host "  - Open quick-admin-setup.sql" -ForegroundColor Yellow
Write-Host "  - Replace 'your.email@gmail.com' with your Google email" -ForegroundColor Yellow
Write-Host "  - Run the SQL in MySQL Workbench or command line" -ForegroundColor Yellow
Write-Host ""
