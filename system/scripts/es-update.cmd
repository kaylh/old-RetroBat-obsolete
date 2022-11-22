@echo off

goto:rem
---------------------------------------
es-update.cmd
---------------------------------------
This Batch script is originally created for RetroBat and to be used by the Windows build of Batocera-EmulationStation.
It exists in conjunction with other scripts to form an integrated update system within the EmulationStation interface.
---------------------------------------
:rem

setlocal EnableDelayedExpansion
cls
echo preparing update... ^>^>^> 0%%

set script_type=updater

:: ---- DEBUG SWITCHES ----

set enable_download=1
set enable_extraction=1
set download_retry=3
set archive_format=zip
set log_file=es-update.log
set enable_log=1

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

:: ---- GET STARTED ----

set/A progress_percent=0

set folder_list=(bios decorations emulators library roms saves screenshots system)
set file_list=(exe dat txt)
set modules_list=(7za wget)

if "%extract_pkg%"=="es" (
	call :set_root
	call :set_modules
	call :set_install
	
	set package_file=!name!-v!version_remote!.!archive_format!
	
	call :extract_es
	call :exit_door
	goto :eof
)

set/A task_computing=1
if %task_computing% EQU 1 (

	if "%enable_download%" == "1" (call :download)
	call :check_hash
	if "%enable_extraction%" == "1" (call :extract)
	call :files_copy
)

if !task_total! GTR 0 ((set/A task_computing=0))

if %task_computing% EQU 0 (

	call :set_root
	call :set_modules
	call :set_install

	set package_file=!name!-v!version_remote!.!archive_format!
	set download_url=!archive_url!

	if "%enable_download%" == "1" (call :download)
	call :check_hash
	if "%enable_extraction%" == "1" (call :extract)
	call :files_copy
	call :exit_door
	goto :eof
)

if %task_computing% GTR 0 (

	(set exit_msg=fatal error)
	(set/A exit_code=4)
	call :exit_door
	goto :eof

)

:: ---- LABELS ----

:: ---- DOWNLOAD ----

:download

if %task_computing% EQU 1 (
	(set/A task_total+=1)
	goto :eof
)

set task=download
if %enable_log% EQU 1 ((echo %date% %time% [LABEL] :!task!)>> "!root_path!\emulationstation\%log_file%")

(set progress_text=downloading update)
cls
echo !progress_text!... ^>^>^> !progress_percent!%%

if not exist "!download_path!\." md "!download_path!"
	
"%system_path%\modules\rb_updater\wget" --continue --no-check-certificate --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t %download_retry% -P "%download_path%" %download_url%/%package_file% -q >nul
"%system_path%\modules\rb_updater\wget" --continue --no-check-certificate --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t %download_retry% -P "!download_path!" %download_url%/%package_file%.sha256.txt -q >nul

if not exist "!download_path!\!package_file!.sha256.txt" (

	(set/A exit_code=2)
	(set exit_msg=hash file not found)
	call :exit_door
	goto :eof	
)

if not exist "!download_path!\!package_file!" (

	(set/A exit_code=2)
	(set exit_msg=update archive not found)
	call :exit_door
	goto :eof	
)

(set/A task_count+=1)
call :progress

goto :eof

:: ---- CHECK HASH ----

:check_hash

if %task_computing% EQU 1 (
	(set/A task_total+=1)
	goto :eof
)

set task=check_hash
if %enable_log% EQU 1 ((echo %date% %time% [LABEL] :!task!)>> "!root_path!\emulationstation\%log_file%")

set trusted_hash=0
set file_hash=0
(set progress_text=verifying update)
cls
echo !progress_text!... ^>^>^> !progress_percent!%%

if exist "!download_path!\!package_file!.sha256.txt" (
	(set/P trusted_hash=<"!download_path!\!package_file!.sha256.txt")
	if %enable_log% EQU 1 ((echo %date% %time% [INFO] trusted_hash: !trusted_hash!)>> "!root_path!\emulationstation\%log_file%")
)

if not "%trusted_hash%" == "0" (

	if exist "!download_path!\!package_file!" (

		set "firstline=1"
		for /f "skip=1 delims=" %%i in ('certutil -hashfile "!download_path!\!package_file!" SHA256') do (
			if [!firstline!]==[1] (
				(set file_hash=%%i)
				if %enable_log% EQU 1 ((echo %date% %time% [INFO] file_hash: !file_hash!)>> "!root_path!\emulationstation\%log_file%")
				set "firstline=0"
			)
		)
	)
)

