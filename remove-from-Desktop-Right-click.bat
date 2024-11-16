@echo off & cd /d "%~dp0"
echo.
echo [33m remove from Desktop Right-click [0m
reg delete HKCR\DesktopBackground\Shell\0Toggle /f

pause
exit
