@echo on
setlocal EnableDelayedExpansion

echo Launching updater...

set script_type=updater
set retroarch_version=1.10.1

:: ---- SET ROOT PATH ----

cd ..

set current_file=%~nx0
set current_drive="%cd:~0,2%"
set current_dir="%cd:~3%"
set current_drive=%current_drive:"=%
set current_dir=%current_dir:"=%
set current_path=!current_drive!\!current_dir!

set root_path=!current_path!

:: ---- SET TEMPORARY FILE WHERE TO STORE INFOS ----

set tmp_infos_file=!root_path!\emulationstation\rb_infos.tmp
if exist "%tmp_infos_file%" del/Q "%tmp_infos_file%"

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

:: ---- CALL SHARED VARIABLES SCRIPT ----

if exist "!root_path!\system\scripts\shared-variables.cmd" (
	cd "!root_path!\system\scripts"
	call shared-variables.cmd
) else (
	set error_msg=missing rb_updater script!
	call :error
	goto :eof
)

:: ---- GET INFOS STORED IN TMP FILE ----

if exist "%tmp_infos_file%" (
	for /f "delims=" %%x in ('type "%tmp_infos_file%"') do (set "%%x")
) else (
	set error_msg=missing rb_updater script!
	call :error
	goto :eof
)

:: ---- WINDOW TITLE ----

title %name% Updater Script

:: ---- MODULES VERIFICATION ----

if not exist "%system_path%\modules\rb_updater\*.*" (
	set error_msg=missing rb_updater modules!
	call :error
	goto :eof
)
pause
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
set update_es_settings=1
set update_es_systems=1
set update_es_features=1
set update_es_padtokey=1
set update_version=1

set download_retry=3

:: ---- PERCENTAGE PROGRESSION ----

set progress_current=0
set progress_total=20
set progress_percent=0

:: ---- UPDATE PACKAGES ----

set packages_list=(retrobat batgui bios emulationstation default_theme batocera_ports decorations mega_bezels retroarch)

for %%i in %packages_list% do echo !%%i_url!
pause
for %%i in %packages_list% do (

	if "!update_%%i!"=="1" (
				
		set package_file=%%i.7z
		set progress_text=updating %%i
		set download_url=!%%i_url!/%package_file%

		if "%enable_download%"=="1" call :download
	
		set /A progress_current+=!update_%%i!
		if "%enable_download%"=="1" call :progress

		set destination_path=!%%i_path!
		
		if "%enable_extraction%"=="1" call :extract
		
		if "%%i" == "retrobat" (
		
			for /f "usebackq delims=" %%x in ("%system_path%\configgen\retrobat_tree.list") do (
			
			if not exist "%root_path%\%%x\." md "%root_path%\%%x" >nul
			)
			
			for /f "usebackq delims=" %%x in ("%system_path%\configgen\systems_names.list") do (
			
			if not exist "%root_path%\roms\%%x\." md "%root_path%\roms\%%x" >nul
			if not exist "%root_path%\saves\%%x\." md "%root_path%\saves\%%x" >nul
			)
		)
	
		set /A progress_current+=!update_%%i!
		if "%enable_extraction%"=="1" call :progress		
	)

)

:: ---- UPDATE LIBRETRO CORES ----

if "%update_lrcores%"=="1" (

	for /f "usebackq delims=" %%x in ("%system_path%\configgen\lrcores_names.list") do (

		set package_file=%%x_libretro.dll.zip
		set progress_text=updating %%x_libretro

		set download_url=%lrcores_url%/%package_file%	
		if "%enable_download%"=="1" call :download
	
		set /A progress_current+=%update_lrcores%
		if "%enable_download%"=="1" call :progress

		set destination_path=%lrcores_path%
		if "%enable_extraction%"=="1" call :extract
	
		set /A progress_current+=%update_lrcores%
		if "%enable_extraction%"=="1" call :progress
	)		
)