if not "%trusted_hash%" == "%file_hash%" (

	(set/A exit_code=2)
	(set exit_msg=corrupted update archive)
	call :exit_door
	goto :eof
)

(set/A task_count+=1)
call :progress

goto :eof

:: ---- EXTRACTION ----

:extract

if %task_computing% EQU 1 (
	for %%i in %folder_list% do (
	
		(set/A task_total+=1)
	)
	
	for %%i in %file_list% do (
	
		(set/A task_total+=1)
	)
	
	goto :eof
)

set task=extract
if %enable_log% EQU 1 ((echo %date% %time% [LABEL] :!task!)>> "!root_path!\emulationstation\%log_file%")

if exist "!download_path!\!package_file!" (

	(set progress_text=extracting update)
	cls
	echo !progress_text!... ^>^>^> !progress_percent!%%
	set destination_path=!root_path!
	if not exist "!extraction_path!\." md "!extraction_path!"
	
	if "!version_local!" == "4.0.2-20210710" (
	
		if exist "%emulators_path%\pcsx2\pcsx2.exe" ren "%emulators_path%\pcsx2" pcsx2-16 >nul
		if exist "%root_path%\BatGui.exe" del/Q "%root_path%\BatGui.exe" >nul
		if exist "%system_path%\modules\rb_gui\*.dll" del/Q "%system_path%\modules\rb_gui\*.*" >nul
		if exist "%system_path%\modules\rb_gui\images\*.png" del/Q "%system_path%\modules\rb_gui\images\*.png" >nul
	)
	
	if "!version_local!" == "4.0.2-20210710-testing" (
	
		if exist "%emulators_path%\pcsx2\pcsx2.exe" ren "%emulators_path%\pcsx2" pcsx2-16 >nul
		if exist "%root_path%\BatGui.exe" del/Q "%root_path%\BatGui.exe" >nul
		if exist "%system_path%\modules\rb_gui\*.dll" del/Q "%system_path%\modules\rb_gui\*.*" >nul
		if exist "%system_path%\modules\rb_gui\images\*.png" del/Q "%system_path%\modules\rb_gui\images\*.png" >nul
	)
	
	for %%i in %folder_list% do (
	
		"%system_path%\modules\rb_updater\7za.exe" -y x "!download_path!\!package_file!" -aoa -o"!extraction_path!" "%%i\*" >nul
		if %enable_log% EQU 1 ((echo %date% %time% [INFO] !label! "%%i" from "!download_path!\!package_file!" to "!extraction_path!")>> "!root_path!\emulationstation\%log_file%")		
		(set/A task_count+=1)
		call :progress
	)
	
	for %%i in %file_list% do (
	
		"%system_path%\modules\rb_updater\7za.exe" -y x "!download_path!\!package_file!" -aoa -o"!extraction_path!" "*.%%i" >nul
		if %enable_log% EQU 1 ((echo %date% %time% [INFO] !label! "*.%%i" from "!download_path!\!package_file!" to "!extraction_path!")>> "!root_path!\emulationstation\%log_file%")	
		(set/A task_count+=1)
		call :progress
	)
)

(set/A exit_code=2)
goto :eof

:: ---- FILES COPY ----

:files_copy

if %task_computing% EQU 1 (
	for %%i in %folder_list% do (
	
		(set/A task_total+=1)
	)
	
	for %%i in %file_list% do (
	
		(set/A task_total+=1)
	)
	
	goto :eof	
)

set task=files_copy
if %enable_log% EQU 1 ((echo %date% %time% [LABEL] :!task!)>> "!root_path!\emulationstation\%log_file%")

if not exist "!system_path!\configgen\exclude_emulators_files.lst" (
	(set/A exit_code=2)
	(set exit_msg=updater script is missing)
	call :exit_door
	goto :eof
)

(set progress_text=updating files)
cls
echo !progress_text!... ^>^>^> !progress_percent!%%

if exist "%CD%\exclude.txt" del/Q "%CD%\exclude.txt" >nul

copy "%system_path%\configgen\exclude_emulators_files.lst" "%CD%\exclude.txt" /Y >nul

