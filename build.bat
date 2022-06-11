@echo off
setlocal EnableDelayedExpansion

goto:rem
---------------------------------------
build.bat
---------------------------------------
This batch script is made to help download all the required software for RetroBat,
set the default configuration and build the setup.
---------------------------------------
:rem

set script_type=builder

:: ---- BUILDER OPTION ----

set retroarch_version=1.10.3
set zip_loglevel=0

set get_decorations=1
set get_default_theme=1
set get_emulationstation=1
set get_batocera_ports=1
set get_roms=0
set get_batgui=0
set get_retrobat=1
set get_mega_bezels=0
set get_bios=1
set get_retroarch=1
set get_lrcores=1
set get_wiimotegun=1

set deps_list=(git makensis 7za strip wget)
set clone_list=(bios decorations default_theme)
set download_list=(batgui emulationstation batocera_ports mega_bezels retroarch roms wiimotegun)

:: ---- GET STARTED ----

call :set_root
call :set_install
call :set_builder

:: ---- UI ----

call :banner

echo  This script can help you to download all the required 
echo  softwares and build the RetroBat Setup with the NullSoft 
echo  Scriptable Install System.
echo +===========================================================+
echo  - (D)ownload required softwares and build Setup
echo  - (B)uild Setup only
echo  - (Q)uit
echo +===========================================================+
choice /C DBQ /N /T 10 /D D /M "Please type your choice here: "

set user_choice=%ERRORLEVEL%

if %user_choice% EQU 1 (

	call :get_packages
	call :set_config
	call :build_setup
	pause
	exit
)

if %user_choice% EQU 2 (

	call :build_setup
	pause
	exit
)

