@echo off
setlocal enabledelayedexpansion
:: Ensure we are running as Admin
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo [!] ERROR: Please right-click and "Run as Administrator".
    pause
    exit /b
)

:: Get Total RAM and Initial Free Space
for /f "tokens=*" %%a in ('powershell -command "[math]::Round((Get-CimInstance Win32_PhysicalMemory | Measure-Object Capacity -Sum).Sum / 1GB)"') do set ram_gb=%%a
for /f "tokens=*" %%a in ('powershell -command "[math]::Round((Get-PSDrive C).Free / 1GB, 4)"') do set space_before=%%a

cls
echo ============================================
echo    %ram_gb%GB RAM SYSTEM - DEEP MAINTENANCE
echo ============================================

:: 1. Flush Hibernation
echo [+] Removing Hibernation File...
powercfg /hibernate off >nul 2>&1

:: 2. Clean Windows Update Cache
echo [+] Cleaning Windows Update Cache...
net stop wuauserv >nul 2>&1
net stop bits >nul 2>&1
del /f /s /q %windir%\SoftwareDistribution\*.* >nul 2>&1
net start bits >nul 2>&1
net start wuauserv >nul 2>&1

:: 3. Wipe All Temp Folders
echo [+] Wiping User and System Temp folders...
del /f /s /q %temp%\*.* >nul 2>&1
del /f /s /q %systemroot%\temp\*.* >nul 2>&1

:: 4. Wipe Prefetch
echo [+] Wiping Prefetch cache...
del /f /s /q %systemroot%\Prefetch\*.* >nul 2>&1

:: 5. Empty Recycle Bin
echo [+] Emptying Recycle Bin...
rd /s /q %systemdrive%\$Recycle.Bin >nul 2>&1

:: 6. The Grand Finale
echo.
echo ============================================
echo             WINDOWS POO GONE NOW!
echo ============================================
echo.

:: Calculate Final Space and Difference
for /f "tokens=*" %%a in ('powershell -command "[math]::Round((Get-PSDrive C).Free / 1GB, 4)"') do set space_after=%%a
for /f "tokens=*" %%a in ('powershell -command "$diff = %space_after% - %space_before%; if ($diff -lt 1) { [math]::Round($diff * 1024, 2).ToString() + ' MB' } else { [math]::Round($diff, 2).ToString() + ' GB' }"') do set total_freed=%%a

echo [+] Space Before: %space_before% GB
echo [+] Space After:  %space_after% GB
echo [+] Total Poo flushed: %total_freed%
echo.
echo ============================================
echo Press any key to exit...
pause >nul