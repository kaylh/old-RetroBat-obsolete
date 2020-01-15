@ECHO OFF
goto:rem
***************************************
This file is part of RetroBat Scripts. 
***************************************
:rem

:load_config
for /f "delims=" %%x in (%CD%\System\retrobat.setup) do (set "%%x")
For /f "delims=" %%x in (%CD%\configs\emulationstation.cfg) do (set "%%x")
title RetroBat Launcher
goto check_path

:check_path
set current_dir=%cd:~3%>nul
set current_dir=%current_dir:"=%
set current_dir=\%current_dir%
if "%current_dir%"=="%setup_dir%" (
	cd %es_dir%
	goto check_proc	
) else (
	set current_dir=1
	echo.
	echo Setup directory has changed. Loading setup to fix it...
	echo.
	timeout /t 2 >nul
	call %current_dir%\setup.bat
	goto exit
)

:check_proc
Reg Query "HKLM\Hardware\Description\System\CentralProcessor\0" | find /i "x86" > nul && set PROCARCH=32 || set PROCARCH=64
If %PROCARCH%==32 goto proc_fail
If %PROCARCH%==64 goto check_admin

:check_admin
net session >nul 2>&1
if %ERRORLEVEL% == 0 (
    goto admin_fail
) else (
    goto check_splash
)

:check_winver
cls
for /f "tokens=4-5 delims=. " %%i in ('ver') do set WINVER=%%i.%%j
echo.
if "%winver%" == "6.0" echo :: Running %name% %version% on Windows Vista %PROCARCH% bit
if "%winver%" == "6.1" echo :: Running %name% %version% on Windows 7 %PROCARCH% bit
if "%winver%" == "6.2" echo :: Running %name% %version% on Windows 8 %PROCARCH% bit
if "%winver%" == "6.3" echo :: Running %name% %version% on Windows 8.1 %PROCARCH% bit
if "%winver%" == "10.0" echo :: Running %name% %version% on Windows 10 %PROCARCH% bit
echo.
timeout /t 2 >nul
goto check_splash

:check_splash
If "%play_splash_video%"=="yes" (
	goto run_splash
) else (
	goto run_es
)

:run_splash
If not exist %es_dir%\emulationstation.exe goto esfail
If exist %es_config_dir%\video\%splashscreen_file% emulationstation.exe --video ".emulationstation\video\%splashscreen_file%"
goto run_es

:run_es
set run_es=emulationstation.exe --fullscreen
set run_es_w=emulationstation.exe --windowed --resolution %es_resolution_width% %es_resolution_height%
if not exist %es_dir%\emulationstation.exe goto esfail
if "%es_is_fullscreen%"=="yes" (
	start %run_es%
	call %scripts_dir%\focus.cmd
) else (
	start %run_es_w%
	call %scripts_dir%\focus.cmd
)
goto delete_junkfiles

:delete_junkfiles
cd %setup_dir%
cd ..
if exist *.fs del *.fs
goto exit

:esFail
Echo EmulationStation files are missing. Run %setup_info% to download software.
echo -----
timeout /t 3 >nul
goto exit

:admin_fail
cls
Echo.
ECHO  Please run this script not as administrator.
Echo.
timeout /t 5 >nul
GOTO exit

:proc_fail
cls
Echo.
ECHO  RetroBat Scripts only run on 64 bits system.
Echo.
timeout /t 5 >nul
GOTO exit

:pkg_fail
cls
Echo.
Echo  An error occured and package files can not be found.
Echo.
timeout /t 5 >nul
GOTO exit

:exit
exit