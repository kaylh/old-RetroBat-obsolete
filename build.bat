@echo off
setlocal EnableDelayedExpansion

goto:rem
---------------------------------------
build.bat
---------------------------------------
This batch script is made to help download all the required software for RetroBat,
to set the default configuration and to build the setup from sources.
---------------------------------------
:rem

:: ---- BUILDER OPTION ----

set retrobat_version=5.0.0
set retroarch_version=1.10.3

set get_batgui=0
set get_batocera_ports=1
set get_bios=1
set get_decorations=1
set get_default_theme=1
set get_emulationstation=1
set get_emulators=0
set get_lrcores=1
set get_mega_bezels=0
set get_retroarch=1
set get_retrobat_binaries=1
set get_system=1
set get_wiimotegun=1

:: ---- ARCHIVE OPTIONS ----

:: archive_format: zip|7z
:: archive_compression: 0|1|3|5|7|9

set archive_format=zip
set archive_compression=7

:: ---- LOOP LIST ----

set deps_list=(git makensis 7za strip wget)
set submodules_list=(bios default_theme decorations system)
set packages_list=(retrobat_binaries batgui emulationstation batocera_ports mega_bezels retroarch roms wiimotegun)
set legacy_cores_list=(4do imageviewer mame2016 px68k)
set emulators_black_list=(pico8 retroarch ryujinx steam teknoparrot xenia)

:: ---- GET STARTED ----

set script_type=builder
set git_branch=master
set branch=beta
set release_version=null
set log_file=build.log

call :set_root
call :set_install
call :set_builder

:: ---- UI ----

call :banner

echo  This script can help you to download all the required 
echo  softwares and build the RetroBat Setup with the NullSoft 
echo  Scriptable Install System.
echo +===========================================================+
echo  (1) - download, configure, build, archive
echo  (2) - download, configure
echo  (3) - build
echo  (4) - archive
if exist "!root_path!\butler_push.txt" echo  (5) - push
echo  (Q) - Quit
echo +===========================================================+
if not exist "!root_path!\butler_push.txt" choice /C 1234Q /N /T 15 /D 1 /M "Please type your choice here: "
if exist "!root_path!\butler_push.txt" choice /C 12345Q /N /T 15 /D 1 /M "Please type your choice here: "
echo +===========================================================+
set user_choice=%ERRORLEVEL%

if %user_choice% EQU 1 (

	call :get_packages
	call :set_config
	call :build_setup
	call :create_archive
	call :exit_door
	goto :eof
)

if %user_choice% EQU 2 (

	call :get_packages
	call :set_config
	call :exit_door
	goto :eof
)

if %user_choice% EQU 3 (

	call :build_setup
	call :exit_door
	goto :eof
)

if %user_choice% EQU 4 (

	call :create_archive
	call :exit_door
	goto :eof
)

if not exist "!root_path!\butler_push.txt" if %user_choice% EQU 5 (

	(set exit_code=0)
	call :exit_door
	goto :eof
)

if exist "!root_path!\butler_push.txt" if %user_choice% EQU 5 (

	call :butler_push
	call :exit_door
	goto :eof
)

if exist "!root_path!\butler_push.txt" if %user_choice% EQU 6 (

	(set exit_code=0)
	call :exit_door
	goto :eof
)

:: ---- LABELS ----

:: ---- SET ROOT PATH ----

:set_root

set task=set_root

set current_file=%~nx0
set current_drive="%cd:~0,2%"
set current_dir="%cd:~3%"
set current_drive=%current_drive:"=%
set current_dir=%current_dir:"=%
set current_path=!current_drive!\!current_dir!
set root_path=!current_path!

if not "%log_file%" == "" if exist "!root_path!\%log_file%" del/Q "!root_path!\%log_file%" >nul
(echo %date% %time% [START] Run: !current_file!)>> "!root_path!\%log_file%"
(echo %date% %time% [LABEL] :!task!)>> "!root_path!\%log_file%"
(echo %date% %time% [INFO] Current Path: "!current_path!")>> "!root_path!\%log_file%"

goto :eof

:: ---- SET INSTALL INFOS ----

:set_install

set task=set_install
(echo %date% %time% [LABEL] :!task!)>> "!root_path!\%log_file%"

:: ---- SET TMP FILE ----

set tmp_infos_file=!root_path!\rb_infos.tmp
if not "%tmp_infos_file%" == "" if exist "!tmp_infos_file!" del/Q "!tmp_infos_file!"

:: ---- CALL SHARED VARIABLES SCRIPT ----

if exist "!root_path!\system\scripts\shared-variables.cmd" (

	cd "!root_path!\system\scripts"
	call shared-variables.cmd	
	
) else (

	(set exit_code=2)
	call :exit_door
	goto :eof
)

