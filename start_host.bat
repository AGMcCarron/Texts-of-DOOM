@echo off
title Texts of Doom - Server Launcher
echo ===========================================
echo      🚀 Starting Game and Chat servers
echo ===========================================

REM --- Get local IP address ---
for /f "tokens=2 delims=:" %%A in ('ipconfig ^| findstr /c:"IPv4 Address"') do (
    set ip=%%A
)
set ip=%ip: =%
echo.
echo 🌐 Your local IP address is: %ip%
echo Use this IP for others to connect (e.g. http://%ip%:8080)
echo.

REM --- Start the Python HTTP server for Game ---
echo ▶ Launching Python server on port 8081...
start cmd /k "cd Game && python -m http.server 8081"

REM --- Start the Node.js chat server ---
echo ▶ Launching Node chat server on port 8080...
start cmd /k "cd chat && node chattingSystem.js"

REM --- Wait a moment to let servers start ---
timeout /t 3 /nobreak >nul

REM --- Open the combined HTML file in browser ---
echo ▶ Opening combined.html in your browser...
start "" "combined.html"

echo.
echo ===========================================
echo ✅ All systems online!
echo Game: http://localhost:8081/
echo Chat server running on: http://%ip%:8080/
echo ===========================================
echo.
pause
