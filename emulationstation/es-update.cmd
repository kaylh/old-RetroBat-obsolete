@echo off
setlocal EnableDelayedExpansion
cls
echo updating retrobat ^>^>^> 0%%

REM WINDOW TITLE
title retrobat updater

:set_variables

REM PATH
set current_file=%~nx0
set current_drive="%cd:~0,2%"
set current_dir="%cd:~3%"
set current_drive=%current_drive:"=%
set current_dir=%current_dir:"=%
rem set "current_dir=%current_dir%"
set current_path=!current_drive!\!current_dir!
set update_dir=!current_path!
set modules_dir=!current_path!\..\system\modules
set download_dir=!current_path!\..\system\download
set extraction_dir=!current_path!\..\system\download\extract
set retrobat_main_dir=!current_path!\..
set emulationstation_dir=!current_path!
set emulatorlauncher_dir=!emulationstation_dir!
set default_theme_dir=!emulationstation_dir!\.emulationstation\themes
set emulator_dir=!retrobat_main_dir!\emulators
set decorations_dir=!retrobat_main_dir!\system\decorations

REM END PATH

rem set branch=stable

set remote_version_file=remote_version.info
set local_version_file=version.info
set remote_version_filepath=!modules_dir!\rb_updater
set local_version_filepath=!emulationstation_dir!

cd "!remote_version_filepath!"
set/p rb_remote_version=<!remote_version_file!
cd "!current_path!"

cd "!local_version_filepath!"
set/p rb_local_version=<!local_version_file!
cd "!current_path!"

set retrobat_version=!rb_local_version!

REM SWITCHS
set enable_download=1
set enable_extraction=1

REM UPDATE
REM GLOBAL
set update_retrobat_main=1
set update_theme_carbon=0
set update_retrobat_decorations=0
set update_gamespack=0
set update_emulationstation=1
set update_es_settings=1
set update_es_systems=1
set update_es_features=1
set update_es_padtokey=1
set update_emulatorlauncher=0

REM EMULATORS
set update_applewin=0
set update_arcadeflashweb=0
set update_cemu=0
set update_citra=0
set update_cxbx-reloaded=0
set update_daphne=0
set update_demul=0
set update_demul-old=0
set update_dolphin-emu=0
set update_dolphin-triforce=0
set update_dosbox=0
rem set update_dosbox_x=0
set update_duckstation=0
set update_fpinball=0
set update_gsplus=0
set update_kega-fusion=0
set update_love=0
set update_m2emulator=0
set update_mame=0
set update_mednafen=0
set update_mesen=0
set update_mgba=0
set update_openbor=0
set update_oricutron=0
set update_pcsx2=0
set update_pico8=0
set update_ppsspp=0
set update_project64=0
set update_raine=0
set update_redream=0
set update_retroarch=0
set update_rpcs3=0
set update_ryujinx=0
set update_simcoupe=0
set update_snes9x=0
set update_solarus=0
set update_supermodel=0
set update_teknoparrot=0
set update_tsugaru=0
set update_vpinball=0
set update_winuae=0
set update_xemu=0
set update_xenia-canary=0
set update_yuzu=0
set update_libretro_cores=0
REM END SWITCHS

REM LISTLOOP
::applewin
::arcadeflashweb
::cemu
::citra
::cxbx-reloaded
::daphne
::demul
::demul-old
::dolphin-emu
::dolphin-triforce
::dosbox
::duckstation
::fpinball
::gsplus
::kega-fusion
::love
::m2emulator
::mame
::mednafen
::mesen
::mgba
::openbor
::oricutron
::pcsx2
::pico8
::ppsspp
::project64
::raine
::redream
::rpcs3
::ryujinx
::simcoupe
::snes9x
::solarus
::supermodel
::teknoparrot
::tsugaru
::vpinball
::winuae
::xemu
::xenia-canary
::yuzu
REM END LISTLOOP

:loop_cmdarray
if not "%1"=="" (
    if "%1"=="-branch" (
        set branch=%2
        shift
    )
	if "%1"=="-extract" (
        set extract_pkg=%2
        shift
    )
	shift	
    goto :loop_cmdarray
)

if "%extract_pkg%"=="es" (
	call :extract_es
	goto :eof
)

if "%1"=="" set branch=stable

:check_deps

if not exist "!modules_dir!\rb_updater\7za.exe" (
	call :error
	goto :eof
)
if not exist "!modules_dir!\rb_updater\wget.exe" (
	call :error
	goto :eof
)

:install_packages

set progress_current=0
set progress_total=4
set progress_percent=0

set download_retry=3

