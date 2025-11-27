Write-Host "Reverting UI changes..." -ForegroundColor Yellow

Copy-Item "Frontend\src\components\Domain.jsx.bak" "Frontend\src\components\Domain.jsx" -Force
Copy-Item "Frontend\src\Styles\domain.css.bak" "Frontend\src\Styles\domain.css" -Force

Write-Host "UI reverted to previous version!" -ForegroundColor Green
