@echo off
goto:rem
***************************************
This file is part of RetroBat Scripts.
---------------------------------------
file name: setup.bat
language: batch, powershell
author: Kayl
***************************************
:rem

:create_config
echo Please wait...
set name=RetroBat
set/p version=<%CD%\System\retrobat.version
set setup_info=retrobat.setup
if exist %CD%\System\%setup_info% break>%CD%\System\%setup_info%
set launcher_file=retro.bat
set setup_file=setup.bat
set setup_dir=%cd:~3%>nul
set setup_dir=%setup_dir:"=%
set setup_dir=\%setup_dir%
if "%setup_dir%"=="\" goto exit
echo setup_dir=%setup_dir%>> %CD%\System\%setup_info%
echo name=%name%>> %CD%\System\%setup_info%
echo version=%version%>> %CD%\System\%setup_info%
echo system_dir=%setup_dir%\system>> %CD%\System\%setup_info%
echo scripts_dir=%setup_dir%\system\scripts>> %CD%\System\%setup_info%
echo config_dir=%setup_dir%\configs>> %CD%\System\%setup_info%
echo templates_dir=%setup_dir%\system\templates>> %CD%\System\%setup_info%
echo rbmenu_dir=%setup_dir%\system\configmenu>> %CD%\System\%setup_info%
echo temp_dir=%setup_dir%\system\downloads>> %CD%\System\%setup_info%
echo emulators_dir=%setup_dir%\emulators>> %CD%\System\%setup_info%
echo retroarch_dir=%setup_dir%\emulators\retroarch>> %CD%\System\%setup_info%
echo retroarch_config_dir=%setup_dir%\emulators\retroarch\config>> %CD%\System\%setup_info%
echo es_dir=%setup_dir%\emulationstation>> %CD%\System\%setup_info%
echo es_config_dir=%setup_dir%\emulationstation\.emulationstation>> %CD%\System\%setup_info%
echo saves_dir=%setup_dir%\saves>> %CD%\System\%setup_info%
echo shots_dir=%setup_dir%\screenshots>> %CD%\System\%setup_info%
echo bios_dir=%setup_dir%\bios>> %CD%\System\%setup_info%
echo games_dir=%setup_dir%\roms>> %CD%\System\%setup_info%
echo medias_dir=%setup_dir%\medias>> %CD%\System\%setup_info%
title %name% Setup
goto load_config

:load_config
for /f "delims=" %%x in (%CD%\System\%setup_info%) do (set "%%x")
cd %setup_dir%
goto check_proc

:check_proc
Reg Query "HKLM\Hardware\Description\System\CentralProcessor\0" | find /i "x86" > nul && set PROCARCH=32 || set PROCARCH=64
::If %PROCARCH%==32 goto proc_fail
::If %PROCARCH%==64 goto check_admin
goto check_admin

