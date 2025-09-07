@echo off
title FireShop E-Commerce Launcher
color 0A

echo.
echo  ███████╗██╗██████╗ ███████╗███████╗██╗  ██╗ ██████╗ ██████╗ ██████╗ 
echo  ██╔════╝██║██╔══██╗██╔════╝██╔════╝██║  ██║██╔═══██╗██╔══██╗██╔══██╗
echo  █████╗  ██║██████╔╝█████╗  ███████╗███████║██║   ██║██████╔╝██████╔╝
echo  ██╔══╝  ██║██╔══██╗██╔══╝  ╚════██║██╔══██║██║   ██║██╔═══╝ ██╔═══╝ 
echo  ██║     ██║██║  ██║███████╗███████║██║  ██║╚██████╔╝██║     ██║     
echo  ╚═╝     ╚═╝╚═╝  ╚═╝╚══════╝╚══════╝╚═╝  ╚═╝ ╚═════╝ ╚═╝     ╚═╝     
echo.
echo  🛍️  MongoDB E-Commerce Application
echo  ====================================
echo.

REM Change to the script directory
cd /d "%~dp0"

REM Check if Node.js is installed
node --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ ERROR: Node.js is not installed
    echo.
    echo Please install Node.js from: https://nodejs.org/
    echo Then run this launcher again.
    echo.
    pause
    exit /b 1
)

REM Check if server is already running
netstat -an | find "5000" | find "LISTENING" >nul
if %errorlevel% equ 0 (
    echo ✅ FireShop server is already running!
    echo 🌐 Opening application...
    start all-mongodb.html
    start http://localhost:5000/api/health
    echo.
    echo 🎉 Application opened successfully!
    echo 📍 Server: http://localhost:5000
    echo 📍 App: all-mongodb.html
    echo.
    pause
    exit /b 0
)

echo 🚀 Starting FireShop server...
echo.

REM Start the server in a new window
start "FireShop Server" cmd /k "title FireShop Server && color 0B && echo Starting FireShop MongoDB Server... && echo. && npm run auto-start"

REM Wait for server to start
echo ⏳ Waiting for server to start...
timeout /t 5 /nobreak >nul

REM Check if server started successfully
netstat -an | find "5000" | find "LISTENING" >nul
if %errorlevel% equ 0 (
    echo ✅ Server started successfully!
    echo.
    echo 🌐 Opening application...
    start all-mongodb.html
    start http://localhost:5000/api/health
    echo.
    echo 🎉 FireShop is now running!
    echo 📍 Server: http://localhost:5000
    echo 📍 MongoDB: mongodb://localhost:27017/fireshop
    echo 📍 App: all-mongodb.html
    echo.
    echo 💡 Tip: Keep the server window open while using the app
    echo ⏹️  To stop the server, close the server window or press Ctrl+C
) else (
    echo ❌ Failed to start server
    echo Please check the server window for error details
)

echo.
pause
