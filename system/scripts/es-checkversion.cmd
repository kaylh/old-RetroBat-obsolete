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

set script_type=checkversion

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
	
    shift
    goto :loop_arg
)

:: ---- MODULES VERIFICATION ----

if not exist "!root_path!\system\modules\rb_updater\*.*" (

	set exit_msg=error: missing rb_updater modules!
	set/p exit_code=2
	call :exit_door
	goto :eof
)

:: ---- CALL SHARED VARIABLES SCRIPT ----

if exist "!root_path!\system\scripts\shared-variables.cmd" (

	cd "!root_path!\system\scripts"
	call shared-variables.cmd
	
) else (

	set exit_msg=error: missing rb_updater script!
	set/p exit_code=2
	call :exit_door
	goto :eof
)

:: ---- GET INFOS STORED IN TMP FILE ----

if exist "%tmp_infos_file%" (

	for /f "delims=" %%x in ('type "%tmp_infos_file%"') do (set "%%x")
	
) else (

	set exit_msg=error: missing rb_updater script!
	set/p exit_code=2
	call :exit_door
	goto :eof
)

:: ---- GET LATEST UPDATER SCRIPT ----

if not "%version_remote%"=="%version_local%" (

	if exist "!root_path!\emulationstation\es-update.cmd" del/Q "!root_path!\emulationstation\es-update.cmd"
	"!root_path!\system\modules\rb_updater\wget" --no-check-certificate wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 3 -P "%emulationstation_path%" %retrobat_url%/%version_local%/es-update.cmd -q
	echo %version_remote%
	exit 0
	
) else (

	set exit_msg=no update found!
	set exit_code=1
	call :exit_door
	goto :eof
)

:: ---- EXIT DOOR ----

:exit_door

cls
echo %exit_msg%
exit !exit_code!