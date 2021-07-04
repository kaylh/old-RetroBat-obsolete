@echo off
setlocal EnableDelayedExpansion
cls
echo Preparing updater... ^>^>^> 0%%

REM WINDOW TITLE
title retrobat updater

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
set retrobat_main_dir=!current_path!\..
set emulationstation_dir=!current_path!
set emulatorlauncher_dir=!emulationstation_dir!
set default_theme_dir=!emulationstation_dir!\.emulationstation\themes
set emulator_dir=!retrobat_main_dir!\emulators
set decorations_dir=!retrobat_main_dir!\system\decorations
REM END PATH

REM SET VERSION
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
set retrobat_version=!rb_remote_version!

REM SWITCHS
set enable_download=1
set enable_extraction=1

REM UPDATE
REM GLOBAL
set update_retrobat_main=1
set update_retrobat_ini=1
set update_retrobat_gui=1
set update_theme_carbon=1
set update_retrobat_decorations=1
set update_gamespack=0
set update_emulationstation=1
set update_emulatorlauncher=1

set update_config=1
set update_es_settings=1
set update_es_systems=1
set update_es_features=1
set update_es_padtokey=1
set update_version=1

REM EMULATORS
set update_retroarch=1
set update_libretro_cores=1

set update_applewin=1
set update_arcadeflashweb=1
set update_cemu=1
set update_citra=1
set update_cxbx-reloaded=1
set update_daphne=1
set update_demul=1
set update_demul-old=1
set update_dolphin-emu=1
set update_dolphin-triforce=1
set update_dosbox=1
rem set update_dosbox_x=1
set update_duckstation=1
set update_fpinball=1
set update_gsplus=1
set update_kega-fusion=1
set update_love=1
set update_m2emulator=1
set update_mame=0
set update_mednafen=1
set update_mesen=1
set update_mgba=1
set update_openbor=1
set update_oricutron=1
set update_pcsx2=1
set update_pico8=0
set update_ppsspp=1
set update_project64=1
set update_raine=1
set update_redream=1
set update_rpcs3=1
set update_ryujinx=0
set update_simcoupe=1
set update_snes9x=1
set update_solarus=1
set update_supermodel=1
set update_teknoparrot=0
set update_tsugaru=1
set update_vpinball=1
set update_winuae=1
set update_xemu=1
set update_xenia=0
set update_xenia-canary=1
set update_yuzu=0

set debug=0
set branch=stable

REM END SWITCHS

REM SET SCRIPT ARGUMENTS

:loop_arg
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
    goto :loop_arg
)

if "%extract_pkg%"=="es" (
	call :extract_es
	goto :eof
)

REM CHECK DEPS
if not exist "!modules_dir!\rb_updater\7za.exe" (
	call :error
	goto :eof
)
if not exist "!modules_dir!\rb_updater\wget.exe" (
	call :error
	goto :eof
)

REM INSTALL PACKAGES
set progress_current=0
set progress_total=90
set progress_percent=0
set download_retry=3

REM CLEAN DOWNLOAD DIR
if exist "!download_dir!\*.7z" del/Q "!download_dir!\*.7z" >nul
if exist "!download_dir!\*.zip" del/Q "!download_dir!\*.zip" >nul

if not exist "!download_dir!\." md "!download_dir!" >nul

REM RETROBAT UPDATE
set package_file=retrobat_main.7z
cls
echo Updating RetroBat main files... ^>^>^> 0%%
set progress_text=Updating RetroBat main files
if "!update_retrobat_main!"=="1" (
	REM DOWNLOAD
	set download_url=https://www.retrobat.ovh/repo/win64/!branch!/!package_file!
	set /A progress_current+=!update_retrobat_main!
	call :download
	call :progress	
	REM EXTRACT
	set extraction_dir=!download_dir!\extract
	set /A progress_current+=!update_retrobat_main!
	if "!update_retrobat_ini!"=="1" if exist "!retrobat_main_dir!\retrobat.ini" del/Q "!retrobat_main_dir!\retrobat.ini" >nul
	call :extract
	xcopy "!download_dir!\extract" "!retrobat_main_dir!" /s /e /y >nul
	rmdir /s /q "!download_dir!\extract" >nul
	REM RECREATE RETROBAT TREE
	for /f "usebackq delims=" %%x in ("%retrobat_main_dir%\system\configgen\retrobat_tree.list") do (
		if not exist "%retrobat_main_dir%\%%x\." md "%retrobat_main_dir%\%%x" >nul
	)
	for /f "usebackq delims=" %%x in ("%retrobat_main_dir%\system\configgen\systems_names.list") do (
		if not exist "%retrobat_main_dir%\roms\%%x\." md "%retrobat_main_dir%\roms\%%x" >nul
		if not exist "%retrobat_main_dir%\saves\%%x\." md "%retrobat_main_dir%\saves\%%x" >nul
	)
	set progress_text=Updating RetroBat GUI
	call :progress
)