for %%i in %folder_list% do (
	
	if not exist "%extraction_path%\%%i\." md "%extraction_path%\%%i" >nul
	if exist "%extraction_path%\%%i\." (
	
		if "%%i" == "emulators" (
		
			xcopy "%extraction_path%\%%i" "!root_path!\%%i" /e /v /y /I /exclude:exclude.txt >nul
			if %ERRORLEVEL% NEQ 0 (
				set/A exit_code=%ERRORLEVEL%
				call :exit_door
				goto :eof
			)
			if %enable_log% EQU 1 ((echo %date% %time% [INFO] !task! from "%extraction_path%\%%i" to "!root_path!\%%i")>> "!root_path!\emulationstation\%log_file%")
			
		) else (
		
			xcopy "%extraction_path%\%%i" "!root_path!\%%i" /e /v /y /I >nul
			if %ERRORLEVEL% NEQ 0 (
				set/A exit_code=%ERRORLEVEL%
				call :exit_door
				goto :eof
			)
			if %enable_log% EQU 1 ((echo %date% %time% [INFO] !task! from "%extraction_path%\%%i" to "!root_path!\%%i")>> "!root_path!\emulationstation\%log_file%")
		)
	)
	
	for /f "usebackq delims=" %%x in ("%system_path%\configgen\exclude_emulators_files.lst") do (
	
		if not exist "%emulators_path%\%%x" copy "%extraction_path%\emulators\%%x" "%emulators_path%\%%x" /Y >nul
	)
	
	(set/A task_count+=1)
	call :progress
)

for %%i in %file_list% do (

	if exist "%extraction_path%\*.%%i" (
	
		xcopy "%extraction_path%\*.%%i" "!root_path!" /y >nul
		if %enable_log% EQU 1 ((echo %date% %time% [INFO] !task! "%extraction_path%\*.%%i" to "!root_path!")>> "!root_path!\emulationstation\%log_file%")
			
	)
	
	(set/A task_count+=1)
	call :progress
)

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

	(set/A exit_code=3)
	(set exit_msg=can't found install path)
	call :exit_door
	goto :eof
)

if %enable_log% EQU 1 (

	if not "%extract_pkg%" == "es" if not "%log_file%" == "" if exist "%CD%\%log_file%" del/Q "%CD%\%log_file%" >nul
	(echo %date% %time% [START] Run: !current_file!)>> "%CD%\%log_file%"
	(echo %date% %time% [LABEL] :!task!)>> "%CD%\%log_file%"
	(echo %date% %time% [INFO] Current Path: "!current_path!")>> "%CD%\%log_file%"
	(echo %date% %time% [INFO] Install Path: "!install_path!")>> "%CD%\%log_file%"
)

if not "!root_path!" == "!install_path!\emulationstation" (

	(set/A exit_code=3)
	(set exit_msg=install path mismatch)
	call :exit_door
	goto :eof

) else (

	(set root_path=!install_path!)
	if %enable_log% EQU 1 ((echo %date% %time% [INFO] Root Path: "!root_path!")>> "!root_path!\emulationstation\%log_file%")
	
)

goto :eof

:: ---- SET MODULES ----

:set_modules

set task=set_modules
if %enable_log% EQU 1 ((echo %date% %time% [LABEL] :!task!)>> "!root_path!\emulationstation\%log_file%")

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
	(set exit_msg=updater modules are missing)
	call :exit_door
	goto :eof
)

goto :eof

:: ---- SET INSTALL INFOS ----

:set_install

set task=set_install
if %enable_log% EQU 1 ((echo %date% %time% [LABEL] :!task!)>> "!root_path!\emulationstation\%log_file%")

:: ---- SET TMP FILE ----

set "tmp_infos_file=!root_path!\emulationstation\rb_infos.tmp"
if not "%tmp_infos_file%" == "" if exist "%tmp_infos_file%" del/Q "%tmp_infos_file%" >nul

:: ---- CALL SHARED VARIABLES SCRIPT ----

if exist "!root_path!\system\scripts\shared-variables.cmd" (

	cd "!root_path!\system\scripts"
	call shared-variables.cmd
	
) else (

	(set/A exit_code=2)
	(set exit_msg=updater script is missing)
	call :exit_door
	goto :eof

)

:: ---- GET INFOS STORED IN TMP FILE ----

if exist "%tmp_infos_file%" (

	for /f "delims=" %%x in ('type "%tmp_infos_file%"') do (set "%%x")
	
) else (

	(set/A exit_code=2)
	(set exit_msg=updater script is missing)
	call :exit_door
	goto :eof
)

if %enable_log% EQU 1 (
	(echo %date% %time% [INFO] Current Version: %name%-%version_local%)>> "!root_path!\emulationstation\%log_file%"
	(echo %date% %time% [INFO] Available Version: %name%-%version_remote%)>> "!root_path!\emulationstation\%log_file%"
	(echo %date% %time% [INFO] Download Path: "!download_path!")>> "!root_path!\emulationstation\%log_file%"
)

