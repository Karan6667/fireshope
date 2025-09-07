@echo off
title FireShop Server Launcher

REM Change to the script directory
cd /d "%~dp0"

REM Check if server is already running
netstat -an | find "5000" | find "LISTENING" >nul
if %errorlevel% equ 0 (
    echo FireShop server is already running on port 5000
    echo Opening browser...
    start http://localhost:5000/api/health
    pause
    exit /b 0
)

REM Start the server
echo Starting FireShop server...
start "FireShop Server" cmd /k "npm run auto-start"

REM Wait a moment for server to start
timeout /t 3 /nobreak >nul

REM Open browser to health check
echo Opening browser...
start http://localhost:5000/api/health

REM Open the main application
timeout /t 2 /nobreak >nul
start all-mongodb.html

echo.
echo FireShop server started successfully!
echo Server: http://localhost:5000
echo App: all-mongodb.html
echo.
pause
