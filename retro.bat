@echo off
goto:rem
***************************************
This file is part of RetroBat Scripts.
---------------------------------------
file name: retro.bat
language: batch, powershell, javascript
author: Kayl
hello here 
***************************************
:rem

if not "%CD%"=="%cd: =%" (
	echo.
    echo Current directory contains spaces in its path.
    echo You need to rename the directory to one not containing spaces to launch this script.
    echo.
    timeout /t 5 >nul
    goto exit
) else (
	goto start
)

:start
rem title RetroBat ES Launcher
set name=RetroBat
set setup_info=setup.info
set launcher_file=retro.bat
set setup_file=setup.bat
set setup_dir=%cd:~3%>nul
set setup_dir=%setup_dir:"=%
set setup_dir=\%setup_dir%
set batocera_dir=\batocera
set void=

set current_dir=%cd:~3%>nul
set current_dir=%current_dir:"=%
set current_dir=\%current_dir%

if not "%current_dir%"=="%setup_dir%" break>%CD%\system\setup.info

if exist %CD%\System\version.info set/p version=<%CD%\System\version.info
if exist %CD%\emulationstation\about.info set/p local_es_version=<%CD%\emulationstation\about.info
set "current_es_version=RETROBAT ES V%version%"
if not "%local_es_version%"=="%current_es_version%" (
  break>%CD%\emulationstation\about.info
  break>%CD%\emulationstation\version.info
  echo %current_es_version%>> %CD%\emulationstation\about.info
  echo %current_es_version%>> %CD%\emulationstation\version.info
  set/p local_es_version=<%CD%\emulationstation\about.info
)

goto check_config

:check_config
net session >nul 2>&1
if %ERRORLEVEL% == 0 goto admin_fail
Reg Query "HKLM\Hardware\Description\System\CentralProcessor\0" | find /i "x86" > nul && set PROCARCH=32 || set PROCARCH=64
if not exist %CD%\system\setup.info (
  echo %void%>> "%CD%\system\setup.info"
  break>%CD%\system\setup.info
)
set NoSetupInfo=1
for /F %%a in (%CD%\System\setup.info) do set NoSetupInfo=0
if "%NoSetupInfo%"=="1" (
	goto set_info
) else (
	goto set_config_files
)

:set_info
if "%setup_dir%"=="\" goto exit
echo setup_dir=%setup_dir%>> %CD%\system\%setup_info%
echo batocera_dir=%batocera_dir%>> %CD%\system\%setup_info%
echo name=%name%>> %CD%\system\%setup_info%
echo version=%version%>> %CD%\system\%setup_info%
echo system_dir=%setup_dir%\system>> %CD%\system\%setup_info%
echo scripts_dir=%setup_dir%\system\scripts>> %CD%\system\%setup_info%
echo config_dir=%setup_dir%\configs>> %CD%\system\%setup_info%
echo templates_dir=%setup_dir%\system\templates>> %CD%\system\%setup_info%
echo rbmenu_dir=%setup_dir%\system\configmenu>> %CD%\system\%setup_info%
echo temp_dir=%setup_dir%\system\downloads>> %CD%\system\%setup_info%
echo emulators_dir=%setup_dir%\emulators>> %CD%\system\%setup_info%
echo retroarch_dir=%setup_dir%\emulators\retroarch>> %CD%\system\%setup_info%
echo retroarch_config_dir=%setup_dir%\emulators\retroarch\config>> %CD%\system\%setup_info%
echo es_dir=%setup_dir%\emulationstation>> %CD%\system\%setup_info%
echo es_config_dir=%setup_dir%\emulationstation\.emulationstation>> %CD%\system\%setup_info%
echo medias_dir=%setup_dir%\medias>> %CD%\system\%setup_info%
echo saves_dir=%setup_dir%\saves>> %setup_dir%\system\%setup_info%
echo shots_dir=%setup_dir%\screenshots>> %setup_dir%\system\%setup_info%
echo bios_dir=%setup_dir%\bios>> %setup_dir%\system\%setup_info%
echo games_dir=%setup_dir%\roms>> %setup_dir%\system\%setup_info%

for /f "delims=" %%x in (%CD%\system\setup.info) do (set "%%x")

call %scripts_dir%\systemsnames.cmd
call %scripts_dir%\mkfolders.cmd
call %scripts_dir%\mkemu.cmd

cd %setup_dir%

goto set_config_files

:set_config_files
if not exist %setup_dir%\configs\. md %setup_dir%\configs
if not exist %setup_dir%\configs\retrobat.cfg copy/y %setup_dir%\system\templates\configs\retrobat.cfg %setup_dir%\configs\retrobat.cfg>nul
if not exist %setup_dir%\configs\systems_resolutions.cfg copy/y %setup_dir%\system\templates\configs\systems_resolutions.cfg %setup_dir%\configs\systems_resolutions.cfg>nul
if exist %setup_dir%\configs\retrobat.cfg goto read_configs
title %name% v%version%
goto read_configs

:read_configs
for /f "delims=" %%x in (%CD%\system\setup.info) do (set "%%x")
for /f "delims=" %%x in (%CD%\configs\retrobat.cfg) do (set "%%x")

if exist %system_dir%\check.install (
  echo +============================================+
  echo   RETROBAT SETUP V%version%
  echo +============================================+
  cd %setup_dir%
  echo.
  echo Verifying RetroBat's files structure. Please wait...
  call %scripts_dir%\systemsnames.cmd
  call %scripts_dir%\mkfolders.cmd
  call %scripts_dir%\mkemu.cmd
  timeout /t 3 >nul
  cd %setup_dir%
)

if exist %system_dir%\check.install echo Done. You can now run RetroBat !
if exist %system_dir%\check.install timeout /t 3 >nul
if exist %system_dir%\check.install del/Q %system_dir%\check.install>nul && goto exit
set current_dir=%cd:~3%>nul
set current_dir=%current_dir:"=%
set current_dir=\%current_dir%
if not "%current_dir%"=="%setup_dir%" (
  break>%CD%\system\setup.info 
  goto start
) else (
  goto run_emulationstation
)

:run_emulationstation
if not exist %es_dir%\emulationstation.exe goto esfail
if exist %scripts_dir%\desktop_resolution.info for /f "delims=" %%x in (%scripts_dir%\desktop_resolution.info) do (set "%%x")
set wait_for_exit=
if "%set_screen_resolution%"=="1" (
  call %scripts_dir%\detectscreenres.cmd
  set "wait_for_exit=& %system_dir%\modules\qres.exe /X:%desktop_xres% /Y:%desktop_yres%"
)

if "%es_menu_noexit%"=="1" (
  set esArg1=--no-exit
) else (
  set esArg1=
)
if "%play_splash_video%"=="1" if exist %es_config_dir%\video\%splashscreen_file% (
start "EmulationStation" %CD%\emulationstation\emulationstation.exe --video "%CD%\emulationstation\.emulationstation\video\%splashscreen_file%"
)
if "%es_is_fullscreen%"=="1" (
  set "es_screen_settings=--fullscreen-borderless"
) else (
  set "es_screen_settings=--windowed --resolution %es_window_size_x% %es_window_size_y%"
)

start "EmulationStation" %CD%\emulationstation\emulationstation.exe %es_screen_settings% %esArg1% %wait_for_exit%>nul
call %scripts_dir%\focus.cmd

goto exit

:esFail
Echo EmulationStation files are missing.
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

:exit
exit