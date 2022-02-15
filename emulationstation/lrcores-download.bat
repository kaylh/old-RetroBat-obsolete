@echo off
setlocal EnableDelayedExpansion
cls

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

set debug=0

REM LIBRETRO CORES UPDATE
for /f "usebackq delims=" %%x in ("%retrobat_main_dir%\system\configgen\lrcores_names.list") do (
	set package_file=%%x_libretro.dll.zip
	if not exist "!emulator_dir!\retroarch\cores\%%x_libretro.dll" if not "%%x"=="retroarch" (
	REM DOWNLOAD
	set download_url=https://buildbot.libretro.com/nightly/windows/x86_64/latest/!package_file!
	call :download	
	REM EXTRACT
	set extraction_dir=!emulator_dir!\retroarch\cores
	call :extract	
	)
)

call :exit
goto :eof

:download
if "!debug!"=="1" (
	echo !download_url!
	echo !modules_dir!
	echo !download_dir!
	echo !download_url!
	pause
)
"!modules_dir!\rb_updater\wget" --no-check-certificate wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 3 -P "!download_dir!" !download_url! -q >nul	
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
	if not exist "!extraction_dir!\." md "!extraction_dir!"
	"!modules_dir!\rb_updater\7za.exe" -y x "!download_dir!\!package_file!" -aoa -o"!extraction_dir!"
) else (
	if not exist "!extraction_dir!\." md "!extraction_dir!" >nul
	"!modules_dir!\rb_updater\7za.exe" -y x "!download_dir!\!package_file!" -aoa -o"!extraction_dir!" >nul
)
if "!debug!"=="1" (
	del/Q "!download_dir!\!package_file!"
) else (
	del/Q "!download_dir!\!package_file!" >nul
)
if "!debug!"=="1" pause	
goto :eof

:exit
cls
echo update done !
rem timeout /t 1 >nul
exit 0

:error
cls
echo update failed !
rem timeout /t 1 >nul
exit 1

endlocal