:: ---- GET INFOS STORED IN TMP FILE ----

if exist "!tmp_infos_file!" (

	for /f "delims=" %%x in ('type "!tmp_infos_file!"') do (set "%%x") 
	if not "%tmp_infos_file%" == "" del/Q "!tmp_infos_file!"
	
) else (

	(set/A exit_code=2)
	call :exit_door
	goto :eof
)

(echo %date% %time% [INFO] Version: %name%-%retrobat_version%-%branch%)>> "!root_path!\%log_file%"
(echo %date% %time% [INFO] Build Path: "!build_path!")>> "!root_path!\%log_file%"
(echo %date% %time% [INFO] Download Path: "!download_path!")>> "!root_path!\%log_file%"

:: ---- WINDOW TITLE ----

title !name! builder script

goto :eof

:: ---- DEPENDENCIES CHECKING ----

:set_builder

set task=set_builder
(echo %date% %time% [LABEL] :!task!)>> "!root_path!\%log_file%"

call :banner

echo :: SETTING BUILD ENVIRONMENT...

if not exist "!build_path!\." md "!build_path!"
if not exist "!download_path!\." md "!download_path!"

(set/A found_total=0)

if "%archx%"=="x86_64" (set "git_path=%ProgramFiles%\Git\cmd") else (set "git_path=%ProgramFiles(x86)%\Git\cmd")

for %%i in %deps_list% do (

	(set/A found_%%i=0)
	(set/A found_total=!found_total!+1)
	(set package_name=%%i)
	(set buildtools_path=!root_path!\buildtools\msys)
	
	if "!package_name!"=="git" (set buildtools_path=!git_path!)
	if "!package_name!"=="makensis" (set buildtools_path=!root_path!\buildtools\nsis)
	
	if exist "!buildtools_path!\!package_name!.exe" (
	
		(set/A found_%%i=!found_%%i!+1)
		(echo %%i: found)
		(echo %date% %time% [INFO] %%i: found)>> "!root_path!\%log_file%"
		
	) else (
	
		(echo %%i: not found)
		(echo %date% %time% [INFO] %%i: not found)>> "!root_path!\%log_file%"
	)
	
	(set/A found_total=!found_total!-!found_%%i!)		
)

if !found_total! NEQ 0 (
	
	(set/A exit_code=2)
	call :exit_door
	goto :eof
)
	
timeout /t 3 >nul

goto :eof

:: ---- GET PACKAGES ----

:get_packages

set task=get_packages
(echo %date% %time% [LABEL] :!task!)>> "!root_path!\%log_file%"

echo :: GETTING REQUIRED PACKAGES...

cd !root_path!
git submodule update --init

if %ERRORLEVEL% NEQ 0 (

	(set/A exit_code=%ERRORLEVEL%)
	call :exit_door
	goto :eof
)

if "%get_retrobat_binaries%"=="1" (
	for %%i in (txt) do (xcopy "!root_path!\*.%%i" "!build_path!" /v /y)
	if exist "!build_path!\butler_push.txt" del/Q "!build_path!\butler_push.txt"
	
	(echo %date% %time% [INFO] retrobat_binaries copied to "!build_path!")>> "!root_path!\%log_file%"
)

for %%i in %submodules_list% do (

	if "!get_%%i!"=="1" (
	
		(set package_name=%%i)
		(set destination_path=!%%i_path!)
	
		if "!package_name!"=="bios" (set folder=bios)
		if "!package_name!"=="default_theme" (set folder=emulationstation\.emulationstation\themes\es-theme-carbon)
		if "!package_name!"=="decorations" (set folder=system\decorations)
		if "!package_name!"=="system" (set folder=system)
		
		xcopy "!root_path!\!folder!" "!destination_path!\" /s /e /v /y
		
		(echo %date% %time% [INFO] !package_name! copied to "!destination_path!")>> "!root_path!\%log_file%"		
	)
)

for %%i in %packages_list% do (

	if "!get_%%i!"=="1" (
		
		(set package_name=%%i)
		(set package_file=%%i.7z)
		(set download_url=!%%i_url!)
		(set destination_path=!%%i_path!)

		if "!package_name!"=="retrobat_binaries" (set package_file=%%i_%git_branch%.7z)
		if "!package_name!"=="emulationstation" (set package_file=EmulationStation-Win32.zip)
		if "!package_name!"=="batocera_ports" (set package_file=batocera-ports.zip)
		if "!package_name!"=="retroarch" (set package_file=RetroArch.7z)
		if "!package_name!"=="wiimotegun" (set package_file=WiimoteGun.zip)
		
		call :download
		call :extract		
	)
)

