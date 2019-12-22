@echo off
goto:rem
***************************************
This file is part of RetroBat Scripts. 
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
If %PROCARCH%==32 goto proc_fail
If %PROCARCH%==64 goto check_admin

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
if "%updatedone%"=="1" copy/Y %templates_dir%\configs\emulationstation.cfg %config_dir%\emulationstation.cfg>nul
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
set current_url=http://www.retrobat.ovh/repo/tools/7z64-pkg.zip
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
if "%updatedone%"=="1" set updatedone=0 && goto create_folders
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

if not exist %games_dir%\. md %games_dir%
if not exist %saves_dir%\. md %saves_dir%
if not exist %shots_dir%\. md %shots_dir%
if not exist %bios_dir%\. md %bios_dir%
if not exist %medias_dir%\. md %medias_dir%

if not exist %emulators_dir%\applewin\. md %emulators_dir%\applewin
if exist %templates_dir%\infos\info-emu.txt copy/y %templates_dir%\infos\info-emu.txt %emulators_dir%\applewin\info.txt>nul

if not exist %emulators_dir%\dolphin-emu\. md %emulators_dir%\dolphin-emu
if not exist %emulators_dir%\dolphin-emu\config\. md %emulators_dir%\dolphin-emu\config
if exist %templates_dir%\infos\info-emu.txt copy/y %templates_dir%\infos\info-emu.txt %emulators_dir%\dolphin-emu\info.txt>nul

if not exist %emulators_dir%\pcsx2\. md %emulators_dir%\pcsx2
if not exist %emulators_dir%\pcsx2\config\. md %emulators_dir%\pcsx2\config
if exist %templates_dir%\infos\info-emu.txt copy/y %templates_dir%\infos\info-emu.txt %emulators_dir%\pcsx2\info.txt>nul

if not exist %emulators_dir%\ppsspp\. md %emulators_dir%\ppsspp
if exist %templates_dir%\infos\info-emu.txt copy/y %templates_dir%\infos\info-emu.txt %emulators_dir%\ppsspp\info.txt>nul

if not exist %emulators_dir%\redream\. md %emulators_dir%\redream
if exist %templates_dir%\infos\info-emu.txt copy/y %templates_dir%\infos\info-emu.txt %emulators_dir%\redream\info.txt>nul

if not exist %emulators_dir%\dosbox\. md %emulators_dir%\dosbox
if exist %templates_dir%\infos\info-emu.txt copy/y %templates_dir%\infos\info-emu.txt %emulators_dir%\dosbox\info.txt>nul

if not exist %emulators_dir%\retroarch\. md %emulators_dir%\retroarch
if exist %templates_dir%\infos\info-emu.txt copy/y %templates_dir%\infos\info-emu.txt %emulators_dir%\retroarch\info.txt>nul

if not exist %emulators_dir%\openbor\. md %emulators_dir%\openbor
if exist %templates_dir%\infos\info-emu.txt copy/y %templates_dir%\infos\info-emu.txt %emulators_dir%\openbor\info.txt>nul
if not exist %emulators_dir%\openbor\openborlauncher.exe if exist %setup_dir%\system\tools\openborlauncher.exe copy/y %setup_dir%\system\tools\openborlauncher.exe %emulators_dir%\openbor\openborlauncher.exe>nul

if not exist %emulators_dir%\rpcs3\. md %emulators_dir%\rpcs3
if exist %templates_dir%\infos\info-emu.txt copy/y %templates_dir%\infos\info-emu.txt %emulators_dir%\rpcs3\info.txt>nul
if not exist %emulators_dir%\rpcs3\rpcs3launcher.exe if exist %setup_dir%\system\tools\rpcs3launcher.exe copy/y %setup_dir%\system\tools\rpcs3launcher.exe %emulators_dir%\rpcs3\rpcs3launcher.exe>nul

if not exist %setup_dir%\system\joytokey\. md %setup_dir%\system\joytokey
if exist %templates_dir%\infos\info-joytokey.txt copy/y %templates_dir%\infos\info-joytokey.txt %setup_dir%\system\joytokey\info.txt>nul

