@echo off
REM Mossy Launcher - AI Programs Detection Script Launcher
REM This batch file runs the PowerShell detection script with appropriate permissions

echo Starting AI Programs Detection...
echo.

REM Run PowerShell script with bypass execution policy for this session only
powershell.exe -ExecutionPolicy Bypass -File "%~dp0detect-ai-programs.ps1"

REM Pause to show any error messages if PowerShell had issues
if errorlevel 1 (
    echo.
    echo The script encountered an error. Please check the output above.
    pause
)