if "%get_lrcores%"=="1" (

	for /f "usebackq delims=" %%x in ("%system_path%\configgen\lrcores_names.list") do (

		(set package_name=%%x)
		(set package_file=%%x_libretro.dll.zip)
		(set download_url=%lrcores_url%/!package_file!)
		(set destination_path=%lrcores_path%)

		call :download
		call :extract	
	)
)

if "%get_emulators%"=="1" (

	for /f "usebackq delims=" %%x in ("%system_path%\configgen\emulators_names.list") do (

		(set package_name=%%x)
		(set package_file=%%x.7z)
		(set download_url=!emulators_url!)
		(set destination_path=!emulators_path!\%%x)
		
		set skip=0
		
		for %%i in %emulators_black_list% do (
		
			if "!package_name!"=="%%i" (set skip=1)
		)
		
		if "!skip!"=="0" (

			call :download
			call :extract
		)
	)
)

goto :eof

:: ---- DOWNLOAD PACKAGES ----

:download

set task=download
(echo %date% %time% [LABEL] :!task!)>> "!root_path!\%log_file%"

echo *************************************************************

for %%j in %legacy_cores_list% do (

	if "!package_name!"=="%%j" (set download_url=https://www.retrobat.ovh/repo/%arch%/legacy/lrcores)
)

"%buildtools_path%\wget" --continue --no-check-certificate --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 3 -P "%download_path%" !download_url!/!package_file! -q --show-progress

if %ERRORLEVEL% NEQ 0 (

	(set/A exit_code=%ERRORLEVEL%)
	call :exit_door
	goto :eof
)

if not exist "%download_path%\%package_file%" (

	(set/A exit_code=2)
	call :exit_door
	goto :eof
)

(echo %date% %time% [INFO] Get !package_name! from !download_url!)>> "!root_path!\%log_file%"

goto :eof

:: ---- EXTRACT PACKAGES ----

:extract

set task=extract
(echo %date% %time% [LABEL] :!task!)>> "!root_path!\%log_file%"

echo *************************************************************

if not exist "%extraction_path%\." md "%extraction_path%"
"%buildtools_path%\7za.exe" -y x "%download_path%\%package_file%" -aoa -o"%extraction_path%"

set true=1

if "!package_name!"=="retroarch" (

	set true=0
	
	if "%archx%"=="x86_64" (
				
		xcopy "%extraction_path%\RetroArch-Win64" "%destination_path%\" /s /e /v /y
		rmdir /s /q "%download_path%\extract\RetroArch-Win64"
	)
	
	if "%archx%"=="x86" (
	
		xcopy "%extraction_path%\RetroArch" "%destination_path%\" /s /e /v /y
		rmdir /s /q "%download_path%\extract\RetroArch"
	)	
) 

if "%true%"=="1" (

	xcopy "%extraction_path%" "%destination_path%\" /e /v /y
)
 
rmdir /s /q "%download_path%\extract"
if not "%package_file%" == "" del/Q "%download_path%\%package_file%"

(echo %date% %time% [INFO] Copy !package_name! to !destination_path!)>> "!root_path!\%log_file%"

goto :eof

:: ---- SET RETROBAT CONFIG ----

:set_config

set task=set_config
(echo %date% %time% [LABEL] :!task!)>> "!root_path!\%log_file%"

echo :: SETTING CONFIG FILES...

for /f "usebackq delims=" %%x in ("%system_path%\configgen\retrobat_tree.list") do (if not exist "!build_path!\%%x\." md "!build_path!\%%x")
for /f "usebackq delims=" %%x in ("%system_path%\configgen\emulators_names.list") do (if not exist "!build_path!\emulators\%%x\." md "!build_path!\emulators\%%x")
for /f "usebackq delims=" %%x in ("%system_path%\configgen\systems_names.list") do (if not exist "!build_path!\roms\%%x\." md "!build_path!\roms\%%x")
for /f "usebackq delims=" %%x in ("%system_path%\configgen\systems_names.list") do (if not exist "!build_path!\saves\%%x\." md "!build_path!\saves\%%x")

if exist "!build_path!\retrobat.exe" (

	"!build_path!\retrobat.exe" /NOF #GetConfigFiles
	"!build_path!\retrobat.exe" /NOF #SetEmulationStationSettings
	"!build_path!\retrobat.exe" /NOF #SetEmulatorsSettings
	
	if %ERRORLEVEL% NEQ 0 (
		(set/A exit_code=%ERRORLEVEL%)
		call :exit_door
		goto :eof
	)

) else (

	(set/A exit_code=2)
	call :exit_door
	goto :eof	
)

if exist "!build_path!\retrobat.ini" del/Q "!build_path!\retrobat.ini"

if exist "!system_path!\templates\emulationstation\video\*.mp4" xcopy /v /y "!system_path!\templates\emulationstation\video\*.mp4" "!build_path!\emulationstation\.emulationstation\video"
if exist "!system_path!\templates\emulationstation\music\*.ogg" xcopy /v /y "!system_path!\templates\emulationstation\music\*.ogg" "!build_path!\emulationstation\.emulationstation\music"

if not exist "!build_path!\system\version.info" (

	(set timestamp=%date:~6,4%%date:~3,2%%date:~0,2%)
	(set release_version=%retrobat_version%-!timestamp!-%branch%-%arch%)
	(echo|set/P=!release_version!)>> "!build_path!\system\version.info"	
)

echo build version is: !release_version!

(set/A exit_code=0)

goto :eof

:: ---- BUILD RETROBAT SETUP ----

:build_setup

set task=build_setup
(echo %date% %time% [LABEL] :!task!)>> "!root_path!\%log_file%"

echo :: BUILDING RETROBAT SETUP...

if "%release_version%"=="null" (

	if exist "!build_path!\system\version.info" (
		set/P release_version=<"!build_path!\system\version.info"
	) else (
		(set/A exit_code=2)
		goto :eof
	)
)

rem	"!buildtools_path!\..\nsis\makensis.exe" /V4 "!root_path!\setup.nsi"

"!buildtools_path!\..\nsis\makensis.exe" /V4 /DRELEASE_VERSION=%release_version%  "!root_path!\setup.nsi"

if %ERRORLEVEL% NEQ 0 (
	(set/A exit_code=%ERRORLEVEL%)
	goto :eof
	)
)

