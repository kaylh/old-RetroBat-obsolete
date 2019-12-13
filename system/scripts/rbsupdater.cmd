@echo off
goto:rem
***************************************
This file is part of RetroBat Scripts. 
***************************************
:rem
:update_retrobat
set updatedone=0
If not exist %temp_dir%\. md %temp_dir%
set current_url=https://www.retrobat.ovh/releases/retrobat-latest.zip
set output_dir=%temp_dir%\retrobat-latest.zip
call %scripts_dir%\powershelldl.cmd
ping 127.0.0.1 -n 4 >nul
timeout /t 1 >nul
if not exist %output_dir% goto pkg_fail
echo.
echo -- Extracting latest version of RetroBat Scripts --
echo.
%zip_dir%\7zg.exe -y x "%output_dir%" -o"%temp_dir%" -aoa>nul
echo Done.
timeout /t 1 >nul
echo.
echo -- Updating RetroBat Scripts --
echo.
xcopy/Y /e /i "%temp_dir%\retrobat" "%setup_dir%" 2>&1
if exist %temp_dir%\retrobat\. rmdir /s /q %temp_dir%\retrobat
timeout /t 1 >nul
set/A updatedone=updatedone+1
cls
echo +===========================================================+
echo               RETROBAT SCRIPTS UPDATE IS DONE !
echo +===========================================================+
echo  Reloading RetroBat setup...
timeout /t 3 >nul
goto:eof   