REM CLEAN DOWNLOAD DIR
if exist "!download_dir!\*.7z" del/Q "!download_dir!\*.7z" >nul
if exist "!download_dir!\*.zip" del/Q "!download_dir!\*.zip" >nul

if not exist "!download_dir!\." md "!download_dir!" >nul

REM EMULATIONSTATION UPDATE
set package_file=emulationstation.zip
if "!update_emulationstation!"=="1" (
	REM DOWNLOAD
	set /A progress_current+=!update_emulationstation!
	if "!enable_download!"=="1" "!modules_dir!\rb_updater\wget" --no-check-certificate wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t !download_retry! -P "!download_dir!" https://www.retrobat.ovh/repo/win64/!branch!/!package_file! -q >nul	
	if not exist "!download_dir!\!package_file!" (
		call :error
		goto :eof
	)
	cls
	set /a progress_percent=100*!progress_current!/progress_total
	echo updating retrobat ^>^>^> !progress_percent!%%	
	timeout /t 1 >nul
	
	REM EXTRACT
rem	set /A progress_current+=!update_emulationstation!
rem	if "!enable_extraction!"=="1" if not exist "%extraction_dir%\." md "%extraction_dir%" >nul
rem	if "!enable_extraction!"=="1" if not exist "%extraction_dir%\emulationstation\." md "%extraction_dir%\emulationstation" >nul
rem	if "!enable_extraction!"=="1" "%modules_dir%\rb_updater\7za.exe" -y x "%download_dir%\%package_name%" -aoa -o"%extraction_dir%\emulationstation" >nul	
rem	cls
rem	set /a progress_percent=100*!progress_current!/progress_total
rem	echo updating retrobat ^>^>^> !progress_percent!%%	
rem	timeout /t 1 >nul
	
rem	del/Q "%download_dir%\%package_file%" >nul
)

REM EMULATORLAUNCHER UPDATE
set package_file=emulatorlauncher.zip
if "!update_emulatorlauncher!"=="1" (
	REM DOWNLOAD
	set /A progress_current+=!update_emulatorlauncher!
	if "!enable_download!"=="1" "!modules_dir!\rb_updater\wget" --no-check-certificate wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t !download_retry! -P "!download_dir!" https://www.retrobat.ovh/repo/win64/!branch!/!package_file! -q >nul	
	if not exist "!download_dir!\!package_file!" (
		call :error
		goto :eof
	)
	cls
	set /a progress_percent=100*!progress_current!/progress_total
	echo updating retrobat ^>^>^> !progress_percent!%%	
	timeout /t 1 >nul
	
	REM EXTRACT
	set /A progress_current+=!update_emulatorlauncher!
	if "!enable_extraction!"=="1" if not exist "!extraction_dir!\." md "!extraction_dir!" >nul
	if "!enable_extraction!"=="1" if not exist "!extraction_dir!\emulationstation\." md "!extraction_dir!\emulationstation" >nul
	if "!enable_extraction!"=="1" "!modules_dir!\rb_updater\7za.exe" -y x "!download_dir!\!package_file!" -aoa -o"!emulationstation_dir!" >nul	
	cls
	set /a progress_percent=100*!progress_current!/progress_total
	echo updating retrobat ^>^>^> !progress_percent!%%
	timeout /t 1 >nul
	
	del/Q "!download_dir!\!package_file!" >nul
)

REM CARBON THEME UPDATE
set package_file=theme_carbon.zip
if "!update_theme_carbon!"=="1" (
	REM DOWNLOAD
	set /A progress_current+=!update_theme_carbon!
	if "!enable_download!"=="1" "!modules_dir!\rb_updater\wget" --no-check-certificate wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t !download_retry! -P "!download_dir!" https://www.retrobat.ovh/repo/win64/!branch!/!package_file! -q >nul
	if not exist "!download_dir!\!package_file!" (
		call :error
		goto :eof
	)
	cls
	set /a progress_percent=100*!progress_current!/progress_total
	echo updating retrobat ^>^>^> !progress_percent!%%
	timeout /t 1 >nul
	
	REM EXTRACT
	set /A progress_current+=!update_theme_carbon!
	if "!enable_extraction!"=="1" if not exist "!default_theme_dir!\." md "!default_theme_dir!" >nul
	if "!enable_extraction!"=="1" if exist "!default_theme_dir!\es-theme-carbon_old\." rmdir /s /q "!default_theme_dir!\es-theme-carbon_old\" >nul
	if "!enable_extraction!"=="1" if exist "!default_theme_dir!\es-theme-carbon\." move "!default_theme_dir!\es-theme-carbon" "!default_theme_dir!\es-theme-carbon_old"	 >nul
	if "!enable_extraction!"=="1" "!modules_dir!\rb_updater\7za.exe" -y x "!download_dir!\!package_file!" -aoa -o"!default_theme_dir!" >nul
	if "!enable_extraction!"=="1" if exist "!default_theme_dir!\es-theme-carbon-master\." move "!default_theme_dir!\es-theme-carbon-master" "!default_theme_dir!\es-theme-carbon" >nul	
	cls
	set /a progress_percent=100*!progress_current!/progress_total
	echo updating retrobat ^>^>^> !progress_percent!%%
	timeout /t 1 >nul	
	
	del/Q "!download_dir!\!package_file!" >nul
)

