@echo off

REM PATH
set current_file=%~nx0
set current_drive="%cd:~0,2%"
set current_dir="%cd:~3%"
set current_drive=%current_drive:"=%
set current_dir=%current_dir:"=%
rem set "current_dir=%current_dir%"
set current_path=%current_drive%\%current_dir%
set update_dir=%current_path%
set modules_dir=%current_path%\..\system\modules
set download_dir=%current_path%\..\system\download
REM END PATH

set remote_version_file=remote_version.info
set local_version_file=version.info
set remote_version_filepath=%modules_dir%\rb_updater
set local_version_filepath=%current_path%

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

if not exist "%modules_dir%\rb_updater\7za.exe" goto deps_error
if not exist "%modules_dir%\rb_updater\wget.exe" goto deps_error

:check_remote_version
if exist "%remote_version_filepath%\%remote_version_file%" del/Q "%remote_version_filepath%\%remote_version_file%" 

if not exist "%remote_version_filepath%\%remote_version_file%" "%modules_dir%\rb_updater\wget" --no-check-certificate wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 3 -P "%remote_version_filepath%" https://www.retrobat.ovh/repo/win64/%branch%/%remote_version_file% -q 
rem timeout /t 1 >nul

if not exist "%remote_version_filepath%\%remote_version_file%" (
	call :deps_error
	goto :eof
)

if not exist "%local_version_filepath%\%local_version_file%" (
	call :deps_error
	goto :eof
)
	
cd "%remote_version_filepath%"
set/p rb_remote_version=<%remote_version_file%
cd "%current_path%"

cd "%local_version_filepath%"
set/p rb_local_version=<%local_version_file%
cd "%current_path%"

if not "%rb_remote_version%"=="%rb_local_version%" (
	call :fetch_updater
	goto :eof
) else (
	call :no_update
	goto :eof
)

:fetch_updater
if exist "%current_path%\es-update.cmd" del/Q "%current_path%\es-update.cmd" 
"%modules_dir%\rb_updater\wget" --no-check-certificate wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 3 -P "%current_path%" https://www.retrobat.ovh/repo/win64/%branch%/es-update.cmd -q 
echo %rb_remote_version%
rem timeout /t 1 >nul
exit 0

:no_update
echo No update found !
exit 1

:deps_error
echo Missing dependencies !
exit 2