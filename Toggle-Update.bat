@echo off
if "%~1"=="/S" goto GotSYSTEM
nsudo -U:S -P:E -M:S -UseCurrentConsole "%~0" /S && exit /b
REM -ShowWindowMode:Hide
:GotSYSTEM
sc qc wuauserv | find "DISABLED" && goto DISABLED || goto Enabled
REM if %ERRORLEVEL%==0 goto (DISABLED) else (goto Enabled)
:DISABLED
: ===== Services =====
:: Windows Update (wuauserv) manual
reg add "HKLM\SYSTEM\CurrentControlSet\Services\wuauserv" /v "Start" /t REG_DWORD /d "3" /f
sc start wuauserv

:: Windows Update Medic (WaaSMedicSvc) manual
reg add "HKLM\SYSTEM\CurrentControlSet\Services\WaaSMedicSvc" /v "Start" /t REG_DWORD /d "3" /f
REM sc start WaaSMedicSvc

:: Update Orchestrator (UsoSvc) auto
reg add "HKLM\SYSTEM\CurrentControlSet\Services\UsoSvc" /v "Start" /t REG_DWORD /d "2" /f
sc start UsoSvc

::Delivery Optimization (DoSvc)
REM reg add "HKLM\SYSTEM\CurrentControlSet\Services\DoSvc" /v "Start" /t REG_DWORD /d "3" /f
::BranchCache (PeerDistSvc)
REM reg add "HKLM\SYSTEM\CurrentControlSet\Services\PeerDistSvc" /v "Start" /t REG_DWORD /d "3" /f
::Background Intelligent Transfer Service (BITS)
REM reg add "HKLM\SYSTEM\CurrentControlSet\Services\BITS" /v "Start" /t REG_DWORD /d "3" /f

: ===== Files =====
:: Windows Update (wuauserv)
::Wu10Man
ren "C:\Windows\System32\+wuaueng.dll.UP" "wuaueng.dll"
::extra
ren "C:\Windows\System32\+wuapi.dll.UP" "wuapi.dll"
ren "C:\Windows\System32\+wuapihost.exe.UP" "wuapihost.exe"
ren "C:\Windows\System32\+wuauclt.exe.UP" "wuauclt.exe"

:: Windows Update Medic (WaaSMedicSvc)
::Wu10Man
ren "C:\Windows\System32\+WaaSMedicSvc.dll.UP" "WaaSMedicSvc.dll"
::extra
ren "C:\Windows\System32\+WaaSAssessment.dll.UP" "WaaSAssessment.dll"
ren "C:\Windows\System32\+WaaSMedicAgent.exe.UP" "WaaSMedicAgent.exe"
ren "C:\Windows\System32\+WaaSMedicCapsule.dll.UP" "WaaSMedicCapsule.dll"
ren "C:\Windows\System32\+WaaSMedicPS.dll.UP" "WaaSMedicPS.dll"

:right-click
reg add "HKCR\DesktopBackground\Shell\0Toggle\shell\1Update" /v "icon" /t REG_SZ /d "c:\windows\SystemResources\compstui.dll.mun,-64008" /f
reg add "HKCR\DesktopBackground\Shell\0Toggle\shell\1Update" /v "MUIVerb" /t REG_SZ /d "Disable Update" /f

TASKKILL /F /IM msiexec.exe /T
exit

:Enabled
: ===== Services =====
:: Windows Update (wuauserv)
reg add "HKLM\SYSTEM\CurrentControlSet\Services\wuauserv" /v "Start" /t REG_DWORD /d "4" /f
net stop wuauserv /y

:: Windows Update Medic (WaaSMedicSvc)
reg add "HKLM\SYSTEM\CurrentControlSet\Services\WaaSMedicSvc" /v "Start" /t REG_DWORD /d "4" /f
net stop WaaSMedicSvc /y

:: Update Orchestrator (UsoSvc)
reg add "HKLM\SYSTEM\CurrentControlSet\Services\UsoSvc" /v "Start" /t REG_DWORD /d "4" /f
net stop UsoSvc /y

::Delivery Optimization (DoSvc)
REM reg add "HKLM\SYSTEM\CurrentControlSet\Services\DoSvc" /v "Start" /t REG_DWORD /d "4" /f
::BranchCache (PeerDistSvc)
REM reg add "HKLM\SYSTEM\CurrentControlSet\Services\PeerDistSvc" /v "Start" /t REG_DWORD /d "4" /f
::Background Intelligent Transfer Service
REM reg add "HKLM\SYSTEM\CurrentControlSet\Services\BITS" /v "Start" /t REG_DWORD /d "4" /f
REM taskkill /f /fi "SERVICES eq themes"

: ===== Files =====
:: Windows Update (wuauserv)
::Wu10Man
ren "C:\Windows\System32\wuaueng.dll" "+wuaueng.dll.UP"
::extra
ren "C:\Windows\System32\wuapi.dll" "+wuapi.dll.UP"
ren "C:\Windows\System32\wuapihost.exe" "+wuapihost.exe.UP"
ren "C:\Windows\System32\wuauclt.exe" "+wuauclt.exe.UP"

:: Windows Update Medic (WaaSMedicSvc)
::Wu10Man
ren "C:\Windows\System32\WaaSMedicSvc.dll" "+WaaSMedicSvc.dll.UP"
::extra
ren "C:\Windows\System32\WaaSAssessment.dll" "+WaaSAssessment.dll.UP"
ren "C:\Windows\System32\WaaSMedicAgent.exe" "+WaaSMedicAgent.exe.UP"
ren "C:\Windows\System32\WaaSMedicCapsule.dll" "+WaaSMedicCapsule.dll.UP"
ren "C:\Windows\System32\WaaSMedicPS.dll" "+WaaSMedicPS.dll.UP"

: ===== Tasks =====
:: ==== WindowsUpdate ====
:: schtasks /Change /Disable /TN "\Microsoft\Windows\WindowsUpdate\Scheduled Start"
:: ==== WaaSMedic ====
:: schtasks /Change /Disable /TN "\Microsoft\Windows\WaaSMedic\PerformRemediation"
:: ==== UpdateOrchestrator ====
:: schtasks /Change /Disable /TN "\Microsoft\Windows\UpdateOrchestrator\Report policies"
:: schtasks /Change /Disable /TN "\Microsoft\Windows\UpdateOrchestrator\ScheduLe Maintenance Work"
::Schedule Scan = need TI/SYSTEM (Access denied)
:: schtasks /Change /Disable /TN "\Microsoft\Windows\UpdateOrchestrator\Schedule Scan"
:: schtasks /Change /Disable /TN "\Microsoft\Windows\UpdateOrchestrator\Schedule Scan Static Task"
:: schtasks /Change /Disable /TN "\Microsoft\Windows\UpdateOrchestrator\Schedule Wake To Work"
:: schtasks /Change /Disable /TN "\Microsoft\Windows\UpdateOrchestrator\Schedule Work"
:: schtasks /Change /Disable /TN "\Microsoft\Windows\UpdateOrchestrator\UpdateModelTask"
:: schtasks /Change /Disable /TN "\Microsoft\Windows\UpdateOrchestrator\USO_UxBroker"

:right-click
reg add "HKCR\DesktopBackground\Shell\0Toggle\shell\1Update" /v "icon" /t REG_SZ /d "c:\windows\SystemResources\compstui.dll.mun,-64007" /f
reg add "HKCR\DesktopBackground\Shell\0Toggle\shell\1Update" /v "MUIVerb" /t REG_SZ /d "Enable Update" /f

TASKKILL /F /IM msiexec.exe /T
exit
