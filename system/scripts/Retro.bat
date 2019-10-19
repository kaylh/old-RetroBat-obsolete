@Echo off
Title RetroBat Launcher
Goto:rem
:rem
If "%CD%"=="C:\Windows\system32" goto adminFail
If "%CD%"=="C:\Windows" goto adminFail
If "%CD%"=="C:\WINDOWS\system32" goto adminFail
If "%CD%"=="C:\WINDOWS" goto adminFail
Reg Query "HKLM\Hardware\Description\System\CentralProcessor\0" | find /i "x86" > NUL && set OS=32BIT || set OS=64BIT
If %OS%==32BIT goto archFail
If %OS%==64BIT goto checkInst

:checkInst
Set InitSetup=Setup.ini
If exist %InitSetup% (
	goto setVariables0
) else (
	goto error1
)

:setVariables0
:: Read variables from different source files
For /f "delims=" %%x in (%InitSetup%) do (set "%%x")
::Cd %CONFIG_PATH%\Profiles
::For /f "delims=" %%x in (Profile.ini) do (set "%%x")
Cd %CONFIG_PATH%
For /f "delims=" %%x in (emulationstation.cfg) do (set "%%x")
::For /f "delims=" %%x in (libretro-cores.cfg) do (set "%%x")
Cd %SetupDir%
Rem Call %SetupDir%\System\MainData\Scripts\ShowLogo.cmd                                           
Rem Echo                    v.%Version%                                          
Echo.               
Echo -- EmulationStation is running --
Echo.
Set RUN_DEMUL=%EMULATOR_PATH%\demul\demul.exe -run=dc -image=
Set RUN_DOLPHIN=%EMULATOR_PATH%\dolphin-emu\Dolphin.exe --batch --user="%DOLPHIN_CONFIG_DIR%" 
Set RUN_PCSX2=%EMULATOR_PATH%\pcsx2\pcsx2.exe --portable --cfgpath="%PCSX2_CONFIG_DIR%"
Set RUN_PPSSPP=%EMULATOR_PATH%\ppsspp\ppssppwindows64.exe
Set RUN_REDREAM=%EMULATOR_PATH%\redream\redream.exe
Set RUN_RETROARCH=%EMULATOR_PATH%\retroarch\retroarch.exe --config %RETROARCH_CONFIG_DIR%\retroarch.cfg --appendconfig %RETROARCH_OVERRIDE_DIR%\%RETROARCH_OVERRIDE_FILE%
Cd %ES_PATH%
Set HOME=%CD%
Set RUN_ES=emulationstation.exe --resolution %es_resolution_width% %es_resolution_height%
Set RUN_ES_W=emulationstation.exe --windowed --resolution %es_resolution_width% %es_resolution_height%
Goto checksplash

:checksplash
If "%play_splash_video%"=="yes" (
	goto splashcreen
) else (
	goto esRun
)

:splashcreen
If exist %SetupDir%\emulationstation\video\%splashscreen_file% (
	set RUN_ES=%RUN_ES% --video "video\%splashscreen_file%" --videoduration %splashscreen_length%
	set RUN_ES_W=%RUN_ES_W% --video "video\%splashscreen_file%" --videoduration %splashscreen_length%
	goto esRun
) else (
	goto esRun
)

:esRun
If not exist %ES_PATH%\emulationstation.exe goto esFail
If exist %ES_PATH%\menu.mp3 call %SCRIPTS_PATH%\BGMusic.cmd
If "%es_is_fullscreen%"=="yes" (
	%RUN_ES%
) else (
	%RUN_ES_W%
)
Goto cleanJunkFiles

:cleanJunkFiles
Cd %SetupDir%
Cd ..
If exist *.fs del *.fs
Goto exit

:adminFail
Echo Please run this script not as administrator.
Echo -----
Timeout /t 5 >nul
Goto exit

:esFail
Echo EmulationStation files are missing. Run %InitSetup% to download software.
Echo -----
Timeout /t 5 >nul
Goto exit

:error1
cls
Echo You must gather your party before venturing forth...
Echo ---
Timeout /t 5 >nul
Goto exit

:exit
exit