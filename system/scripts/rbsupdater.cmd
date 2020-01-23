@echo off
goto:rem
***************************************
This file is part of RetroBat Scripts.
---------------------------------------
file name: rbsupdater.cmd
language: batch
author: Kayl 
***************************************
:rem
:update_retrobat
set updatedone=0
If not exist %temp_dir%\. md %temp_dir%
set current_url=https://www.retrobat.ovh/releases/retrobat-latest.zip
set output_dir=%temp_dir%\retrobat-latest.zip
cls
echo -- Downloading latest RetroBat --
echo.
call %scripts_dir%\powershelldl.cmd
ping 127.0.0.1 -n 4 >nul
timeout /t 2 >nul
if not exist %output_dir% goto pkg_fail
cls
echo.
echo -- Removing outdated files --
echo.
if exist %setup_dir%\retro.bat del/Q %setup_dir%\retro.bat
rmdir /s /q %setup_dir%\system\configmenu
rmdir /s /q %setup_dir%\system\templates
timeout /t 1 >nul
cls
echo.
echo -- Extracting RetroBat archive --
echo.
%zip_dir%\7zg.exe -y x "%output_dir%" -o"%temp_dir%" -aoa
timeout /t 1 >nul
if exist %output_dir% del/Q %output_dir%
echo Done.
echo.
echo -- Upgrading RetroBat --
echo.
xcopy/Y /e /i "%temp_dir%\retrobat" "%setup_dir%"
if exist %temp_dir%\retrobat\. rmdir /s /q %temp_dir%\retrobat
timeout /t 2 >nul
set/A updatedone=updatedone+1
echo Done. > %setup_dir%\system\retrobat.update
cls
echo +===========================================================+
echo                       RETROBAT UPDATE
echo +===========================================================+
echo  To complete RetroBat update to %rbonlinever%, you need to run
echo  again setup.bat. 
echo  EmulationStation, RetroArch and configuration files will be
echo  automatically updated.
echo  Please wait until the process is completed.
echo +===========================================================+
echo Press any key to exit...
pause>nul
exit 