REM DECORATIONS UPDATE
set package_file=decorations.7z
if "!update_retrobat_decorations!"=="1" (
	REM DOWNLOAD
	set /A progress_current+=!update_retrobat_decorations!
	if "!enable_download!"=="1" "!modules_dir!\rb_updater\wget" --no-check-certificate wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t !download_retry! -P "!download_dir!" https://www.retrobat.ovh/repo/win64/!branch!/!package_file! -q >nul
	if not exist "!download_dir!\!package_file!" (
		call :error
		goto :eof
	)
	cls
	set /a progress_percent=100*!progress_current!/progress_total
	echo updating retrobat ^>^>^> !progress_percent!%%
	timeout /t 1 >nul
	REM EXTRACT
	set /A progress_current+=!update_retrobat_decorations!
	if "!enable_extraction!"=="1" if not exist "!decorations_dir!\." md "!decorations_dir!" >nul
	if "!enable_extraction!"=="1" "!modules_dir!\rb_updater\7za.exe" -y x "!download_dir!\!package_file!" -aoa -o"!decorations_dir!" >nul	
	cls
	set /a progress_percent=100*!progress_current!/progress_total
	echo updating retrobat ^>^>^> !progress_percent!%%
	timeout /t 1 >nul
	
	del/Q "!download_dir!\!package_file!" >nul
)

REM RETROARCH UPDATE
set package_file=retroarch.7z
if "!update_retroarch!"=="1" if not exist "!emulator_dir!\retroarch\manual_update.txt" (
	REM DOWNLOAD
	set /A progress_current+=!update_retroarch!
	if "!enable_download!"=="1" "!modules_dir!\rb_updater\wget" --no-check-certificate wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t !download_retry! -P "!download_dir!" https://www.retrobat.ovh/repo/win64/!branch!/emulators/!package_file! -q >nul
	if not exist "!download_dir!\!package_file!" (
		call :error
		goto :eof
	)
	cls
	set /a progress_percent=100*!progress_current!/progress_total
	echo updating retrobat ^>^>^> !progress_percent!%%	
	timeout /t 1 >nul
	REM EXTRACT
	set /A progress_current+=!update_retroarch!
	if "!enable_extraction!"=="1" if not exist "!emulator_dir!\retroarch\." md "!emulator_dir!\retroarch" >nul
	if "!enable_extraction!"=="1" "!modules_dir!\rb_updater\7za.exe" -y x "!download_dir!\!package_file!" -aoa -o"!emulator_dir!\retroarch" >nul	
	cls
	set /a progress_percent=100*!progress_current!/progress_total
	echo updating retrobat ^>^>^> !progress_percent!%%	
	timeout /t 1 >nul
	
	del/Q "!download_dir!\!package_file!"	
)
REM LIBRETRO CORES UPDATE
set package_file=libretro_cores.7z
if "!update_libretro_cores!"=="1" if not exist "!emulator_dir!\retroarch\manual_update.txt" (
	REM DOWNLOAD
	set /A progress_current+=!update_libretro_cores!
	if "!enable_download!"=="1" "!modules_dir!\rb_updater\wget" --no-check-certificate wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t !download_retry! -P "!download_dir!" https://www.retrobat.ovh/repo/win64/!branch!/emulators/!package_file! -q >nul
	if not exist "!download_dir!\!package_file!" (
		call :error
		goto :eof
	)
	cls
	set /a progress_percent=100*!progress_current!/progress_total
	echo updating retrobat ^>^>^> !progress_percent!%%	
	timeout /t 1 >nul
	
	REM EXTRACT
	set /A progress_current+=!update_libretro_cores!
	if "!enable_extraction!"=="1" if not exist "!emulator_dir!\retroarch\cores\." md "!emulator_dir!\retroarch\cores" >nul
	if "!enable_extraction!"=="1" "!modules_dir!\rb_updater\7za.exe" -y x "!download_dir!\!package_file!" -aoa -o"!emulator_dir!\retroarch\cores" >nul	
	cls
	set /a progress_percent=100*!progress_current!/progress_total
	echo updating retrobat ^>^>^> !progress_percent!%%	
	timeout /t 1 >nul
	
	del/Q "!download_dir!\!package_file!"
)

