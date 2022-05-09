@echo off
setlocal EnableDelayedExpansion

echo preparing update... ^>^>^> 0%%

set script_type=updater
set retroarch_version=1.10.3

:: ---- DEBUG SWITCHES ----

set enable_download=1
set enable_extraction=1

:: ---- UPDATER SWITCHES ----

set update_decorations=1
set update_default_theme=1
set update_emulationstation=1
set update_batocera_ports=1
set update_games=0
set update_batgui=0
set update_retrobat=1
set update_mega_bezels=0
set update_bios=1

set update_retroarch=1
set update_lrcores=1

set update_config=1
set update_es_settings=0
set update_es_systems=1
set update_es_features=1
set update_es_padtokey=1
set update_version=1

set download_retry=3

:: ---- PERCENTAGE PROGRESSION ----

:: The emulationstation package doesn't count for progress_total as it will be downloaded but not extracted.
:: The libretro cores only counts for one for progress_total because we don't want to count all the cores. 

set progress_current=0
set progress_total=15
set progress_percent=0

:: ---- SCRIPT ARGUMENTS ----

set branch=stable

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

:: ---- GET STARTED ----

call :set_root
call :set_install
call :set_updater

:: ---- UPDATE PACKAGES LOOP ----

set packages_list=(retrobat batgui bios emulationstation default_theme batocera_ports decorations mega_bezels retroarch)

for %%i in %packages_list% do (

	if "!update_%%i!"=="1" (
		
		(set package_name=%%i)
		(set package_file=%%i.7z)
		(set progress_text=updating !package_name!)
		(set download_url=!%%i_url!)
		(set destination_path=!%%i_path!)		

		if "!package_name!"=="emulationstation" (
		
			set package_file=EmulationStation-Win32.zip
			
			if "!enable_download!"=="1" (
			
				call :download
			)
			
		) else (
		
			if "!package_name!"=="default_theme" (set package_file=master.zip)
			if "!package_name!"=="batocera_ports" (set package_file=batocera-ports.zip)
			if "!package_name!"=="bios" (set package_file=main.zip)
			if "!package_name!"=="retroarch" (set package_file=RetroArch.7z)
			
			if "!enable_download!"=="1" (
			
				call :download
				set /A progress_current+=!update_%%i!
				call :progress
			)			
			
			if "!enable_extraction!"=="1" (
				
				call :extract
				set /A progress_current+=!update_%%i!
				call :progress
			)				
		)		
	)
)

:: ---- UPDATE LIBRETRO CORES LOOP ----

if "%update_lrcores%"=="1" (

	for /f "usebackq delims=" %%x in ("%system_path%\configgen\lrcores_names.list") do (

		(set package_name=%%x)
		(set package_file=%%x_libretro.dll.zip)
		(set progress_text=updating %%x_libretro)
		(set download_url=%lrcores_url%/!package_file!)
		(set destination_path=%lrcores_path%)

		if "%enable_download%"=="1" call :download
		if "%enable_extraction%"=="1" call :extract	
	)
	
	set /A progress_current+=%update_lrcores%
	call :progress	
)

:: ---- UPDATE CONFIG ----

