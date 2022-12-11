@echo off & cd /d "%~dp0"
echo.
echo [33m add to Desktop Right-click [0m
:: menu
reg add "HKCR\DesktopBackground\Shell\0Toggle" /v "SeparatorBefore" /t REG_SZ /d "" /f
reg add "HKCR\DesktopBackground\Shell\0Toggle" /v "SubCommands" /t REG_SZ /d "" /f
reg add "HKCR\DesktopBackground\Shell\0Toggle" /v "Icon" /t REG_SZ /d "c:\windows\SystemResources\inetcpl.cpl.mun,-6611" /f
reg add "HKCR\DesktopBackground\Shell\0Toggle" /v "MUIVerb" /t REG_SZ /d "Toggle Disable/Enable" /f
:: sub-menu
reg add "HKCR\DesktopBackground\Shell\0Toggle\shell\1Update" /v "icon" /t REG_SZ /d "c:\windows\SystemResources\compstui.dll.mun,-64008" /f
reg add "HKCR\DesktopBackground\Shell\0Toggle\shell\1Update" /v "SeparatorBefore" /t REG_SZ /d "" /f
reg add "HKCR\DesktopBackground\Shell\0Toggle\shell\1Update" /v "MUIVerb" /t REG_SZ /d "Disable Update" /f
reg add "HKCR\DesktopBackground\Shell\0Toggle\shell\1Update\command" /ve /t REG_SZ /d "\"%~dp0Toggle-Update.bat\"" /f

pause
exit