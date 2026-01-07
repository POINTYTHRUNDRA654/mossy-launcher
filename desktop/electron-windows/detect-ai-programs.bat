@echo off
REM Mossy Launcher - AI Programs Detection Script Launcher
REM This batch file runs the PowerShell detection script with appropriate permissions

echo Starting AI Programs Detection...
echo.

REM Run PowerShell script with bypass execution policy for this session only
powershell.exe -ExecutionPolicy Bypass -File "%~dp0detect-ai-programs.ps1"

REM Check if PowerShell is not available
if errorlevel 1 (
    echo.
    echo ERROR: PowerShell is required to run this script.
    echo PowerShell should be installed by default on Windows 7 and later.
    echo.
    pause
)
