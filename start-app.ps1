# ESD Academia - Startup Script
# This script starts both backend and frontend servers

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  ESD Academia - Application Startup" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Check if Google OAuth Client ID is configured
Write-Host "Checking configuration..." -ForegroundColor Yellow

# Check backend environment variable
if (-not $env:GOOGLE_OAUTH_CLIENT_ID) {
    Write-Host "❌ ERROR: GOOGLE_OAUTH_CLIENT_ID environment variable is not set!" -ForegroundColor Red
    Write-Host ""
    Write-Host "Please set it using:" -ForegroundColor Yellow
    Write-Host "  setx GOOGLE_OAUTH_CLIENT_ID `"your-client-id.apps.googleusercontent.com`"" -ForegroundColor White
    Write-Host ""
    Write-Host "Then restart this terminal and try again." -ForegroundColor Yellow
    Write-Host ""
    Write-Host "See GOOGLE_OAUTH_SETUP.md for detailed instructions." -ForegroundColor Cyan
    exit 1
}

# Check frontend .env file
$envFile = "Frontend\.env"
if (-not (Test-Path $envFile)) {
    Write-Host "❌ ERROR: Frontend\.env file not found!" -ForegroundColor Red
    Write-Host ""
    Write-Host "A template has been created. Please edit Frontend\.env and add your Google Client ID." -ForegroundColor Yellow
    Write-Host "See GOOGLE_OAUTH_SETUP.md for detailed instructions." -ForegroundColor Cyan
    exit 1
}

$envContent = Get-Content $envFile
if ($envContent -match "YOUR_GOOGLE_CLIENT_ID_HERE") {
    Write-Host "❌ ERROR: Frontend\.env still contains placeholder!" -ForegroundColor Red
    Write-Host ""
    Write-Host "Please edit Frontend\.env and replace YOUR_GOOGLE_CLIENT_ID_HERE with your actual Client ID." -ForegroundColor Yellow
    Write-Host "See GOOGLE_OAUTH_SETUP.md for detailed instructions." -ForegroundColor Cyan
    exit 1
}

Write-Host "✅ Google OAuth Client ID configured" -ForegroundColor Green
Write-Host ""

# Start backend
Write-Host "Starting Backend Server..." -ForegroundColor Yellow
Write-Host "--------------------------------" -ForegroundColor Gray
Start-Process powershell -ArgumentList "-NoExit", "-Command", "cd '$PWD\Backend'; Write-Host 'Backend Server Starting...' -ForegroundColor Cyan; .\mvnw spring-boot:run"

Write-Host ""
Write-Host "Waiting for backend to initialize (10 seconds)..." -ForegroundColor Gray
Start-Sleep -Seconds 10

# Start frontend
Write-Host ""
Write-Host "Starting Frontend Server..." -ForegroundColor Yellow
Write-Host "--------------------------------" -ForegroundColor Gray
Start-Process powershell -ArgumentList "-NoExit", "-Command", "cd '$PWD\Frontend'; Write-Host 'Frontend Server Starting...' -ForegroundColor Cyan; npm start"

Write-Host ""
Write-Host "========================================" -ForegroundColor Green
Write-Host "  Application Starting!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""
Write-Host "Backend will be available at: http://localhost:8090" -ForegroundColor Cyan
Write-Host "Frontend will be available at: http://localhost:3000" -ForegroundColor Cyan
Write-Host ""
Write-Host "The browser will open automatically once the frontend is ready." -ForegroundColor Yellow
Write-Host ""
Write-Host "Two new PowerShell windows have been opened:" -ForegroundColor Gray
Write-Host "  1. Backend Server (Spring Boot)" -ForegroundColor Gray
Write-Host "  2. Frontend Server (React)" -ForegroundColor Gray
Write-Host ""
Write-Host "To stop the servers, close those windows or press Ctrl+C in each." -ForegroundColor Gray
Write-Host ""