if "%update_config%"=="1" (

	for /f "usebackq delims=|" %%f in (`dir /b "%root_path%\system\templates\emulationstation\*.mp4"`) do (
	
		move/Y %%f "%emulationstation_path%\.emulationstation\video" >nul
	)

	if "%update_es_settings%"=="1" (
		
		if exist "%emulationstation_path%\.emulationstation\es_settings.cfg.old" del/Q "%emulationstation_path%\.emulationstation\es_settings.cfg.old" >nul		
		
		if exist "%emulationstation_path%\.emulationstation\es_settings.cfg" (
		
			copy /v /y "%emulationstation_path%\.emulationstation\es_settings.cfg" "%emulationstation_path%\.emulationstation\es_settings.cfg.old" >nul
			copy /v /y "%emulationstation_path%\..\system\templates\emulationstation\es_settings.cfg" "%emulationstation_path%\.emulationstation\es_settings.cfg" >nul
		)
	)
	
	if "%update_es_systems%"=="1" (
		
		if exist "%emulationstation_path%\.emulationstation\es_systems.cfg.old" del/Q "%emulationstation_path%\.emulationstation\es_systems.cfg.old" >nul
	
		if exist "%emulationstation_path%\.emulationstation\es_systems.cfg" (
			
			copy /v /y "%emulationstation_path%\.emulationstation\es_systems.cfg" "%emulationstation_path%\.emulationstation\es_systems.cfg.old" >nul
			copy /v /y "%emulationstation_path%\..\system\templates\emulationstation\es_systems_retrobat.cfg" "%emulationstation_path%\.emulationstation\es_systems.cfg" >nul
		)
	)
	
	if "%update_es_features%"=="1" (
		
		if exist "%emulationstation_path%\.emulationstation\es_features.cfg.old" del/Q "%emulationstation_path%\.emulationstation\es_features.cfg.old" >nul
	
		if exist "%emulationstation_path%\.emulationstation\es_features.cfg" (
		
			copy /v /y "%emulationstation_path%\.emulationstation\es_features.cfg" "%emulationstation_path%\.emulationstation\es_features.cfg.old" >nul
			copy /v /y "%emulationstation_path%\..\system\templates\emulationstation\es_features.cfg" "%emulationstation_path%\.emulationstation\es_features.cfg" >nul
		)
	)
	
	if "%update_es_padtokey%"=="1" (
		
		if exist "%emulationstation_path%\.emulationstation\es_padtokey.cfg.old" del/Q "%emulationstation_path%\.emulationstation\es_padtokey.cfg.old" >nul
	
		if exist "%emulationstation_path%\.emulationstation\es_padtokey.cfg" (
		
			copy /v /y "%emulationstation_path%\.emulationstation\es_padtokey.cfg" "%emulationstation_path%\.emulationstation\es_padtokey.cfg.old" >nul
			copy /v /y "%emulationstation_path%\..\system\templates\emulationstation\es_padtokey.cfg" "%emulationstation_path%\.emulationstation\es_padtokey.cfg" >nul
		)
	)
	
	if exist "%root_path%\emulationstation\.emulationstation\video\retrobat-intro.mp4" del/Q "%root_path%\emulationstation\.emulationstation\video\retrobat-intro.mp4" >nul
	
	if exist "%root_path%\system\es_menu\retroarch_angle.menu" (
	
		copy /v /y "%root_path%\system\es_menu\retroarch_angle.menu" "%root_path%\system\es_menu\retroarch_angle.menu.old" >nul 
		del/Q "%root_path%\system\es_menu\retroarch_angle.menu" >nul
	)
	
	if exist "%root_path%\emulators\retroarch\retroarch_angle.exe" del/Q "%root_path%\emulators\retroarch\retroarch_angle.exe" >nul
	
	if exist "%root_path%\system\templates\emulationstation\notice.pdf" copy /v /y "%root_path%\system\templates\emulationstation\notice.pdf" "%root_path%\emulationstation\.emulationstation\notice.pdf" >nul
	
	rem if exist "%root_path%\emulators\supermodel\Supermodel.ini" del/Q "%root_path%\emulators\supermodel\Supermodel.ini" >nul
	rem if exist "%root_path%\system\templates\supermodel\Supermodel.ini" if exist "%root_path%\emulators\supermodel\Config\Supermodel.ini" del/Q "%root_path%\emulators\supermodel\Config\Supermodel.ini" >nul
	if not exist "%root_path%\emulators\supermodel\Config\Supermodel.ini" if exist "%root_path%\system\templates\supermodel\Supermodel.ini" copy /v /y "%root_path%\system\templates\supermodel\Supermodel.ini" "%root_path%\emulators\supermodel\Config\Supermodel.ini" >nul
	
	if exist "%root_path%\roms\n64dd\*.*" if exist "%root_path%\roms\64dd\." copy/Y "%root_path%\roms\n64dd\*.*" "%root_path%\roms\64dd" >nul
	if exist "%root_path%\roms\n64dd\." rd /S /Q "%root_path%\roms\n64dd"
	rem if exist "%emulationstation_path%\.emulationstation\themes\es-theme-carbon\art\logos\64dd.svg" ren "%emulationstation_path%\.emulationstation\themes\es-theme-carbon\art\logos\64dd.svg" "_64dd.svg" >nul
	
	set progress_text=updating configuration
	set /A progress_current+=%update_config%
	call :progress
)

:: ---- CHECK IF COMPLETE ----

if "!progress_percent!"=="100" (
	
	if "!update_version!"=="1" (
	
		if exist "%emulationstation_path%\version.info" del/Q "%emulationstation_path%\version.info" >nul
		if exist "%emulationstation_path%\about.info" del/Q "%emulationstation_path%\about.info" >nul
		if exist "!root_path!\system\version.info" del/Q "!root_path!\system\version.info" >nul
		
		(echo %version_remote%)>"%emulationstation_path%\version.info"
		(echo RETROBAT)>"%emulationstation_path%\about.info"
		(echo %version_remote%)>"!root_path!\system\version.info"
	)
	
	set exit_msg=update complete!
	set exit_code=0
	call :exit_door
	goto :eof
	
) else (

	set exit_msg=error: update failed!
	set exit_code=1
	call :exit_door
	goto :eof
)

:: ---- FUNCTIONS ----

:: ---- SET ROOT PATH ----

:set_root

cd ..

set current_file=%~nx0
set current_drive="%cd:~0,2%"
set current_dir="%cd:~3%"
set current_drive=%current_drive:"=%
set current_dir=%current_dir:"=%
set current_path=!current_drive!\!current_dir!

set root_path=!current_path!

goto :eof

:: ---- SET INSTALL INFOS ----

:set_install

:: ---- SET TMP FILE ----