if exist %templates_dir%\infos\info-bios.txt copy/y %templates_dir%\infos\info-bios.txt %bios_dir%\bios.txt>nul
timeout /t 1 >nul
cd %games_dir%
call %scripts_dir%\systemsnames.cmd
If not exist %threedo%\. md %threedo%
if not exist %apple2%\. md %apple2%
If not exist %arcade%\. md %arcade%
If not exist %atari2600%\. md %atari2600%
If not exist %atari5200%\. md %atari5200%
If not exist %atarijaguar%\. md %atarijaguar%
If not exist %atarilynx%\. md %atarilynx%
If not exist %ataripro%\. md %ataripro%
If not exist %atarist%\. md %atarist%
If not exist %cave%\. md %cave%
If not exist %pce%\. md %pce%
If not exist %pcecd%\. md %pcecd%
If not exist %supergrafx%\. md %supergrafx%
If not exist %n64%\. md %n64%
If not exist %nds%\. md %nds%
If not exist %gb%\. md %gb%
If not exist %gb2p%\. md %gb2p%
If not exist %gbadv%\. md %gbadv%
If not exist %gbcolor%\. md %gbcolor%
If not exist %gbc2p%\. md %gbc2p%
If not exist %nes%\. md %nes%
If not exist %snes%\. md %snes%
If not exist %gamecube%\. md %gamecube%
If not exist %wii%\. md %wii%
If not exist %sega32x%\. md %sega32x%
If not exist %dreamcast%\. md %dreamcast%
If not exist %gamegear%\. md %gamegear%
If not exist %mastersystem%\. md %mastersystem%
If not exist %megacd%\. md %megacd%
If not exist %megadrive%\. md %megadrive%
If not exist %saturn%\. md %saturn%
If not exist %neogeo%\. md %neogeo%
If not exist %neogeocd%\. md %neogeocd%
If not exist %ngp%\. md %ngp%
If not exist %ngpc%\. md %ngpc%
If not exist %npg%\. md %npg%
If not exist %msu1%\. md %msu1%
If not exist %psx%\. md %psx%
If not exist %ps2%\. md %ps2%
If not exist %ps3%\. md %ps3%
If not exist %msu1%\. md %msu1%
If not exist %psp%\. md %psp%
If not exist %videopac%\. md %videopac%
If not exist %fba%\. md %fba%
If not exist %mame%\. md %mame%
If not exist %vb%\. md %vb%
If not exist %cps1%\. md %cps1%
If not exist %cps2%\. md %cps2%
If not exist %cps3%\. md %cps3%
If not exist %msdos%\. md %msdos%
If not exist %wswan%\. md %wswan%
If not exist %wswanc%\. md %wswanc%
If not exist %amiga%\. md %amiga%
If not exist %amstradcpc%\. md %amstradcpc%
If not exist %colecov%\. md %colecov%
If not exist %com64%\. md %com64%
If not exist %gamewatch%\. md %gamewatch%
If not exist %intellivision%\. md %intellivision%
If not exist %msx%\. md %msx%
If not exist %n3ds%\. md %n3ds%
If not exist %pcfx%\. md %pcfx%
If not exist %scummvm%\. md %scummvm%
If not exist %vectrex%\. md %vectrex%
If not exist %zxspectrum%\. md %zxspectrum%
If not exist %atomiswave%\. md %atomiswave%
If not exist %naomi%\. md %naomi%
If not exist %pcgames%\. md %pcgames%
If not exist %mugen%\. md %mugen%
cd ..
timeout /t 1 >nul
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
xcopy/Y /e /i "%templates_dir%\emulationstation\scripts" "%es_config_dir%\scripts" 2>&1
set bgmusic=0
if not exist %es_config_dir%\music\*.ogg set/A bgmusic=bgmusic+1
if not exist %es_config_dir%\music\*.mp3 set/A bgmusic=bgmusic+1
if "%bgmusic%"=="0" if exist %templates_dir%\emulationstation\music.ogg copy/Y %templates_dir%\emulationstation\music.ogg %es_config_dir%\music\music.ogg>nul
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
if "%fullinstall%"=="1" set themename=carbon
if "%fullinstall%"=="1" goto dl_default_theme
if "%go%"=="2" goto debug_menu
if "%go%"=="3" goto debug_menu
goto setup_menu