timeout/t 3 >nul
 
if exist "!root_path!\%name%-v%release_version%-setup.exe" (move /Y "!root_path!\%name%-v%release_version%-setup.exe" "!build_path!")

(echo %date% %time% [INFO] Build "%name%-v%release_version%-setup.exe" in "!build_path!")>> "!root_path!\%log_file%"

(set/A exit_code=%ERRORLEVEL%)
goto :eof

:: ---- CREATE ARCHIVE ----

:create_archive

set task=create_archive
(echo %date% %time% [LABEL] :!task!)>> "!root_path!\%log_file%"

echo :: CREATING ARCHIVE...

if "%release_version%"=="null" (

	if exist "!build_path!\system\version.info" (
		set/P release_version=<"!build_path!\system\version.info"
	) else (
		(set/A exit_code=2)
		goto :eof
	)
)

if not exist "!build_path!\%name%-v%release_version%.%archive_format%" (

	if exist "!build_path!\exclude.lst" del/Q "!build_path!\exclude.lst"
	(echo "exclude.lst")>> "!build_path!\exclude.lst"
	(echo "%name%-v%release_version%-setup.exe")>> "!build_path!\exclude.lst"

	!buildtools_path!\7za.exe a -t%archive_format% "!build_path!\%name%-v%release_version%.%archive_format%" "!build_path!\*" -xr@"!build_path!\exclude.lst" -mx=%archive_compression%
	(set/A exit_code=%ERRORLEVEL%)
)

if exist "!build_path!\%name%-v%release_version%.%archive_format%" (
	(echo %date% %time% [INFO] Created "%name%-v%release_version%.%archive_format%" in "!build_path!")
)

goto :eof

:: ---- BUTLER PUSH ----

:: need butler installed and dummy butler_push.txt

:butler_push

set task=butler_push
(echo %date% %time% [LABEL] :!task!)>> "!root_path!\%log_file%"

echo :: PUSHING BUTLER...

if "%release_version%"=="null" (

	if exist "!build_path!\system\version.info" (
		set/P release_version=<"!build_path!\system\version.info"
	) else (
		(set/A exit_code=2)
		goto :eof
	)
)

if exist "!build_path!\system\version.info" (
	butler push "!build_path!\%name%-v%release_version%-setup.exe" retrobatofficial/retrobat:%arch%-%branch% --userversion-file "!build_path!\system\version.info"
	butler push --ignore "!build_path!\%name%-v%release_version%-setup.exe" --ignore "!build_path!\*.log" --ignore "!build_path!\emulationstation\.emulationstation\es_settings.cfg" "!build_path!\" retrobatofficial/retrobat:%arch%-%branch% --userversion-file "!build_path!\system\version.info"
)

(set/A exit_code=%ERRORLEVEL%)
goto :eof

:: ---- BANNER ----

:banner

cls
echo +===========================================================+
echo  !name! builder script
echo +===========================================================+
goto :eof

:: ---- EXIT ----

:exit_door

echo :: EXITING...

(echo %date% %time% [END] !exit_code!)>> "!root_path!\build.log"
timeout /t 15>nul
exit !exit_code!