REM EMULATORS UPDATE
for /f "delims=:: tokens=*" %%a in ('findstr /b :: "%~f0"') do (
	set package_file=%%a.7z
	if "!update_%%a!"=="1" if not exist "!emulator_dir!\%%a\manual_update.txt" (
	REM DOWNLOAD
	set /A progress_current+=!update_%%a!
	if "!enable_download!"=="1" "!modules_dir!\rb_updater\wget" --no-check-certificate wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t !download_retry! -P "!download_dir!" https://www.retrobat.ovh/repo/win64/!branch!/emulators/!package_file! -q >nul	
	if not exist "!download_dir!\!package_file!" (
		call :error
		goto :eof
	)
	cls
	set /a progress_percent=100*!progress_current!/progress_total
	echo updating retrobat ^>^>^> !progress_percent!%%	
	timeout /t 1 >nul
	
	REM EXTRACT
	set /A progress_current+=!update_%%a!
	if "!enable_extraction!"=="1" if not exist "!emulator_dir!\%%a\." md "!emulator_dir!\%%a" >nul
	if "!enable_extraction!"=="1" "!modules_dir!\rb_updater\7za.exe" -y x "!download_dir!\!package_file!" -aoa -o"!emulator_dir!\%%a" >nul	
	cls
	set /a progress_percent=100*!progress_current!/progress_total
	echo updating retrobat ^>^>^> !progress_percent!%%	
	timeout /t 1 >nul
	
	del/Q "!download_dir!\!package_file!" >nul	
	)
)

REM RETROBAT UPDATE
set package_file=retrobat_main.7z
if "!update_retrobat_main!"=="1" (
	REM DOWNLOAD
	set /A progress_current+=1
	if "!enable_download!"=="1" "!modules_dir!\rb_updater\wget" --no-check-certificate wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t !download_retry! -P "!download_dir!" https://www.retrobat.ovh/repo/win64/!branch!/!package_file! -q >nul	
	if not exist "!download_dir!\!package_file!" (
		call :error
		goto :eof
	)
	cls
	set /a progress_percent=100*!progress_current!/progress_total
	echo updating retrobat ^>^>^> !progress_percent!%%	
	timeout /t 1 >nul
	
	REM EXTRACT
	set /A progress_current+=1
	if "!enable_extraction!"=="1" "!modules_dir!\rb_updater\7za.exe" -y x "!download_dir!\!package_file!" -aoa -o"!retrobat_main_dir!" >nul
	cls
	set /a progress_percent=100*!progress_current!/progress_total
	echo updating retrobat ^>^>^> !progress_percent!%%	
	timeout /t 1 >nul
	
	del/Q "!download_dir!\!package_file!" >nul
	
	REM MOVE VIDEOS
	if exist "!current_path!\..\system\templates\emulationstation\retrobat-neon.mp4" move/Y "!current_path!\..\system\templates\emulationstation\retrobat-neon.mp4" "!current_path!\.emulationstation\video" >nul
	if exist "!current_path!\..\system\templates\emulationstation\retrobat-neogeo.mp4" move/Y "!current_path!\..\system\templates\emulationstation\retrobat-neogeo.mp4" "!current_path!\.emulationstation\video" >nul
	if exist "!current_path!\..\system\templates\emulationstation\retrobat-ps2.mp4" move/Y "!current_path!\..\system\templates\emulationstation\retrobat-ps2.mp4" "!current_path!\.emulationstation\video" >nul

	REM COPY ES CONFIG
	if "!update_es_settings!"=="1" if exist "!emulationstation_dir!\.emulationstation\es_settings.cfg.old" del/Q "!emulationstation_dir!\.emulationstation\es_settings.cfg.old" >nul
	if "!update_es_systems!"=="1" if exist "!emulationstation_dir!\.emulationstation\es_system.cfg.old" del/Q "!emulationstation_dir!\.emulationstation\es_system.cfg.old" >nul
	if "!update_es_features!"=="1" if exist "!emulationstation_dir!\.emulationstation\es_features.cfg.old" del/Q "!emulationstation_dir!\.emulationstation\es_features.cfg.old" >nul
	if "!update_es_padtokey!"=="1" if exist "!emulationstation_dir!\.emulationstation\es_padtokey.cfg.old" del/Q "!emulationstation_dir!\.emulationstation\es_padtokey.cfg.old" >nul
	
	if "!update_es_settings!"=="1" if exist "!emulationstation_dir!\.emulationstation\es_settings.cfg" (
		copy/y "!emulationstation_dir!\.emulationstation\es_settings.cfg" "!emulationstation_dir!\.emulationstation\es_settings.cfg.old" >nul
		copy/y "!emulationstation_dir!\..\system\templates\emulationstation\es_settings.cfg" "!emulationstation_dir!\.emulationstation\es_settings.cfg" >nul
	)
	
	if "!update_es_systems!"=="1" if exist "!emulationstation_dir!\.emulationstation\es_system.cfg" (
		copy/y "!emulationstation_dir!\.emulationstation\es_system.cfg" "!emulationstation_dir!\.emulationstation\es_system.cfg.old" >nul
		copy/y "!emulationstation_dir!\..\system\templates\emulationstation\es_system.cfg" "!emulationstation_dir!\.emulationstation\es_system.cfg" >nul
	)
	
	if "!update_es_features!"=="1" if exist "!emulationstation_dir!\.emulationstation\es_features.cfg" (
		copy/y "!emulationstation_dir!\.emulationstation\es_features.cfg" "!emulationstation_dir!\.emulationstation\es_features.cfg.old" >nul
		copy/y "!emulationstation_dir!\..\system\templates\emulationstation\es_features.cfg" "!emulationstation_dir!\.emulationstation\es_features.cfg" >nul
	)
	
	if "!update_es_padtokey!"=="1" if exist "!emulationstation_dir!\.emulationstation\es_padtokey.cfg" (
		copy/y "!emulationstation_dir!\.emulationstation\es_padtokey.cfg" "!emulationstation_dir!\.emulationstation\es_padtokey.cfg.old" >nul
		copy/y "!emulationstation_dir!\..\system\templates\emulationstation\es_padtokey.cfg" "!emulationstation_dir!\.emulationstation\es_padtokey.cfg" >nul
	)
	
	REM COPY EMULATORS CONFIG
	
	REM SET VERSION
	
	if exist "!current_path!\version.info" del/Q "!current_path!\version.info" >nul
	if exist "!current_path!\about.info" del/Q "!current_path!\about.info" >nul
	
	echo !retrobat_version! >"!current_path!\version.info"
	echo RETROBAT v!retrobat_version! >"!current_path!\about.info"
)

