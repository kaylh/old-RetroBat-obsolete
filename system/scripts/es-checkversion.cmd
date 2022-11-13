@echo off

goto:rem
---------------------------------------
es-checkversion.cmd
---------------------------------------
This Batch script is originally created for RetroBat and to be used by the Windows build of Batocera-EmulationStation.
It exists in conjunction with other scripts to form an integrated update system within the EmulationStation interface.
Its main task is to check the local version of RetroBat and compare it to the latest remote version available.
If a new version is detected, it will download the lastest es-update.cmd script and ES will use it to perform the update routine.
This script is supposed to be copied in the EmulationStation folder by the build.bat script in order to run properly.
---------------------------------------
:rem

setlocal EnableDelayedExpansion

:: ---- SCRIPT ARGUMENTS ----

set branch=stable

:loop_arg

if not "%1"=="" (

    if "%1"=="-branch" (
	
        set branch=%2
        shift
    )
	
    shift
    goto :loop_arg
)

:: ---- GET STARTED ----

set modules_list=(7za wget)

call :set_root
call :set_modules
call :set_install
call :exit_door
goto :eof

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

set "reg_path=HKCU\Software\RetroBat"
set "reg_key=LatestKnownInstallPath"

reg query "HKCU\Software\RetroBat" /v "%reg_key%" >nul 2>&1

if %ERRORLEVEL% EQU 0 (

	for /f "tokens=2* skip=2" %%a in ('reg query %reg_path% /v %reg_key%') do (
		
		set install_path=%%b
		set install_path=!install_path:~0,-1!
	)

) else (

	(set/A exit_code=1)
	(set exit_msg=install not found)
	call :exit_door
	goto :eof
)

if not "!root_path!" == "!install_path!\emulationstation" (

	(set/A exit_code=1)
	(set exit_msg=paths mismatch)
	call :exit_door
	goto :eof

) else (

	(set root_path=!install_path!)
	
)

goto :eof

:: ---- SET MODULES ----

:set_modules

set task=set_modules

(set/A found_total=0)

for %%i in %modules_list% do (

	(set/A found_%%i=0)
	(set/A found_total=!found_total!+1)
	(set package_name=%%i)
	(set modules_path=!root_path!\system\modules\rb_updater)
	
	if exist "!modules_path!\!package_name!.exe" ((set/A found_%%i=!found_%%i!+1))
	
	(set/A found_total=!found_total!-!found_%%i!)		
)

if !found_total! NEQ 0 (
	
	(set/A exit_code=2)
	(set exit_msg=missing updater modules)
	call :exit_door
	goto :eof
)

goto :eof

:: ---- SET INSTALL INFOS ----

:set_install

set task=set_install

:: ---- SET TMP FILE ----

set "tmp_infos_file=!root_path!\emulationstation\rb_infos.tmp"
if not "%tmp_infos_file%" == "" if exist "%tmp_infos_file%" del/Q "%tmp_infos_file%" >nul

:: ---- CALL SHARED VARIABLES SCRIPT ----

if exist "!root_path!\system\scripts\shared-variables.cmd" (

	cd "!root_path!\system\scripts"
	call shared-variables.cmd
	
) else (

	(set/A exit_code=2)
	(set exit_msg=missing updater script)
	call :exit_door
	goto :eof

)

:: ---- GET INFOS STORED IN TMP FILE ----

if exist "%tmp_infos_file%" (

	for /f "delims=" %%x in ('type "%tmp_infos_file%"') do (set "%%x")
	
) else (

	(set/A exit_code=2)
	(set exit_msg=missing updater script)
	call :exit_door
	goto :eof
)

:: ---- GET LATEST UPDATER SCRIPT ----

if not "%version_remote%"=="%version_local%" (

	if exist "!root_path!\emulationstation\es-update.cmd" del/Q "!root_path!\emulationstation\es-update.cmd" >nul
	"!root_path!\system\modules\rb_updater\wget" --no-check-certificate wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 3 -P "%emulationstation_path%" %installroot_url%/repo/%arch%/%branch%/%version_local%/es-update.cmd -q >nul
	echo %version_remote%
	exit 0
	
) else (

	echo no update found
	exit 1
)

:: ---- EXIT DOOR ----

:exit_door

cls
echo %exit_msg%
exit !exit_code!