:: ---- WINDOW TITLE ----

title %name% updater script

:: ---- KILL PROCESS ----

:: Kill the process listed in kill_process.list if they are running

if exist "!root_path!\retrobat.exe" "!root_path!\retrobat.exe" #killProcess

goto :eof

:: ---- CALCULATE PERCENTAGE TO OUTPUT ----

:progress

cls
set/A progress_percent=100*!task_count!/task_total
echo !progress_text!... ^>^>^> !progress_percent!%%

goto :eof

:: ---- EXTRACT ES ----

:extract_es

set task=extract_es
if %enable_log% EQU 1 ((echo %date% %time% [LABEL] :!task!)>> "!root_path!\emulationstation\%log_file%")

if exist "%system_path%\scripts\exclude.txt" del/Q "%system_path%\scripts\exclude.txt" >nul

if not exist "%system_path%\configgen\exclude_emulationstation_files.lst" (
	(set/A exit_code=2)
	(set exit_msg=updater script is missing)
	call :exit_door
	goto :eof
)

copy "%system_path%\configgen\exclude_emulationstation_files.lst" "%system_path%\scripts\exclude.txt" /Y >nul

if exist "%download_path%\%package_file%" (

	if not exist "!extraction_path!\emulationstation\." md "!extraction_path!\emulationstation" >nul
	"%system_path%\modules\rb_updater\7za.exe" -y x "!download_path!\!package_file!" -aoa -o"!extraction_path!" "emulationstation\*" >nul
	set/A exit_code=%ERRORLEVEL%
	if !exit_code! NEQ 0 (
		(set exit_msg=failed to extract files)
		call :exit_door
		goto :eof
	)
	if %enable_log% EQU 1 ((echo %date% %time% [INFO] !task! from "%download_path%\%package_file%" to "!extraction_path!\emulationstation")>> "%root_path%\emulationstation\%log_file%")

	xcopy "%extraction_path%\emulationstation" "!root_path!\emulationstation" /e /v /y /I /exclude:exclude.txt >nul
	set/A exit_code=%ERRORLEVEL%
	if !exit_code! NEQ 0 (
		(set exit_msg=failed to copy files)
		call :exit_door
		goto :eof
	)
	if %enable_log% EQU 1 ((echo %date% %time% [INFO] !task! from "%extraction_path%\emulationstation" to "%root_path%\emulationstation")>> "%root_path%\emulationstation\%log_file%")

	if !exit_code! EQU 0 (
	
		(set exit_msg=update complete!)
		if exist "!download_path!\!package_file!" del/Q "!download_path!\!package_file!" >nul
		if exist "!download_path!\!package_file!.sha256.txt" del/Q "!download_path!\!package_file!.sha256.txt" >nul
		if exist "!extraction_path!\" rd /S /Q "!extraction_path!" >nul
		if exist "!system_path!\scripts\exclude.txt" del/Q "!system_path!\scripts\exclude.txt" >nul
	)
)

goto :eof

:: ---- EXIT ----

:exit_door

(echo %exit_msg%)

if %progress_percent% EQU 100 (

	if exist "%system_path%\scripts\exclude.txt" del/Q "%system_path%\scripts\exclude.txt" >nul
	if exist "%system_path%\scripts\exclude.txt" del/Q "%system_path%\scripts\exclude.txt" >nul
	if "!version_local!" == "4.0.2-20210710-testing" (
		if exist "%root_path%\retrobat.ini" del/Q "%root_path%\retrobat.ini" >nul
	)
	if "!version_local!" == "4.0.2-20210710" (
		if exist "%root_path%\retrobat.ini" del/Q "%root_path%\retrobat.ini" >nul
	)
	(set/A exit_code=0)
	(set exit_msg=update done!)
	cls
	(echo !exit_msg!)
)

if %enable_log% EQU 1 (

	if "!task!" == "set_root" if !exit_code! EQU 1 (
	
		(echo %date% %time% [INFO] !exit_msg!)>> "%CD%\%log_file%"
		(echo %date% %time% [END] !exit_code!)>> "%CD%\%log_file%"
	
	) 
	
	if not "!task!" == "set_root" (
	
		(echo %date% %time% [INFO] !exit_msg!)>> "!root_path!\emulationstation\%log_file%"
		(echo %date% %time% [END] !exit_code!)>> "!root_path!\emulationstation\%log_file%"	
	)
)

exit !exit_code!