:check_admin
net session >nul 2>&1
if %ERRORLEVEL% == 0 (
    goto admin_fail
) else (
    goto check_winver
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
timeout /t 1 >nul
goto check_config

:check_config
if not exist %temp_dir%\. md %temp_dir%
if not exist %config_dir%\. md %config_dir%
if exist %setup_dir%\system\retrobat.update copy/Y %templates_dir%\configs\emulationstation.cfg %config_dir%\emulationstation.cfg>nul
if not exist %config_dir%\emulationstation.cfg copy/Y %templates_dir%\configs\emulationstation.cfg %config_dir%\emulationstation.cfg>nul
if not exist %setup_dir%\%launcher_file% if exist %scripts_dir%\%launcher_file% copy/y %scripts_dir%\%launcher_file% %setup_dir%\%launcher_file%>nul
call %scripts_dir%\pkgsources.cmd
goto check_sfx

:check_sfx
set SFX=0
if exist %setup_dir%\SFX (
	set/A SFX=SFX+1
	del/Q %setup_dir%\SFX
	goto check_pkg
) else (
	goto check_pkg
)

:check_pkg
echo *** Checking required softwares
echo.
timeout /t 1 >nul
goto check_7zip

:check_7zip
set inst7z=0
set portable7z=0
set local7z=0
set forcearch=0

If exist %system_dir%\7zip\7zG.exe set/A inst7z=inst7z+1 & set/A portable7z=portable7z+1

if "%ProgramFiles%"=="%ProgramFiles(x86)%" set/A forcearch=forcearch+1

if "%forcearch%"=="0" if exist "%ProgramFiles%"\7-Zip\7zG.exe set/A inst7z=inst7z+1 & set/A local7z=local7z+1
if "%forcearch%"=="1" if exist "%ProgramW6432%"\7-Zip\7zG.exe set/A inst7z=inst7z+1 & set/A local7z=local7z+1

if "%portable7z%"=="1" set zip_dir=%system_dir%\7zip
if "%local7z%"=="1" set zip_dir="%ProgramFiles%"\7-Zip

if "%inst7z%"=="0" (
	echo [ 7-Zip ] -- not found
	timeout /t 1 >nul
	goto dl_7zip
) else (
	echo [ 7-Zip ] -- found
	timeout /t 1 >nul
	goto check_required
)
goto check_required

:dl_7zip
cls
echo -- 7-Zip is downloading --
echo.
If %PROCARCH%==32 set current_url=http://www.retrobat.ovh/repo/tools/7z32-pkg.zip
If %PROCARCH%==64 set current_url=http://www.retrobat.ovh/repo/tools/7z64-pkg.zip
set output_dir=%temp_dir%\7z64-pkg.zip
call %scripts_dir%\powershelldl.cmd
if %ERRORLEVEL% == 1 goto pkgFail
ping 127.0.0.1 -n 4 >nul
timeout /t 1 >nul
goto install_7zip

:install_7zip
cls
echo.
echo -- 7-Zip is installing --
echo.
if not exist %system_dir%\7zip\. md %system_dir%\7zip
powershell -command "Expand-Archive -Force -LiteralPath "%temp_dir%\7z64-pkg.zip" -DestinationPath %system_dir%\7zip"
del/q "%temp_dir%\7z64-pkg.zip"
echo Done.
timeout /t 1 >nul
cls
goto check_pkg

:check_required
echo.
set mainpkg=0
set esbin=0
if exist %es_dir%\emulationstation.exe set/A esbin=esbin+1 & set/A mainpkg=mainpkg+1
if "%esbin%"=="1" echo [ EmulationStation ] -- found
if "%esbin%"=="0" echo [ EmulationStation ] -- not found
timeout /t 1 >nul
echo.
set rabin=0
if exist %emulators_dir%\retroarch\retroarch.exe set/A rabin=rabin+1 & set/A mainpkg=mainpkg+1
if "%rabin%"=="1" echo [ RetroArch ] -- found
if "%rabin%"=="0" echo [ RetroArch ] -- not found
timeout /t 1 >nul
echo.
set libretrocores=0
if exist %emulators_dir%\retroarch\cores\*_libretro.dll set/A libretrocores=libretrocores+1 & set/A mainpkg=mainpkg+1
if "%libretrocores%"=="1" echo [ Libretro Cores ] -- found
if "%libretrocores%"=="0" echo [ Libretro Cores ] -- not found
timeout /t 1 >nul
echo.
set fullinstall=0
if exist %setup_dir%\system\retrobat.update goto create_folders
if "%SFX%"=="1" goto update_retroarch_config1
if %mainpkg% GTR 0 goto welcome_menu
if "%mainpkg%"=="0" set/p mainpkg="- Do you want to install them now ? (y)es, (n)o, (q)uit: "
if "%mainpkg%"=="Y" set/A fullinstall=fullinstall+1
if "%mainpkg%"=="Y" goto create_folders
if "%mainpkg%"=="y" set/A fullinstall=fullinstall+1
if "%mainpkg%"=="y" goto create_folders
if "%mainpkg%"=="N" goto create_folders
if "%mainpkg%"=="n" goto create_folders
if "%mainpkg%"=="Q" goto exit
if "%mainpkg%"=="q" goto exit
goto check_required

:create_folders
cls
set go=0
echo.
echo -- Creating some folders if they not exist --
echo.

call %scripts_dir%\mkfolders.cmd

if exist %setup_dir%\system\retrobat.update goto dl_ES
if "%go%"=="7" goto debug_menu
if "%fullinstall%"=="1" goto dl_ES
goto welcome_menu

:dl_ES
cls
set current_url=%emulationstation_url%
set output_dir=%temp_dir%\es-bin-pkg.zip
if exist %output_dir% goto install_ES
echo -- EmulationStation is now downloading --
echo.
call %scripts_dir%\powershelldl.cmd
if %ERRORLEVEL% == 1 goto pkg_fail
ping 127.0.0.1 -n 4 >nul
timeout /t 1 >nul
echo Done.
goto install_ES

:update_ES
cls
set current_url=%emulationstation_update_url%
set output_dir=%temp_dir%\es-bin-update-pkg.zip
if exist %output_dir% goto install_ES
echo -- EmulationStation is now downloading --
echo.
call %scripts_dir%\powershelldl.cmd
if %ERRORLEVEL% == 1 goto pkg_fail
ping 127.0.0.1 -n 4 >nul
timeout /t 1 >nul
echo Done.
goto install_ES

:install_ES
CLS
echo.
echo -- EmulationStation is installing --
echo.
if not exist %es_dir%\. md %es_dir%
if exist %output_dir% %zip_dir%\7zg.exe -y x "%output_dir%" -o"%es_dir%" -aoa>nul
if not exist %es_config_dir%\. md %es_config_dir%>nul
if not exist %es_config_dir%\scripts\. md %es_config_dir%\scripts>nul
if not exist %es_config_dir%\themes\. md %es_config_dir%\themes>nul
if not exist %es_config_dir%\music\. md %es_config_dir%\music>nul
if not exist %es_config_dir%\video\. md %es_config_dir%\video>nul
xcopy/Y /e /i "%templates_dir%\emulationstation\scripts" "%es_config_dir%\scripts" 2>nul
set bgmusic=0
if not exist %es_config_dir%\music\*.ogg set/A bgmusic=bgmusic+1
if not exist %es_config_dir%\music\*.mp3 set/A bgmusic=bgmusic+1
if "%bgmusic%"=="0" if exist %templates_dir%\emulationstation\music.ogg copy/Y %templates_dir%\emulationstation\music.ogg %es_config_dir%\music\music.ogg>nul
if exist %temp_dir%\*-pkg.zip del/Q %temp_dir%\*-pkg.zip>nul
if exist %temp_dir%\*-pkg.7z del/Q %temp_dir%\*-pkg.7z>nul
goto dl_vcredistdll

:dl_vcredistdll
cls
set current_url=https://www.retrobat.ovh/repo/tools/vcredist-dll-pkg.zip
set output_dir=%temp_dir%\vcredist-dll-pkg.zip
if exist %output_dir% goto install_vcredistdll
echo -- Required VisualC++ DLLs are now downloading --
echo.
call %scripts_dir%\powershelldl.cmd
if %ERRORLEVEL% == 1 goto pkg_fail
ping 127.0.0.1 -n 4 >nul
timeout /t 1 >nul
echo Done.
goto install_vcredistdll

:install_vcredistdll
CLS
echo.
echo -- Required VisualC++ DLLs are installing --
echo.
if not exist %es_dir%\. md %es_dir%
if exist %output_dir% %zip_dir%\7zg.exe -y x "%output_dir%" -o"%es_dir%" -aoa>nul
if exist %temp_dir%\*-pkg.zip del/Q %temp_dir%\*-pkg.zip>nul
if exist %temp_dir%\*-pkg.7z del/Q %temp_dir%\*-pkg.7z>nul
goto config_es

:config_es
set esconf=0
if exist %es_config_dir%\es_input.cfg set/A esconf=esconf+1
if %esconf% EQU 0 copy/Y %templates_dir%\emulationstation\es_input.cfg %es_config_dir%\es_input.cfg>nul
if %esconf% EQU 1 copy/Y %templates_dir%\emulationstation\es_input.cfg %es_config_dir%\es_input.cfg.new>nul
set esconf=0
if exist %es_config_dir%\es_settings.cfg set/A esconf=esconf+2
if %esconf% EQU 0 copy/Y %templates_dir%\emulationstation\es_settings.cfg %es_config_dir%\es_settings.cfg>nul
if %esconf% EQU 2 copy/Y %templates_dir%\emulationstation\es_settings.cfg %es_config_dir%\es_settings.cfg.new>nul
set esconf=0
if exist %es_config_dir%\es_systems.cfg set/A esconf=esconf+3
if %esconf% EQU 0 copy/Y %templates_dir%\emulationstation\es_systems.cfg %es_config_dir%\es_systems.cfg>nul
if %esconf% EQU 3 copy/Y %templates_dir%\emulationstation\es_systems.cfg %es_config_dir%\es_systems.cfg.new>nul
if %esconf% EQU 3 copy/Y %es_config_dir%\es_systems.cfg %es_config_dir%\es_systems.cfg.old>nul
if exist %es_config_dir%\es_systems.cfg.new copy/Y %es_config_dir%\es_systems.cfg.new %es_config_dir%\es_systems.cfg>nul
if exist %es_config_dir%\es_systems.cfg.new del/Q %es_config_dir%\es_systems.cfg.new>nul
timeout /t 1 >nul
if exist %es_config_dir%\*.new goto update_ES_confirm
if "%fullinstall%"=="1" set themename=carbon
if "%fullinstall%"=="1" goto dl_default_theme
if "%singledl%"=="1" goto setup_menu

:update_ES_confirm
cls
if exist %setup_dir%\system\retrobat.update goto update_ES_config
if "%fullinstall%"=="1" goto update_ES_config
echo +===========================================================+
echo   SETUP HAS DETECTED EXISTING SETTINGS FOR EMULATIONSTATION
echo +===========================================================+
echo  ( 1 ) Keep current settings:
echo        If you want to keep your ES settings like controller
echo        configuration and others options choosen in ES, this 
echo        is generally a good choice.
echo +-----------------------------------------------------------+
echo  ( 2 ) Override settings:
echo        If you want to reset ES settings to default, choose
echo        this.
echo +===========================================================+
set updateESconf=1
set/p updateESconf="- Please choose one (1-2): "
if "%updateESconf%"=="1" del/q %es_config_dir%\*.new && goto setup_menu
if "%updateESconf%"=="2" goto update_ES_config
goto update_ES_confirm

:update_ES_config
cls
echo.
echo -- Override EmulationStation settings --
echo.
copy/Y %es_config_dir%\es_settings.cfg.new %es_config_dir%\es_settings.cfg>nul
copy/Y %es_config_dir%\es_input.cfg.new %es_config_dir%\es_input.cfg>nul
if exist %es_config_dir%\*.new del/Q %es_config_dir%\*.new
timeout /t 1 >nul
if "%singledl%"=="1" goto setup_menu
if exist %setup_dir%\system\retrobat.update set themename=carbon
if exist %setup_dir%\system\retrobat.update goto dl_default_theme
if "%fullinstall%"=="1" set themename=carbon
if "%fullinstall%"=="1" goto dl_default_theme
if "%go%"=="2" goto debug_menu
if "%go%"=="3" goto debug_menu
goto setup_menu

:dl_default_theme
cls
if exist %setup_dir%\system\retrobat.update if exist %setup_dir%\emulationstation\.emulationstation\themes\es-theme-carbon-master\. rmdir /s /q %setup_dir%\emulationstation\.emulationstation\themes\es-theme-carbon-master\.
set current_url=https://github.com/kaylh/es-theme-%themename%/archive/master.zip
set output_dir=%temp_dir%\%themename%-theme-pkg.zip
if exist %output_dir% goto install_default_theme
echo -- Theme for EmulationStation is now downloading ( %themename% ) --
echo.
call %scripts_dir%\powershelldl.cmd
if %ERRORLEVEL% == 1 goto pkgFail
ping 127.0.0.1 -n 4 >nul
timeout /t 1 >nul
echo Done.
goto install_default_theme

:dl_extra_theme
cls
set output_dir=%temp_dir%\%themename%-theme-pkg.zip
if exist %output_dir% goto install_default_theme
echo -- Theme for EmulationStation is now downloading ( %themename% ) --
echo.
call %scripts_dir%\powershelldl.cmd
if %ERRORLEVEL% == 1 goto pkgFail
ping 127.0.0.1 -n 4 >nul
timeout /t 1 >nul
echo Done.
goto install_default_theme

:install_default_theme
cls
If not exist %temp_dir%\. md %temp_dir%
if not exist %es_config_dir%\. md %es_config_dir%
if not exist %es_config_dir%\themes\. md %es_config_dir%\themes
echo.
ECHO -- Theme for EmulationStation is installing ( %themename% ) --
ECHO.
%zip_dir%\7zg.exe -y x "%output_dir%" -o"%es_config_dir%\themes" -aoa>nul
if exist %temp_dir%\*-pkg.zip del/Q %temp_dir%\*-pkg.zip>nul
if exist %temp_dir%\*-pkg.7z del/Q %temp_dir%\*-pkg.7z>nul
echo Done.
timeout /t 1 >nul
if exist %setup_dir%\system\retrobat.update goto dl_retroarch_stable
if "%singledl%"=="1" goto setup_menu
if "%fullinstall%"=="1" goto dl_retroarch_stable
goto setup_menu

:dl_retroarch_stable
cls
If %PROCARCH%==32 set current_url=%retroarch_stable_32bit_url%
If %PROCARCH%==64 set current_url=%retroarch_stable_url%
set output_dir=%temp_dir%\retroarch-stable-pkg.7z
if exist %output_dir% goto install_retroarch
echo -- RetroArch Stable is now downloading --
echo.
call %scripts_dir%\powershelldl.cmd
if %ERRORLEVEL% == 1 goto pkgFail
ping 127.0.0.1 -n 4 >nul
timeout /t 1 >nul
echo Done.
goto install_retroarch

:update_retroarch_stable
cls
If %PROCARCH%==32 set current_url=%retroarch_stable_update_32bit_url%
If %PROCARCH%==64 set current_url=%retroarch_stable_update_url%
set output_dir=%temp_dir%\retroarch-stable-update-pkg.zip
if exist %output_dir% goto install_retroarch
echo -- RetroArch Stable is now downloading --
echo.
call %scripts_dir%\powershelldl.cmd
if %ERRORLEVEL% == 1 goto pkgFail
ping 127.0.0.1 -n 4 >nul
timeout /t 1 >nul
echo Done.
goto install_retroarch

:dl_retroarch_nightly
cls
If %PROCARCH%==32 set current_url=%retroarch_nightly_32bit_url%
If %PROCARCH%==64 set current_url=%retroarch_nightly_url%
set output_dir=%temp_dir%\retroarch-nightly-pkg.7z
if exist %output_dir% goto install_retroarch
echo -- RetroArch Nightly is now downloading --
echo.
call %scripts_dir%\powershelldl.cmd
if %ERRORLEVEL% == 1 goto pkgFail
ping 127.0.0.1 -n 4 >nul
timeout /t 1 >nul
echo Done.
goto install_retroarch

:update_retroarch_nightly
cls
If %PROCARCH%==32 set current_url=%retroarch_nightly_update_32bit_url%
If %PROCARCH%==64 set current_url=%retroarch_nightly_update_url%
set output_dir=%temp_dir%\retroarch-nightly-update-pkg.zip
if exist %output_dir% goto install_retroarch
echo -- RetroArch Nightly is now downloading --
echo.
call %scripts_dir%\powershelldl.cmd
if %ERRORLEVEL% == 1 goto pkgFail
ping 127.0.0.1 -n 4 >nul
timeout /t 1 >nul
echo Done.
goto install_retroarch

:install_retroarch
cls
If not exist %temp_dir%\. md %temp_dir%
if not exist %retroarch_dir%\. md %retroarch_dir%
if not exist %retroarch_config_dir%\. md %retroarch_config_dir%
echo.
echo -- RetroArch is installing --
echo.
%zip_dir%\7zg.exe -y x "%output_dir%" -o"%retroarch_dir%" -aoa>nul
if exist %temp_dir%\*-pkg.zip del/Q %temp_dir%\*-pkg.zip>nul
if exist %temp_dir%\*-pkg.7z del/Q %temp_dir%\*-pkg.7z>nul
if exist %templates_dir%\retroarch\dolphin-emu\. xcopy/Y /e /i  "%templates_dir%\retroarch\dolphin-emu" "%retroarch_config_dir%\dolphin-emu" 2>&1
echo Done.
timeout /t 1 >nul
if exist %setup_dir%\system\retrobat.update goto update_retroarch_config_menu
if exist %retroarch_config_dir%\*.cfg goto update_retroarch_confirm
goto update_retroarch_config_menu


:update_retroarch_confirm
cls
if "%fullinstall%"=="1" goto update_retroarch_config_menu
echo +===========================================================+
echo      SETUP HAS DETECTED EXISTING SETTINGS FOR RETROARCH
echo +===========================================================+
echo  ( 1 ) Keep current settings:
echo        If you want to keep your RetroArch settings, this is
echo        generally a good choice.
echo +-----------------------------------------------------------+
echo  ( 2 ) Override settings:
echo        If you want to reset RetroArch settings to default, 
echo        choose this.
echo +===========================================================+
set updateRAconf=2
set/p updateRAconf="- Please choose one (1-2): "
if "%updateRAconf%"=="1" goto setup_menu
if "%updateRAconf%"=="2" goto update_retroarch_config_menu
goto update_retroarch_confirm

:update_retroarch_config_menu
cls
set racfg=2
if exist %setup_dir%\system\retrobat.update set racfgname=custom1
if exist %setup_dir%\system\retrobat.update goto update_retroarch_config1
if "%fullinstall%"=="1" set racfgname=custom1
if "%fullinstall%"=="1" goto update_retroarch_config1
echo +===========================================================+
echo     PLEASE CHOOSE A TEMPLATE FOR RETROARCH'S CONFIG FILE                 
echo +===========================================================+
echo  ( 1 )  Default RetroArch's settings:
echo         xmb menu, windowed, opengl
echo +-----------------------------------------------------------+
echo  ( 2 )  custom RetroArch's settings 1:
echo         ozone menu, fullscreen, opengl
echo +-----------------------------------------------------------+
echo  ( 3 )  custom RetroArch's settings 2:
echo         xmb menu, fullscreen, directx11
echo +-----------------------------------------------------------+
echo  ( 4 )  custom RetroArch's settings 3: 
echo         rgui menu, fullscreen, vulkan
echo +===========================================================+
echo   You can modify this settings later in retroarch's menu. 
echo +===========================================================+
set /p racfg="- Please choose one (1-4): "
if "%racfg%"=="1" set racfgname=default
if "%racfg%"=="2" set racfgname=custom1
if "%racfg%"=="3" set racfgname=custom2
if "%racfg%"=="4" set racfgname=custom3
goto update_retroarch_config1

:update_retroarch_config1
cls
echo.
echo -- Setting up RetroArch's configuration files --
echo.
if "%SFX%"=="1" set racfgname=custom1
if "%current_dir%"=="1" set racfgname=custom1
If not exist %retroarch_dir%\. md %retroarch_dir%
If not exist %retroarch_config_dir%\. md %retroarch_config_dir%
if exist %retroarch_dir%\retroarch.cfg (
	copy/y %retroarch_dir%\retroarch.cfg %retroarch_dir%\retroarch.cfg.old>nul
	del/q %retroarch_dir%\retroarch.cfg
	copy/y %templates_dir%\retroarch\retroarch-%racfgname%.cfg %retroarch_dir%\retroarch.cfg>nul
	timeout /t 1 >nul
	goto update_retroarch_config2
	) else (
	copy/y %templates_dir%\retroarch\retroarch-%racfgname%.cfg %retroarch_dir%\retroarch.cfg>nul
	timeout /t 1 >nul
	goto update_retroarch_config2
)

:update_retroarch_config2
cls
echo.
echo -- Setting up RetroArch's configuration files --
echo.
if exist %retroarch_config_dir%\retroarch-override.cfg (
    break>%retroarch_config_dir%\retroarch-override.cfg
    (echo screenshot_directory = "%shots_dir%" && echo system_directory = "%bios_dir%" && echo savefile_directory = "%saves_dir%" && echo savestate_directory = "%saves_dir%" && echo libretro_directory = "%retroarch_dir%\cores")>> %retroarch_config_dir%\retroarch-override.cfg
) else (
	if not exist %retroarch_config_dir%\. md %retroarch_config_dir%
    (echo screenshot_directory = "%shots_dir%" && echo system_directory = "%bios_dir%" && echo savefile_directory = "%saves_dir%" && echo savestate_directory = "%saves_dir%" && echo libretro_directory = "%retroarch_dir%\cores")>> %retroarch_config_dir%\retroarch-override.cfg
)
echo Done.
timeout /t 1 >nul
if exist %setup_dir%\system\retrobat.update goto update_es_systems
if "%SFX%"=="1" goto exit
if "%current_dir%"=="1" goto run_es
if "%singledl%"=="1" goto setup_menu
if "%fullinstall%"=="1" goto dl_lrarcade
goto setup_menu

:dl_lrarcade 
cls
if not exist %retroarch_dir%\. md %retroarch_dir%
if not exist %retroarch_dir%\cores\. md %retroarch_dir%\cores
if not exist %scripts_dir%\lr-arcade.cmd goto pkg_fail
call %scripts_dir%\lr-arcade.cmd
timeout /t 2 >nul
if "%go%"=="9" goto setup_menu
if "%fullinstall%"=="1" goto dl_lrconsole 
goto setup_menu

:dl_lrconsole
cls
if not exist %retroarch_dir%\. md %retroarch_dir%
if not exist %retroarch_dir%\cores\. md %retroarch_dir%\cores
if not exist %scripts_dir%\lr-console.cmd goto pkg_fail
call %scripts_dir%\lr-console.cmd
timeout /t 2 >nul
if "%go%"=="10" goto setup_menu
if "%fullinstall%"=="1" goto check_pkg
goto setup_menu

:update_sources
cls
set current_url=http://www.retrobat.ovh/repo/rbs/scripts/pkgsources.cmd
set output_dir=%scripts_dir%\pkgsources.cmd
if exist %scripts_dir%\pkgsources.cmd copy/y %scripts_dir%\pkgsources.cmd %scripts_dir%\pkgsources.cmd.old>nul
if exist %scripts_dir%\pkgsources.cmd break>%scripts_dir%\pkgsources.cmd
echo -- Updating softwares sources --
echo.
call %scripts_dir%\powershelldl.cmd
ping 127.0.0.1 -n 4 >nul
timeout /t 1 >nul
cls
echo.
echo -- Reloading softwares sources --
echo.
timeout /t 1 >nul
if not exist %scripts_dir%\pkgsources.cmd goto pkg_fail
goto welcome_menu

:update_lrlist_arcade
cls
set current_url=http://www.retrobat.ovh/repo/rbs/scripts/lr-arcade.cmd
set output_dir=%scripts_dir%\lr-arcade.cmd
if exist %scripts_dir%\lr-arcade.cmd copy/y %scripts_dir%\lr-arcade.cmd %scripts_dir%\lr-arcade.cmd.old>nul
if exist %scripts_dir%\lr-arcade.cmd break>%scripts_dir%\lr-arcade.cmd
echo -- Updating Libretro Cores List (Arcade) --
echo.
call %scripts_dir%\powershelldl.cmd
ping 127.0.0.1 -n 4 >nul
timeout /t 1 >nul
cls
echo -- Reloading Libretro Cores List (Arcade) --
echo.
timeout /t 1 >nul
if not exist %scripts_dir%\lr-arcade.cmd goto pkg_fail
goto debug_menu

:update_lrlist_console
cls
set current_url=http://www.retrobat.ovh/repo/rbs/scripts/lr-console.cmd
set output_dir=%scripts_dir%\lr-console.cmd
if exist %scripts_dir%\lr-console.cmd copy/y %scripts_dir%\lr-console.cmd %scripts_dir%\lr-console.cmd.old>nul
if exist %scripts_dir%\lr-console.cmd break>%scripts_dir%\lr-console.cmd
echo -- Updating Libretro Cores List (Console) --
echo.
call %scripts_dir%\powershelldl.cmd
ping 127.0.0.1 -n 4 >nul
timeout /t 1 >nul
cls
echo -- Reloading Libretro Cores List (Console) --
echo.
timeout /t 1 >nul
if not exist %scripts_dir%\lr-console.cmd goto pkg_fail
goto debug_menu

:update_es_systems
cls
set current_url=http://www.retrobat.ovh/repo/rbs/es/es_systems.cfg
set output_dir=%templates_dir%\emulationstation\es_systems.cfg
if exist %templates_dir%\emulationstation\es_systems.cfg copy/y %templates_dir%\emulationstation\es_systems.cfg %es_config_dir%\es_systems.cfg>nul
echo -- Updating ES systems list --
echo.
call %scripts_dir%\powershelldl.cmd
ping 127.0.0.1 -n 4 >nul
if not exist %es_config_dir%\es_systems.cfg goto pkg_fail
echo Done.
timeout /t 1 >nul
if exist %setup_dir%\system\retrobat.update goto update_complete
goto debug_menu

:restore_es_systems
cls
if not exist %es_config_dir%\es_systems.cfg.old echo.
if not exist %es_config_dir%\es_systems.cfg.old echo There is no backup of ES systems list available. Aborting...
if not exist %es_config_dir%\es_systems.cfg.old timeout /t 3 >nul
if not exist %es_config_dir%\es_systems.cfg.old goto debug_menu
echo.
echo -- Restore previous ES systems list --
echo.
copy/Y %es_config_dir%\es_systems.cfg %es_config_dir%\es_systems.cfg.bak>nul
copy/Y %es_config_dir%\es_systems.cfg.old %es_config_dir%\es_systems.cfg>nul
copy/Y %es_config_dir%\es_systems.cfg.bak %es_config_dir%\es_systems.cfg.old>nul
if exist %es_config_dir%\*.bak del/Q %es_config_dir%\*.bak
echo Done.
timeout /t 1 >nul
goto debug_menu

:run_es
cls
if not exist %setup_dir%\retro.bat goto pkg_fail
call %setup_dir%\retro.bat
goto exit

:update_retrobat_menu
cls
set current_url=http://www.retrobat.ovh/releases/retrobat.latest
set output_dir=%setup_dir%\system\retrobat.latest
echo -- Checking for available RetroBat Scripts update --
echo.
call %scripts_dir%\powershelldl.cmd
ping 127.0.0.1 -n 4 >nul
set/p rbonlinever=<%setup_dir%\system\retrobat.latest
set rbonlinever=%rbonlinever%
del/q %output_dir%
timeout /t 1 >nul
cls
echo +===========================================================+
echo                        UPDATE RETROBAT
echo +===========================================================+
echo  -local version: %version%
echo  -online version: %rbonlinever%
echo +===========================================================+
echo  ( U ) -- Update RetroBat
echo +-----------------------------------------------------------+
echo  ( R ) -- Return to previous menu
echo +-----------------------------------------------------------+
echo  ( Q ) -- Quit
echo +===========================================================+
set/p go="  - Please choose one (U,R,Q): "
if "%go%"=="R" goto welcome_menu
if "%go%"=="r" goto welcome_menu
if "%go%"=="Q" goto exit 
if "%go%"=="q" goto exit

:dl_rbs_updater
cls
set current_url=http://www.retrobat.ovh/repo/rbs/scripts/rbsupdater.cmd
set output_dir=%scripts_dir%\rbsupdater.cmd
if exist %scripts_dir%\rbsupdater.cmd copy/y %scripts_dir%\rbsupdater.cmd %scripts_dir%\rbsupdater.cmd.old>nul
if exist %scripts_dir%\rbsupdater.cmd break>%scripts_dir%\rbsupdater.cmd
echo -- Fetching RetroBat Updater --
echo.
call %scripts_dir%\powershelldl.cmd
ping 127.0.0.1 -n 4 >nul
timeout /t 1 >nul
if not exist %scripts_dir%\rbsupdater.cmd goto pkg_fail
call %scripts_dir%\rbsupdater.cmd
if exist %setup_dir%\system\retrobat.update (
	goto create_config
) else (
		goto pkg_fail
)

:welcome_menu_old
cls
if not exist %temp_dir%\. md %temp_dir%
if "%current_dir%"=="1" goto update_retroarch_config1
set fullinstall=0
set go=
call %scripts_dir%\pkgsources.cmd
call %scripts_dir%\showlogo.cmd
echo           Version %version% by Kayl
echo +===========================================================+
echo  ( 1 ) -- Launch EmulationStation
echo +-----------------------------------------------------------+
echo  ( 2 ) -- Setup softwares
echo +-----------------------------------------------------------+
echo  ( 3 ) -- Debug options
echo +-----------------------------------------------------------+
echo  ( 4 ) -- Update sources
echo +-----------------------------------------------------------+
echo  ( 5 ) -- Update RetroBat
echo +-----------------------------------------------------------+
echo  ( Q ) -- Quit
echo +===========================================================+
set/p go="  - Please choose one (1-5, Q): "
echo.
if "%go%"=="1" goto run_es
if "%go%"=="2" goto setup_menu
if "%go%"=="3" goto debug_menu
if "%go%"=="4" goto update_sources
if "%go%"=="5" goto update_retrobat_menu
if "%go%"=="Q" goto exit
if "%go%"=="q" goto exit
goto welcome_menu

:welcome_menu
cls
if not exist %temp_dir%\. md %temp_dir%
if "%current_dir%"=="1" goto update_retroarch_config1
set fullinstall=0
set go=
call %scripts_dir%\pkgsources.cmd
call %scripts_dir%\showlogo.cmd
echo           Version %version% by Kayl
echo +===========================================================+
echo  ( 1 ) -- Launch EmulationStation
echo +-----------------------------------------------------------+
echo  ( 2 ) -- Setup EmulationStation
echo +-----------------------------------------------------------+
echo  ( 3 ) -- Setup RetroArch
echo +-----------------------------------------------------------+
echo  ( 4 ) -- Debug options
echo +-----------------------------------------------------------+
echo  ( 5 ) -- Update sources
echo +-----------------------------------------------------------+
echo  ( 6 ) -- Update RetroBat
echo +-----------------------------------------------------------+
echo  ( Q ) -- Quit
echo +===========================================================+
set/p go="  - Please choose one (1-5, Q): "
echo.
if "%go%"=="1" goto run_es
if "%go%"=="2" goto setup_menu
if "%go%"=="4" goto debug_menu
if "%go%"=="5" goto update_sources
if "%go%"=="6" goto update_retrobat_menu
if "%go%"=="Q" goto exit
if "%go%"=="q" goto exit
goto welcome_menu

:setup_menu
cls
if not exist %temp_dir%\. md %temp_dir%
set singledl=0
set fullinstall=0
set go=0
echo +===========================================================+
echo                       SETUP SOFTWARES
echo +===========================================================+
echo  ( 1 ) -- Restart Setup
echo +-----------------------------------------------------------+
echo  ( 2 ) -- Install EmulationStation
echo +-----------------------------------------------------------+
echo  ( 3 ) -- Update EmulationStation
echo +-----------------------------------------------------------+
echo  ( 4 ) -- Install EmulationStation Themes
echo +-----------------------------------------------------------+
echo  ( 5 ) -- Install RetroArch Stable
echo +-----------------------------------------------------------+
echo  ( 6 ) -- Update RetroArch Stable
echo +-----------------------------------------------------------+
echo  ( 7 ) -- Install RetroArch Nightly
echo +-----------------------------------------------------------+
echo  ( 8 ) -- Update RetroArch Nightly
echo +-----------------------------------------------------------+
echo  ( 9 ) -- Install Libretro Cores (Arcade)
echo +-----------------------------------------------------------+
echo  ( 10 ) -- Install Libretro Cores (Consoles and others)
echo +-----------------------------------------------------------+
echo  ( R ) -- Return to previous menu
echo +-----------------------------------------------------------+
echo  ( Q ) -- Quit
echo +===========================================================+
set/p go="  - Please choose one (1-10,R,Q): "
echo.
if "%go%"=="1" goto create_config
if "%go%"=="2" set/A singledl=singledl+1 && goto dl_ES
if "%go%"=="3" goto update_ES
if "%go%"=="4" goto themes_menu
if "%go%"=="5" set/A singledl=singledl+1 && goto dl_retroarch_stable
if "%go%"=="6" goto update_retroarch_stable
if "%go%"=="7" set/A singledl=singledl+1 && goto dl_retroarch_nightly
if "%go%"=="8" goto update_retroarch_nightly
if "%go%"=="9" set/A fullinstall=fullinstall+1 && goto dl_lrarcade
if "%go%"=="10" set/A fullinstall=fullinstall+1 && goto dl_lrconsole
if "%go%"=="R" goto welcome_menu
if "%go%"=="r" goto welcome_menu
if "%go%"=="Q" goto exit
if "%go%"=="q" goto exit
goto setup_menu

:themes_menu
cls
if not exist %temp_dir%\. md %temp_dir%
set singledl=0
set fullinstall=0
set themename=carbon
set go=0
echo +===========================================================+
echo                  SETUP EMULATIONSTATION THEMES
echo +===========================================================+
echo  ( 1 ) -- Install Carbon Theme
echo +-----------------------------------------------------------+
echo  ( 2 ) -- Install NextFull Theme
echo +-----------------------------------------------------------+
echo  ( 3 ) -- Install Retro Arts Theme
echo +-----------------------------------------------------------+
echo  ( R ) -- Return to previous menu
echo +-----------------------------------------------------------+
echo  ( Q ) -- Quit
echo +===========================================================+
set/p go="  - Please choose one (1-3,R,Q): "
echo.
if "%go%"=="1" set themename=carbon
if "%go%"=="1" set/A singledl=singledl+1 && goto dl_default_theme
if "%go%"=="2" set themename=nextfull
if "%go%"=="2" set/A singledl=singledl+1 && goto dl_default_theme
if "%go%"=="3" goto themes_retroarts_menu
if "%go%"=="R" goto setup_menu
if "%go%"=="r" goto setup_menu
if "%go%"=="Q" goto exit
if "%go%"=="q" goto exit

:themes_retroarts_menu
cls
if not exist %temp_dir%\. md %temp_dir%
set singledl=0
set fullinstall=0
set themename=carbon
set go=0
echo +===========================================================+
echo                     SETUP RETRO ARTS THEME
echo +===========================================================+
echo  ( 1 ) -- Install in 2160P (4K)
echo +-----------------------------------------------------------+
echo  ( 2 ) -- Install in 1440P (WQHD)
echo +-----------------------------------------------------------+
echo  ( 3 ) -- Install in 1080P (FULL HD)
echo +-----------------------------------------------------------+
echo  ( 4 ) -- Install in 720P  (HD READY)
echo +-----------------------------------------------------------+
echo  ( R ) -- Return to previous menu
echo +-----------------------------------------------------------+
echo  ( Q ) -- Quit
echo +===========================================================+
set/p go="  - Please choose one (1-3,R,Q): "
echo.
if "%go%"=="1" set themename=retroarts_2160p
if "%go%"=="1" set/A singledl=singledl+1 && set current_url=https://github.com/lehcimcramtrebor/retroarts/archive/master.zip && goto dl_extra_theme
if "%go%"=="2" set themename=retroarts_1440p
if "%go%"=="2" set/A singledl=singledl+1 && set current_url=https://github.com/lehcimcramtrebor/retroarts1440p/archive/master.zip && goto dl_extra_theme
if "%go%"=="3" set themename=retroarts_1080p
if "%go%"=="3" set/A singledl=singledl+1 && set current_url=https://github.com/lehcimcramtrebor/retroarts1080p/archive/master.zip && goto dl_extra_theme
if "%go%"=="4" set themename=retroarts_720p
if "%go%"=="4" set/A singledl=singledl+1 && set current_url=https://github.com/lehcimcramtrebor/retroarts720p/archive/master.zip && goto dl_extra_theme
if "%go%"=="R" goto themes_menu
if "%go%"=="r" goto themes_menu
if "%go%"=="Q" goto exit
if "%go%"=="q" goto exit

:debug_menu
cls
if not exist %temp_dir%\. md %temp_dir%
set go=0
set fullinstall=0
echo +===========================================================+
echo                       DEBUG OPTIONS
echo +===========================================================+
echo  ( 1 ) -- Update EmulationStation systems list
echo +-----------------------------------------------------------+
echo  ( 2 ) -- Restore EmulationStation systems list
echo +-----------------------------------------------------------+
echo  ( 3 ) -- Reset EmulationStation settings
echo +-----------------------------------------------------------+
echo  ( 4 ) -- Update Libretro Cores list (Arcade)
echo +-----------------------------------------------------------+
echo  ( 5 ) -- Update Libretro Cores list (Console and others)
echo +-----------------------------------------------------------+
echo  ( 6 ) -- Set right path in RetroArch override settings
echo +-----------------------------------------------------------+
echo  ( 7 ) -- Create folders for emulators and roms
echo +-----------------------------------------------------------+
echo  ( 8 ) -- Restart Setup
echo +-----------------------------------------------------------+
echo  ( R ) -- Return to previous menu
echo +-----------------------------------------------------------+
echo  ( Q ) -- Quit
echo +===========================================================+
set/p go="  - Please choose one (1-7,R,Q): "
echo.
if "%go%"=="1" goto update_es_systems
if "%go%"=="2" goto restore_es_systems
if "%go%"=="3" goto config_es
if "%go%"=="4" goto update_lrlist_arcade
if "%go%"=="5" goto update_lrlist_console
if "%go%"=="6" goto update_retroarch_config2
if "%go%"=="7" goto create_folders
if "%go%"=="8" goto create_config
if "%go%"=="R" goto welcome_menu
if "%go%"=="r" goto welcome_menu
if "%go%"=="Q" goto exit
if "%go%"=="q" goto exit
goto debug_menu

:update_complete
if exist %setup_dir%\system\retrobat.update del/Q %setup_dir%\system\retrobat.update
cls
echo +===========================================================+
echo                   RETROBAT UPDATE IS DONE !
echo +===========================================================+
timeout /t 3 >nul
goto welcome_menu

:admin_fail
cls
Echo.
ECHO  Please run this script not as administrator.
Echo.
timeout /t 4 >nul
goto exit

:proc_fail
cls
Echo.
ECHO  RetroBat Scripts only run on 64 bits system.
Echo.
timeout /t 4 >nul
goto exit

:pkg_fail
cls
Echo.
Echo  An error occured and file cannot be found.
Echo.
timeout /t 4 >nul
goto exit 

:exit
exit