:dl_default_theme
cls
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
if "%singledl%"=="1" goto setup_menu
if "%fullinstall%"=="1" goto dl_retroarch_stable
goto setup_menu

:dl_retroarch_stable
cls
set current_url=%retroarch_stable_url%
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
set current_url=%retroarch_stable_update_url%
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
set current_url=%retroarch_nightly_url%
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
set current_url=%retroarch_nightly_update_url%
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
echo Done.
timeout /t 1 >nul
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
set /p racfg="- Please choose one (0-4): "
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
if exist %retroarch_config_dir%\retroarch.cfg (
	copy/y %retroarch_config_dir%\retroarch.cfg %retroarch_config_dir%\retroarch.cfg.old>nul
	del/q %retroarch_config_dir%\retroarch.cfg
	copy/y %templates_dir%\retroarch\retroarch-%racfgname%.cfg %retroarch_config_dir%\retroarch.cfg>nul
	timeout /t 1 >nul
	goto update_retroarch_config2
	) else (
	copy/y %templates_dir%\retroarch\retroarch-%racfgname%.cfg %retroarch_config_dir%\retroarch.cfg>nul
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
echo                    UPDATE RETROBAT SCRIPTS
echo +===========================================================+
echo  -local version: %version%
echo  -online version: %rbonlinever%
echo +===========================================================+
echo  ( U ) -- Update RetroBat Scripts
echo +-----------------------------------------------------------+
echo  ( R ) -- Return to previous menu
echo +-----------------------------------------------------------+
echo  ( Q ) -- Quit
echo +===========================================================+
set/p go="  - Please chose one (U,R,Q): "
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
if not exist %scripts_dir%\rbsupdater.cmd goto pkg_fail
timeout /t 1 >nul
cls
call %scripts_dir%\rbsupdater.cmd
if "%updatedone%"=="1" (
	goto create_config
) else (
		goto pkg_fail
)

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
echo  ( 2 ) -- Setup softwares
echo +-----------------------------------------------------------+
echo  ( 3 ) -- Debug options
echo +-----------------------------------------------------------+
echo  ( 4 ) -- Update sources
echo +-----------------------------------------------------------+
echo  ( 5 ) -- Update RetroBat Scripts
echo +-----------------------------------------------------------+
echo  ( Q ) -- Quit
echo +===========================================================+
set/p go="  - Please chose one (1-5, Q): "
echo.
if "%go%"=="1" goto run_es
if "%go%"=="2" goto setup_menu
if "%go%"=="3" goto debug_menu
if "%go%"=="4" goto update_sources
if "%go%"=="5" goto update_retrobat_menu
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
set/p go="  - Please chose one (1-5,R,Q): "
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
echo  ( R ) -- Return to previous menu
echo +-----------------------------------------------------------+
echo  ( Q ) -- Quit
echo +===========================================================+
set/p go="  - Please chose one (1-5,R,Q): "
echo.
if "%go%"=="1" set themename=carbon
if "%go%"=="1" set/A singledl=singledl+1 && goto dl_default_theme
if "%go%"=="2" set themename=nextfull
if "%go%"=="2" set/A singledl=singledl+1 && goto dl_default_theme
if "%go%"=="R" goto setup_menu
if "%go%"=="r" goto setup_menu
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
echo  ( R ) -- Return to previous menu
echo +-----------------------------------------------------------+
echo  ( Q ) -- Quit
echo +===========================================================+
set/p go="  - Please chose one (1-7,R,Q): "
echo.
if "%go%"=="1" goto update_es_systems
if "%go%"=="2" goto restore_es_systems
if "%go%"=="3" goto config_es
if "%go%"=="4" goto update_lrlist_arcade
if "%go%"=="5" goto update_lrlist_console
if "%go%"=="6" goto update_retroarch_config2
if "%go%"=="7" goto create_folders
if "%go%"=="R" goto welcome_menu
if "%go%"=="r" goto welcome_menu
if "%go%"=="Q" goto exit
if "%go%"=="q" goto exit
goto debug_menu

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