if "%update_config%"=="1" (

	set progress_text=Updating Configuration

	if exist "%root_path%\system\templates\emulationstation\retrobat-neon.mp4" move/Y "%root_path%\system\templates\emulationstation\retrobat-neon.mp4" "%emulationstation_path%\.emulationstation\video" >nul
	if exist "%root_path%\system\templates\emulationstation\retrobat-neogeo.mp4" move/Y "%root_path%\system\templates\emulationstation\retrobat-neogeo.mp4" "%emulationstation_path%\.emulationstation\video" >nul
	if exist "%root_path%\system\templates\emulationstation\retrobat-ps2.mp4" move/Y "%root_path%\system\templates\emulationstation\retrobat-ps2.mp4" "%emulationstation_path%\.emulationstation\video" >nul
	if exist "%root_path%\..\system\templates\emulationstation\retrobat-space.mp4" move/Y "%root_path%\system\templates\emulationstation\retrobat-space.mp4" "%emulationstation_path%\.emulationstation\video" >nul

	if "%update_es_settings%"=="1" if exist "%emulationstation_path%\.emulationstation\es_settings.cfg.old" del/Q "%emulationstation_path%\.emulationstation\es_settings.cfg.old" >nul
	if "%update_es_systems%"=="1" if exist "%emulationstation_path%\.emulationstation\es_systems.cfg.old" del/Q "%emulationstation_path%\.emulationstation\es_systems.cfg.old" >nul
	if "%update_es_features%"=="1" if exist "%emulationstation_path%\.emulationstation\es_features.cfg.old" del/Q "%emulationstation_path%\.emulationstation\es_features.cfg.old" >nul
	if "%update_es_padtokey%"=="1" if exist "%emulationstation_path%\.emulationstation\es_padtokey.cfg.old" del/Q "%emulationstation_path%\.emulationstation\es_padtokey.cfg.old" >nul
	
	if "%update_es_settings%"=="1" if exist "%emulationstation_path%\.emulationstation\es_settings.cfg" (
		copy /v /y "%emulationstation_path%\.emulationstation\es_settings.cfg" "%emulationstation_path%\.emulationstation\es_settings.cfg.old" >nul
		copy /v /y "%emulationstation_path%\..\system\templates\emulationstation\es_settings.cfg" "%emulationstation_path%\.emulationstation\es_settings.cfg" >nul
	)
	
	if "%update_es_systems%"=="1" if exist "%emulationstation_path%\.emulationstation\es_systems.cfg" (
		copy /v /y "%emulationstation_path%\.emulationstation\es_systems.cfg" "%emulationstation_path%\.emulationstation\es_systems.cfg.old" >nul
		copy /v /y "%emulationstation_path%\..\system\templates\emulationstation\es_systems_retrobat.cfg" "%emulationstation_path%\.emulationstation\es_systems.cfg" >nul
	)
	
	if "%update_es_features%"=="1" if exist "%emulationstation_path%\.emulationstation\es_features.cfg" (
		copy /v /y "%emulationstation_path%\.emulationstation\es_features.cfg" "%emulationstation_path%\.emulationstation\es_features.cfg.old" >nul
		copy /v /y "%emulationstation_path%\..\system\templates\emulationstation\es_features.cfg" "%emulationstation_path%\.emulationstation\es_features.cfg" >nul
	)
	
	if "%update_es_padtokey%"=="1" if exist "%emulationstation_path%\.emulationstation\es_padtokey.cfg" (
		copy /v /y "%emulationstation_path%\.emulationstation\es_padtokey.cfg" "%emulationstation_path%\.emulationstation\es_padtokey.cfg.old" >nul
		copy /v /y "%emulationstation_path%\..\system\templates\emulationstation\es_padtokey.cfg" "%emulationstation_path%\.emulationstation\es_padtokey.cfg" >nul
	)
	
	if exist "%root_path%\emulationstation\.emulationstation\video\retrobat-intro.mp4" del/Q "%root_path%\emulationstation\.emulationstation\video\retrobat-intro.mp4" >nul
	if exist "%root_path%\system\es_menu\retroarch_angle.menu" (
	copy /v /y "%root_path%\system\es_menu\retroarch_angle.menu" "%root_path%\system\es_menu\retroarch_angle.menu.old" >nul 
	del/Q "%root_path%\system\es_menu\retroarch_angle.menu" >nul
	)
	if exist "%root_path%\emulators\retroarch\retroarch_angle.exe" del/Q "%root_path%\emulators\retroarch\retroarch_angle.exe" >nul
	
	if exist "%root_path%\system\templates\emulationstation\notice.pdf" copy /v /y "%root_path%\system\templates\emulationstation\notice.pdf" "%root_path%\emulationstation\.emulationstation\notice.pdf" >nul
	
	if exist "%root_path%\emulators\supermodel\Supermodel.ini" del/Q "%root_path%\emulators\supermodel\Supermodel.ini" >nul
	if exist "%root_path%\system\templates\supermodel\Supermodel.ini" if exist "%root_path%\emulators\supermodel\Config\Supermodel.ini" del/Q "%root_path%\emulators\supermodel\Config\Supermodel.ini" >nul
	if exist "%root_path%\system\templates\supermodel\Supermodel.ini" copy /v /y "%root_path%\system\templates\supermodel\Supermodel.ini" "%root_path%\emulators\supermodel\Config\Supermodel.ini" >nul
	
	if exist "%root_path%\roms\n64dd\*.*" if exist "%root_path%\roms\64dd\." copy/Y "%root_path%\roms\n64dd\*.*" "%root_path%\roms\64dd" >nul
	if exist "%root_path%\roms\n64dd\." rd /S /Q "%root_path%\roms\n64dd"
	if exist "%emulationstation_path%\.emulationstation\themes\es-theme-carbon\art\logos\64dd.svg" ren "%emulationstation_path%\.emulationstation\themes\es-theme-carbon\art\logos\64dd.svg" "_64dd.svg" >nul
	
	set /A progress_current+=%update_config%
	call :progress
)
endlocal
goto exit

:: ---- DOWNLOAD ----

:download

"%system_path%\modules\rb_updater\wget" --no-check-certificate wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t %download_retry% -P "%download_path%" %download_url% -q >nul	
if not exist "%download_path%\%package_file%" (
	call :error
	goto :eof
) else (
	goto :eof
)

:: ---- FILES EXTRACTION ----

:extract

if not exist "%extraction_path%\." md "%extraction_path%" >nul
"%system_path%\modules\rb_updater\7za.exe" -y x "%download_path%\%package_file%" -aoa -o"%extraction_path%" >nul
xcopy "%extraction_path%" "%destination_path%" /s /e /y >nul
rmdir /s /q "%download_path%\extract" >nul
del/Q "%download_path%\%package_file%" >nul

goto :eof

:: ---- CALCULATE PERCENTAGE TO OUTPUT ----

:progress

cls
set /a progress_percent=100*%progress_current%/progress_total
echo %progress_text%... ^>^>^> %progress_percent%%%

goto :eof

:: ---- ERROR MESSAGE ----

:error
cls
echo error: %error_msg%
exit 1

:extract_es
cls
set package_file=emulationstation.zip
"%CD%\system\modules\rb_updater\7za.exe" -y x "%CD%\system\download\%package_file%" -aoa -o"%CD%\emulationstation" >nul
del/Q "%CD%\system\download\%package_file%" >nul
rem timeout /t 3 >nul
exit