if %user_choice% EQU 3 (

	(set exit_msg=Exit script by user's choice)
	(set exit_code=0)
	call :exit_door
	goto :eof
)

:: ---- LABELS ----

:: ---- SET ROOT PATH ----

:set_root

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

set tmp_infos_file=!root_path!\rb_infos.tmp
if exist "!tmp_infos_file!" del/Q "!tmp_infos_file!"

:: ---- CALL SHARED VARIABLES SCRIPT ----

if exist "!root_path!\system\scripts\shared-variables.cmd" (

	cd "!root_path!\system\scripts"
	call shared-variables.cmd	
	
) else (

	(set exit_code=1)
	call :exit_door
	goto :eof
)

:: ---- GET INFOS STORED IN TMP FILE ----

if exist "!tmp_infos_file!" (

	for /f "delims=" %%x in ('type "!tmp_infos_file!"') do (set "%%x") 
	del/Q "!tmp_infos_file!"
	
) else (

	(set exit_code=1)
	call :exit_door
	goto :eof
)

:: ---- WINDOW TITLE ----

title !name! Builder Script

goto :eof

:: ---- DEPENDENCIES CHECKING ----

:set_builder

call :banner

(set/A found_total=0)
(set package_file=retrobat-buildtools.zip)

if "%archx%"=="x86_64" (set "git_path=%ProgramFiles%\Git\cmd") else (set "git_path=%ProgramFiles(x86)%\Git\cmd")

for %%i in %deps_list% do (

	(set/A found_%%i=0)
	(set/A found_total=!found_total!+1)
	(set package_name=%%i)
	(set buildtools_path=!root_path!\..\retrobat-buildtools)
	
	if "!package_name!"=="git" (set buildtools_path=!git_path!)
	if "!package_name!"=="makensis" (set buildtools_path=!root_path!\..\retrobat-buildtools\nsis)
	
	if exist "!buildtools_path!\!package_name!.exe" (
	
		(set/A found_%%i=!found_%%i!+1)
		echo %%i: found
		
	) else (
	
		echo %%i: not found
	)

	if "!package_name!"=="git" if "!found_%%i!" EQU 0 (
	
		(set exit_code=1)
		call :exit_door
		goto :eof
	)
	
	(set/A found_total=!found_total!-!found_%%i!)
)
timeout /t 3 >nul

:: ---- DOWNLOAD AND EXTRACT BUILDTOOLS ----

if !found_total! NEQ 0 (

	if not exist "!root_path!\!package_file!" (
	
		echo Downloading !package_file!
		powershell -command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12 ; Invoke-WebRequest -Uri !buildtools_url!/!package_file! -OutFile "!root_path!\!package_file!""
		ping 127.0.0.1 -n 4
	)
)

if exist "!root_path!\!package_file!" (

	echo Extracting !package_file!
	powershell -command "Expand-Archive -Force -LiteralPath "!root_path!\!package_file!" -DestinationPath "!root_path!\..\.""
)

if exist "!root_path!\*.zip" del/Q "!root_path!\*.zip"
if exist "!root_path!\system\download\*.*" del/Q "!root_path!\system\download\*.*"

goto :eof

:: ---- GET PACKAGES ----

:get_packages

for %%i in %clone_list% do (

	if "!get_%%i!"=="1" (	
	
		(set package_name=%%i)
			
		if "!package_name!"=="bios" (set package_file=RetroBat-BIOS.git)
		if "!package_name!"=="decorations" (set package_file=batocera-bezel.git)
		if "!package_name!"=="default_theme" (set package_file=es-theme-carbon.git)
		
		echo ***********************************************************

		if exist "!%%i_path!" rmdir /s /q "!%%i_path!"			
		md "!%%i_path!"
		"!git_path!\git" clone --depth 1 !%%i_url!/!package_file! "!%%i_path!"
				
	)
)

for %%i in %download_list% do (

	if "!get_%%i!"=="1" (
		
		(set package_name=%%i)
		(set package_file=%%i.7z)
		(set download_url=!%%i_url!)
		(set destination_path=!%%i_path!)		

		if "!package_name!"=="emulationstation" (set package_file=EmulationStation-Win32.zip)
		if "!package_name!"=="batocera_ports" (set package_file=batocera-ports.zip)
		if "!package_name!"=="retroarch" (set package_file=RetroArch.7z)
		if "!package_name!"=="wiimotegun" (set package_file=WiimoteGun.zip)
		
		echo ***********************************************************
		
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
		
		echo ***********************************************************

		call :download
		call :extract	
	)
)

goto :eof

:: ---- DOWNLOAD PACKAGES ----

:download

if "!package_name!"=="4do" (

	set download_url=https://www.retrobat.ovh/repo/%arch%/legacy/lrcores
)

if "!package_name!"=="mame2016" (

	set download_url=https://www.retrobat.ovh/repo/%arch%/legacy/lrcores
)

if "!package_name!"=="px68k" (

	set download_url=https://www.retrobat.ovh/repo/%arch%/legacy/lrcores
)

"%buildtools_path%\wget" --no-check-certificate --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 3 -P "%download_path%" !download_url!/!package_file!

if %ERRORLEVEL% NEQ 0 (

	set exit_code=%ERRORLEVEL%
	call :exit_door
	goto :eof
)

if not exist "%download_path%\%package_file%" (

	set exit_code=1
	call :exit_door
	goto :eof
	
)
goto :eof

:: ---- EXTRACT PACKAGES ----

:extract

if not exist "%extraction_path%\." md "%extraction_path%"
"%buildtools_path%\7za.exe" -y x "%download_path%\%package_file%" -aoa -o"%extraction_path%"

set true=1

if "!package_name!"=="retroarch" (

	set true=0
	
	if exist "%retroarch_path%\*.dll" del/Q "%retroarch_path%\*.dll"
	
	if "%archx%"=="x86_64" (
				
		xcopy "%extraction_path%\RetroArch-Win64" "%destination_path%" /s /e /v /y
		rmdir /s /q "%download_path%\extract\RetroArch-Win64"
	)
	
	if "%archx%"=="x86" (
	
		xcopy "%extraction_path%\RetroArch" "%destination_path%" /s /e /v /y
		rmdir /s /q "%download_path%\extract\RetroArch"
	)
	
) 

if "%true%"=="1" (

	xcopy "%extraction_path%" "%destination_path%" /e /v /y
)
 
rmdir /s /q "%download_path%\extract"
del/Q "%download_path%\%package_file%"

goto :eof

:: ---- SET RETROBAT CONFIG ----

:set_config

!root_path!\retrobat.exe /NOF #MakeTree
!root_path!\retrobat.exe /NOF #GetConfigFiles
!root_path!\retrobat.exe /NOF #SetEmulationStationSettings
!root_path!\retrobat.exe /NOF #SetEmulatorsSettings

goto :eof

:: ---- BUILD RETROBAT SETUP ----

:build_setup

!buildtools_path!\nsis\makensis.exe /V4 "!root_path!\installer.nsi"

goto :eof

:: ---- BANNER ----

:banner

cls
echo +===========================================================+
echo  !name! Builder Script
echo +===========================================================+
goto :eof

:: ---- EXIT ----

:exit_door

if not "!exit_code!"=="0" if exist "%download_path%\*.*" (

	del/Q "%download_path%\*.*"
	
) else (

	for %%a in ("%download_path%\*") do if /i not "%%~nxa"=="emulationstation.zip" del/Q "%%a"
)

echo exit_code=!exit_code!
exit !exit_code!