REM RETROBAT GUI UPDATE
set package_file=retrobat_gui.7z
if "!update_retrobat_gui!"=="1" (
	REM DOWNLOAD
	set download_url=https://www.retrobat.ovh/repo/win64/!branch!/!package_file!
	set /A progress_current+=!update_retrobat_gui!
	call :download
	call :progress	
	REM EXTRACT
	set extraction_dir=!download_dir!\extract
	set /A progress_current+=!update_retrobat_gui!	
	call :extract
	xcopy "!download_dir!\extract" "!retrobat_main_dir!" /s /e /y >nul
	rmdir /s /q "!download_dir!\extract" >nul
	set progress_text=Updating EmulationStation
	call :progress
)

REM EMULATIONSTATION UPDATE
set package_file=emulationstation.zip
if "!update_emulationstation!"=="1" (
	REM DOWNLOAD
	set download_url=https://www.retrobat.ovh/repo/win64/!branch!/!package_file!
	set /A progress_current+=!update_emulationstation!
	call :download
	set progress_text=Updating carbon theme
	call :progress	
)

REM CARBON THEME UPDATE
set package_file=theme_carbon.zip
if "!update_theme_carbon!"=="1" (
	REM DOWNLOAD
	set download_url=https://www.retrobat.ovh/repo/win64/!branch!/!package_file!
	set /A progress_current+=!update_theme_carbon!
	call :download
	call :progress	
	REM EXTRACT
	set extraction_dir=!default_theme_dir!
	set /A progress_current+=!update_theme_carbon!
	if "!enable_extraction!"=="1" if exist "!default_theme_dir!\es-theme-carbon_old\." rmdir /s /q "!default_theme_dir!\es-theme-carbon_old\" >nul
	if "!enable_extraction!"=="1" if exist "!default_theme_dir!\es-theme-carbon\." move "!default_theme_dir!\es-theme-carbon" "!default_theme_dir!\es-theme-carbon_old"	 >nul
	call :extract
	if "!enable_extraction!"=="1" if exist "!default_theme_dir!\es-theme-carbon-master\." move "!default_theme_dir!\es-theme-carbon-master" "!default_theme_dir!\es-theme-carbon" >nul	
	set progress_text=Updating emulatorLauncher
	call :progress
)

REM EMULATORLAUNCHER UPDATE
set package_file=emulatorlauncher.7z
if "!update_emulatorlauncher!"=="1" (
	REM DOWNLOAD
	set download_url=https://www.retrobat.ovh/repo/win64/!branch!/!package_file!
	set /A progress_current+=!update_emulatorlauncher!
	call :download
	call :progress	
	REM EXTRACT
	set extraction_dir=!emulationstation_dir!
	set /A progress_current+=!update_emulatorlauncher!
	call :extract
	set progress_text=Updating decorations
	call :progress
)

REM DECORATIONS UPDATE
set package_file=decorations.7z
if "!update_retrobat_decorations!"=="1" (
	REM DOWNLOAD
	set download_url=https://www.retrobat.ovh/repo/win64/!branch!/!package_file!
	set /A progress_current+=!update_retrobat_decorations!
	call :download
	call :progress	
	REM EXTRACT
	set extraction_dir=!decorations_dir!
	set /A progress_current+=!update_retrobat_decorations!
	call :extract
	set progress_text=Updating RetroArch
	call :progress
)

REM RETROARCH UPDATE
set package_file=retroarch.7z
if "!update_retroarch!"=="1" if not exist "!emulator_dir!\retroarch\manual_update.txt" (
	REM DOWNLOAD
	set download_url=https://www.retrobat.ovh/repo/win64/!branch!/emulators/!package_file!
	set /A progress_current+=!update_retroarch!
	call :download
	call :progress	
	REM EXTRACT
	set extraction_dir=!emulator_dir!\retroarch
	set /A progress_current+=!update_retroarch!
	call :extract
	set progress_text=Updating Libretro cores
	call :progress	
)