set "tmp_infos_file=!root_path!\emulationstation\rb_infos.tmp"
if exist "%tmp_infos_file%" del/Q "%tmp_infos_file%"

:: ---- CALL SHARED VARIABLES SCRIPT ----

if exist "!root_path!\system\scripts\shared-variables.cmd" (

	cd "!root_path!\system\scripts"
	call shared-variables.cmd
	
) else (

	set error_msg=missing rb_updater script!
	call :exit_door
	goto :eof

)

:: ---- GET INFOS STORED IN TMP FILE ----

if exist "%tmp_infos_file%" (

	for /f "delims=" %%x in ('type "%tmp_infos_file%"') do (set "%%x")
	
) else (

	set error_msg=missing rb_updater script!
	set exit_code=2
	call :exit_door
	goto :eof
)

:: ---- WINDOW TITLE ----

title %name% Updater Script

goto :eof

:: ---- MODULES VERIFICATION ----

:set_updater

if not exist "%system_path%\modules\rb_updater\*.*" (

	set error_msg=missing rb_updater modules!
	set exit_code=2
	call :exit_door
	goto :eof
)

goto :eof

:: ---- DOWNLOAD PACKAGES ----

:download

if "!package_name!"=="mame2016" (

	set download_url=https://www.retrobat.ovh/repo/%arch%/legacy/lrcores
)

"%system_path%\modules\rb_updater\wget" --no-check-certificate --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t %download_retry% -P "%download_path%" !download_url!/!package_file! -q >nul

if "!package_name!"=="emulationstation" (
		
	set package_file=emulationstation.zip
	
	if exist "%download_path%\EmulationStation-Win32.zip" (
	
		cd "%download_path%"
		ren "EmulationStation-Win32.zip" "!package_file!"
		cd "%root_path%"
	)
)

if not exist "%download_path%\%package_file%" (

	set exit_msg=error: package not found!
	set exit_code=1
	call :exit_door
	goto :eof
	
) else (

	goto :eof
)

:: ---- EXTRACT PACKAGES ----

:extract

if not exist "%extraction_path%\." md "%extraction_path%" >nul
"%system_path%\modules\rb_updater\7za.exe" -y x "%download_path%\%package_file%" -aoa -o"%extraction_path%" >nul

set true=1

if "!package_name!"=="bios" (
	
	set true=0
	xcopy "%extraction_path%\RetroBat-BIOS-main" "%destination_path%" /e /v /y >nul
)

if "!package_name!"=="default_theme" (
	
	set true=0
	xcopy "%extraction_path%\es-theme-carbon-master" "%destination_path%\es-theme-carbon" /e /v /y >nul
)

if "!package_name!"=="retroarch" (

	set true=0
	
	if exist "%retroarch_path%\*.dll" del/Q "%retroarch_path%\*.dll"
	
	if "%archx%"=="x86_64" (
				
		xcopy "%extraction_path%\RetroArch-Win64" "%destination_path%" /e /v /y >nul
		rmdir /s /q "%download_path%\extract\RetroArch-Win64" >nul
	)
	
	if "%archx%"=="x86" (
	
		xcopy "%extraction_path%\RetroArch" "%destination_path%" /e /v /y >nul
		rmdir /s /q "%download_path%\extract\RetroArch" >nul
	)
	
) 

if "%true%"=="1" (

	xcopy "%extraction_path%" "%destination_path%" /e /v /y >nul
)

if "!package_name!"=="retrobat" (
		
	for /f "usebackq delims=" %%x in ("%system_path%\configgen\retrobat_tree.list") do (
			
		if not exist "%root_path%\%%x\." md "%root_path%\%%x" >nul
	)
			
	for /f "usebackq delims=" %%x in ("%system_path%\configgen\systems_names.list") do (
			
		if not exist "%root_path%\roms\%%x\." md "%root_path%\roms\%%x" >nul
		if not exist "%root_path%\saves\%%x\." md "%root_path%\saves\%%x" >nul
	)
)	
 
rmdir /s /q "%download_path%\extract" >nul
del/Q "%download_path%\%package_file%" >nul

goto :eof

:: ---- CALCULATE PERCENTAGE TO OUTPUT ----

:progress

set /a progress_percent=100*!progress_current!/progress_total
echo !progress_text!... ^>^>^> !progress_percent!%%

goto :eof

:: ---- EXTRACT EMULATIONSTATION ----

:extract_es

set package_file=emulationstation.zip
"%CD%\system\modules\rb_updater\7za.exe" -y x "%CD%\system\download\%package_file%" -aoa -o"%CD%\emulationstation" >nul
del/Q "%CD%\system\download\%package_file%" >nul

exit

:: ---- EXIT ----

:exit_door

::if exist "%emulationstation_path%\rb_updater.log" del/Q "%emulationstation_path%\rb_updater.log" >nul
::(echo %exit_msg%)>> "%emulationstation_path%\rb_updater.log"
::(echo exit_code=!exit_code!)>> "%emulationstation_path%\rb_updater.log"
exit !exit_code!