REM V4BETA UPDATE
if exist "!current_path!\..\system\es_menu\retroarch_angle.menu" (
	copy/y "!current_path!\..\system\es_menu\retroarch_angle.menu" "!current_path!\..\system\es_menu\retroarch_angle.menu.old" >nul 
	del/Q "!current_path!\..\system\es_menu\retroarch_angle.menu" >nul
)

if exist "!current_path!\..\emulators\retroarch\retroarch_angle.exe" del/Q "!current_path!\..\emulators\retroarch\retroarch_angle.exe" >nul

if exist "!retrobat_main_dir!\retrobat.ini" del/Q "!retrobat_main_dir!\retrobat.ini" >nul

REM RECREATE RETROBAT TREE
for /f "usebackq delims=" %%x in ("%retrobat_main_dir%\system\configgen\retrobat_tree.list") do (
   if not exist "%retrobat_main_dir%\%%x\." md "%retrobat_main_dir%\%%x" >nul
)
for /f "usebackq delims=" %%x in ("%retrobat_main_dir%\system\configgen\systems_names.list") do (
   if not exist "%retrobat_main_dir%\roms\%%x\." md "%retrobat_main_dir%\roms\%%x" >nul
   if not exist "%retrobat_main_dir%\saves\%%x\." md "%retrobat_main_dir%\saves\%%x" >nul
)

cls
set /A progress_current+=1
set /a progress_percent=100*!progress_current!/progress_total
echo updating retrobat ^>^>^> !progress_percent!%%

timeout /t 1 >nul

if "!progress_percent!"=="100" (
	call :exit
	goto :eof
) else (
	call :error
	goto :eof
)

endlocal

:exit
echo update done !
timeout /t 1 >nul
exit/b 0

:error
cls
echo update failed !
timeout /t 1 >nul
exit/b 1

:extract_es
cls
set package_file=emulationstation.zip
"%CD%\system\modules\rb_updater\7za.exe" -y x "%CD%\system\download\%package_file%" -aoa -o"%CD%\emulationstation" >nul
del/Q "%CD%\system\download\%package_file%" >nul
timeout /t 3 >nul
exit