REM LIBRETRO CORES UPDATE
set package_file=libretro_cores.7z
if "!update_libretro_cores!"=="1" if not exist "!emulator_dir!\retroarch\manual_update.txt" (
	REM DOWNLOAD
	set download_url=https://www.retrobat.ovh/repo/win64/!branch!/emulators/!package_file!
	set /A progress_current+=!update_libretro_cores!
	call :download
	call :progress	
	REM EXTRACT
	set extraction_dir=!emulator_dir!\retroarch\cores
	set /A progress_current+=!update_libretro_cores!
	call :extract
	set progress_text=Updating emulators
	call :progress
)

REM EMULATORS UPDATE
for /f "usebackq delims=" %%x in ("%retrobat_main_dir%\system\configgen\emulators_names.list") do (
	set package_file=%%x.7z
	if not "%%x"=="retroarch" if "!update_%%x!"=="1" if not exist "!emulator_dir!\%%x\manual_update.txt" (
	REM DOWNLOAD
	set download_url=https://www.retrobat.ovh/repo/win64/!branch!/emulators/!package_file!
	set /A progress_current+=!update_%%x!
	call :download
	call :progress		
	REM EXTRACT
	set extraction_dir=!emulator_dir!\%%x
	set /A progress_current+=!update_%%x!
	call :extract
	set progress_text=Updating emulators
	call :progress	
	)
)

REM UPDATE CONFIG
if "!update_config!"=="1" (
	set progress_text=Updating configuration
	REM MOVE VIDEOS
	if exist "!current_path!\..\system\templates\emulationstation\retrobat-neon.mp4" move/Y "!current_path!\..\system\templates\emulationstation\retrobat-neon.mp4" "!current_path!\.emulationstation\video" >nul
	if exist "!current_path!\..\system\templates\emulationstation\retrobat-neogeo.mp4" move/Y "!current_path!\..\system\templates\emulationstation\retrobat-neogeo.mp4" "!current_path!\.emulationstation\video" >nul
	if exist "!current_path!\..\system\templates\emulationstation\retrobat-ps2.mp4" move/Y "!current_path!\..\system\templates\emulationstation\retrobat-ps2.mp4" "!current_path!\.emulationstation\video" >nul
	if exist "!current_path!\..\system\templates\emulationstation\retrobat-space.mp4" move/Y "!current_path!\..\system\templates\emulationstation\retrobat-space.mp4" "!current_path!\.emulationstation\video" >nul

	REM COPY ES CONFIG
	if "!update_es_settings!"=="1" if exist "!emulationstation_dir!\.emulationstation\es_settings.cfg.old" del/Q "!emulationstation_dir!\.emulationstation\es_settings.cfg.old" >nul
	if "!update_es_systems!"=="1" if exist "!emulationstation_dir!\.emulationstation\es_systems.cfg.old" del/Q "!emulationstation_dir!\.emulationstation\es_systems.cfg.old" >nul
	if "!update_es_features!"=="1" if exist "!emulationstation_dir!\.emulationstation\es_features.cfg.old" del/Q "!emulationstation_dir!\.emulationstation\es_features.cfg.old" >nul
	if "!update_es_padtokey!"=="1" if exist "!emulationstation_dir!\.emulationstation\es_padtokey.cfg.old" del/Q "!emulationstation_dir!\.emulationstation\es_padtokey.cfg.old" >nul
	
	if "!update_es_settings!"=="1" if exist "!emulationstation_dir!\.emulationstation\es_settings.cfg" (
		copy /v /y "!emulationstation_dir!\.emulationstation\es_settings.cfg" "!emulationstation_dir!\.emulationstation\es_settings.cfg.old" >nul
		copy /v /y "!emulationstation_dir!\..\system\templates\emulationstation\es_settings.cfg" "!emulationstation_dir!\.emulationstation\es_settings.cfg" >nul
	)
	
	if "!update_es_systems!"=="1" if exist "!emulationstation_dir!\.emulationstation\es_systems.cfg" (
		copy /v /y "!emulationstation_dir!\.emulationstation\es_systems.cfg" "!emulationstation_dir!\.emulationstation\es_systems.cfg.old" >nul
		copy /v /y "!emulationstation_dir!\..\system\templates\emulationstation\es_systems.cfg" "!emulationstation_dir!\.emulationstation\es_systems.cfg" >nul
	)
	
	if "!update_es_features!"=="1" if exist "!emulationstation_dir!\.emulationstation\es_features.cfg" (
		copy /v /y "!emulationstation_dir!\.emulationstation\es_features.cfg" "!emulationstation_dir!\.emulationstation\es_features.cfg.old" >nul
		copy /v /y "!emulationstation_dir!\..\system\templates\emulationstation\es_features.cfg" "!emulationstation_dir!\.emulationstation\es_features.cfg" >nul
	)
	
	if "!update_es_padtokey!"=="1" if exist "!emulationstation_dir!\.emulationstation\es_padtokey.cfg" (
		copy /v /y "!emulationstation_dir!\.emulationstation\es_padtokey.cfg" "!emulationstation_dir!\.emulationstation\es_padtokey.cfg.old" >nul
		copy /v /y "!emulationstation_dir!\..\system\templates\emulationstation\es_padtokey.cfg" "!emulationstation_dir!\.emulationstation\es_padtokey.cfg" >nul
	)
	
	if exist "!current_path!\..\emulationstation\.emulationstation\video\retrobat-intro.mp4" del/Q "!current_path!\..\emulationstation\.emulationstation\video\retrobat-intro.mp4"
	if exist "!current_path!\..\system\es_menu\retroarch_angle.menu" (
	copy /v /y "!current_path!\..\system\es_menu\retroarch_angle.menu" "!current_path!\..\system\es_menu\retroarch_angle.menu.old" >nul 
	del/Q "!current_path!\..\system\es_menu\retroarch_angle.menu" >nul
	)
	if exist "!current_path!\..\emulators\retroarch\retroarch_angle.exe" del/Q "!current_path!\..\emulators\retroarch\retroarch_angle.exe" >nul
	
	set /A progress_current+=!update_config!
	call :progress
)

