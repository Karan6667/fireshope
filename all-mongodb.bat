@echo off
cd /d  %~dp0
netstat -an | find 5000 | find LISTENING >nul
if %errorlevel% equ 0 (
  start all-mongodb.html
  start http://localhost:5000/api/health
  exit /b 0
)
start FireShop Server cmd /k npm run auto-start
timeout /t 4 /nobreak >nul
start all-mongodb.html
start http://localhost:5000/api/health

