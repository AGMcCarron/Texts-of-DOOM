@echo off
title Texts of Doom - Game Launcher
echo ===========================================
echo        🎮 Starting Game Server Only
echo ===========================================

REM --- Get local IP address ---
for /f "tokens=2 delims=:" %%A in ('ipconfig ^| findstr /c:"IPv4 Address"') do (
    set ip=%%A
)
set ip=%ip: =%
echo.
echo 🌐 Your local IP address is: %ip%
echo Game will be available at: http://%ip%:8081/
echo.

REM --- Start the Python HTTP server ---
echo ▶ Launching Python server on port 8081...
start cmd /k "cd Game && python -m http.server 8081"

REM --- Wait a few seconds for server startup ---
timeout /t 3 /nobreak >nul

REM --- Open combined.html (or change to the hosted one) ---
echo ▶ Opening combined.html in your browser...
REM You can instead open http://localhost:8081/combined.html if desired:
start "" "combined.html"

echo.
echo ===========================================
echo ✅ Game server is running!
echo Access locally:  http://localhost:8081/
echo Access on LAN:   http://%ip%:8081/
echo ===========================================
echo.
pause