REM CHECK PROGRESS
if "!progress_percent!"=="100" (
	REM UPDATE VERSION	
	if "!update_version!"=="1" (
		if exist "!current_path!\version.info" del/Q "!current_path!\version.info" >nul
		if exist "!current_path!\about.info" del/Q "!current_path!\about.info" >nul
		if exist "!retrobat_main_dir!\system\version.info" del/Q "!retrobat_main_dir!\system\version.info" >nul	
		echo !retrobat_version! > "!current_path!\version.info"
		echo RETROBAT> "!current_path!\about.info"
		echo !retrobat_version!> "!retrobat_main_dir!\system\version.info"
	)
	call :exit
	goto :eof
) else (
	call :error
	goto :eof
)

:download
if "!debug!"=="1" echo !download_url!
if "!enable_download!"=="1" "!modules_dir!\rb_updater\wget" --no-check-certificate wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t !download_retry! -P "!download_dir!" !download_url! -q >nul	
if "!debug!"=="1" pause
if not exist "!download_dir!\!package_file!" (
	call :error
	goto :eof
) else (
	goto :eof
)

:extract
if "!debug!"=="1" (
	echo !package_file!
	echo !CD!
	echo !current_path!
	echo !extraction_dir!
	echo !download_dir!\!package_file!
	if "!enable_extraction!"=="1" if not exist "!extraction_dir!\." md "!extraction_dir!"
	if "!enable_extraction!"=="1" "!modules_dir!\rb_updater\7za.exe" -y x "!download_dir!\!package_file!" -aoa -o"!extraction_dir!"
) else (
	if "!enable_extraction!"=="1" if not exist "!extraction_dir!\." md "!extraction_dir!" >nul
	if "!enable_extraction!"=="1" "!modules_dir!\rb_updater\7za.exe" -y x "!download_dir!\!package_file!" -aoa -o"!extraction_dir!" >nul
)
if "!debug!"=="1" (
	del/Q "!download_dir!\!package_file!"
) else (
	del/Q "!download_dir!\!package_file!" >nul
)
if "!debug!"=="1" pause	
goto :eof

:progress
if "!debug!"=="0" cls
set /a progress_percent=100*!progress_current!/progress_total
echo !progress_text!... ^>^>^> !progress_percent!%%
if "!debug!"=="1" pause
rem timeout /t 1 >nul
goto :eof	

:exit
cls
echo update done !
rem timeout /t 1 >nul
if exist !download_dir!\emulationstation.zip echo !download_dir!\emulationstation.zip
exit 0

:error
cls
echo update failed !
rem timeout /t 1 >nul
exit 1

endlocal

:extract_es
cls
set package_file=emulationstation.zip
"%CD%\system\modules\rb_updater\7za.exe" -y x "%CD%\system\download\%package_file%" -aoa -o"%CD%\emulationstation" >nul
del/Q "%CD%\system\download\%package_file%" >nul
rem timeout /t 3 >nul
exit
