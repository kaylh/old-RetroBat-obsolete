@echo off
REM -- SET PROGRAM NAME IN WINDOW TITLE --
title retrobat build script

:set_variables

REM -- RUNNING RETRO.BAT FOLLOWED BY A NAME IN COMMAND LINE WILL CREATE A FOLDER WITH THIS NAME INSTEAD OF DEFALT ONE --

if not "%1"=="" (
	set "clone_folder=%1"
) else (
	set "clone_folder=retrobat-git"
)

REM -- SET VARIABLES --

set retroarch_version=stable/1.9.0
set "current_file=%~nx0"
set current_drive=%cd:~0,2%
set "current_dir=%cd:~3%"
set current_dir=%current_dir:"=%
set "current_dir=%current_dir%"
set "current_path=%current_drive%\%current_dir%"
set build_dir=%current_path%
set msys_dir=C:\msys64
set bin_dir=%msys_dir%\usr\bin
set emulationstation_url="https://github.com/fabricecaruso/batocera-emulationstation/releases/download/continuous-master/EmulationStation-Win32.zip"
set theme_url="https://github.com/fabricecaruso/es-theme-carbon/archive/master.zip"
set launcher_url="https://github.com/fabricecaruso/batocera-ports/releases/download/continuous/batocera-ports.zip"
set retroarch_url="https://buildbot.libretro.com/%retroarch_version%/windows/x86_64/RetroArch.7z"
set retrobat_branch=master
set retrobat_git="https://github.com/kaylh/RetroBat.git"
set decorations_git="https://github.com/kaylh/batocera-bezel.git"
set theme_branch=master
set theme_git="https://github.com/fabricecaruso/es-theme-carbon.git"
set "buildtools_dir=%current_path%\..\retrobat-buildtools"
set installer_source=installer.nsi
set "installer_dir=%current_path%\installer"
set sevenzip_loglevel=0

REM -- CHECK IF CURRENT PATH CONTAINS SPACES --

if not "%CD%"=="%cd: =%" (
	echo.
    echo Current directory contains spaces in its path.
    echo You need to rename the directory without spaces to launch this script.
    echo.
    timeout /t 5 >nul
    goto exit
)

timeout /t 1 >nul

echo *******************************
echo  Running RetroBat Build Script
echo *******************************

timeout /t 1 >nul

set git_bin=0
set nsis_bin=0
set sevenzip_bin=0
set strip_bin=0
set wget_bin=0

echo Checking dependancies...
echo.

timeout /t 1 >nul

REM -- CHECK IF GIT IS PRESENT --

if exist "%ProgramFiles%\Git\cmd\git.exe" (
	set/A git_bin=git_bin+1
	set "git_path=%ProgramFiles%\Git\cmd"
)
if exist "%ProgramFiles(x86)%\Git\cmd\git.exe" (
	set/A git_bin=git_bin+1
	set "git_path=%ProgramFiles(x86)%\Git\cmd"
)
if exist "%buildtools_dir%\Git\cmd\git.exe" (
	set/A git_bin=git_bin+1
	set "git_path=%buildtools_dir%\Git\cmd"
)

if %git_bin% EQU 0 (
	echo [     Git    ] : NOT FOUND!
) else (
	echo [     Git    ] : FOUND!
	echo location: "%git_path%"
)

timeout /t 1 >nul

REM -- CHECK IF 7ZIP IS PRESENT --

if exist "%ProgramFiles%\7-Zip\7zFM.exe" (
	set/A sevenzip_bin=sevenzip_bin+1
	set "sevenzip_path=%ProgramFiles%\7-Zip"
	set sevenzip_exe=7zG.exe
)
if exist "%ProgramFiles(x86)%\7-Zip\7zFM.exe" (
	set/A sevenzip_bin=sevenzip_bin+1
	set "sevenzip_path=%ProgramFiles(x86)%\7-Zip"
	set sevenzip_exe=7zG.exe
)
if exist "%buildtools_dir%\7za.exe" (
	set/A sevenzip_bin=sevenzip_bin+1
	set "sevenzip_path=%buildtools_dir%"
	set sevenzip_exe=7za.exe
)

if %sevenzip_bin% EQU 0 (
	echo [    7-Zip   ] : NOT FOUND!
) else (
	echo [    7-Zip   ] : FOUND!
	echo location: "%sevenzip_path%"
)

timeout /t 1 >nul

REM -- CHECK IF STRIP IS PRESENT --

if exist "%bin_dir%\strip.exe" (
	set/A strip_bin=strip_bin+1
	set "strip_path=%bin_dir%"
)
if exist "%buildtools_dir%\strip.exe" (
	set/A strip_bin=strip_bin+1
	set "strip_path=%buildtools_dir%"
)

if %strip_bin% EQU 0 (
	echo [    Strip   ] : NOT FOUND!
) else (
	echo [    Strip   ] : FOUND!
	echo location: "%strip_path%"
)

timeout /t 1 >nul

REM -- CHECK IF WGET IS PRESENT --

if exist "%bin_dir%\wget.exe" (
	set/A wget_bin=wget_bin+1
	set "wget_path=%bin_dir%"
)
if exist "%buildtools_dir%\wget.exe" (
	set/A wget_bin=wget_bin+1
	set "wget_path=%buildtools_dir%"
)

if %wget_bin% EQU 0 (
	echo [    WGet    ] : NOT FOUND!
) else (
	echo [    WGet    ] : FOUND!
	echo location: "%wget_path%"
)

timeout /t 1 >nul

REM -- CHECK IF MAKENSIS IS PRESENT --

if exist "%ProgramFiles(x86)%\NSIS\makensis.exe" (
	set/A nsis_bin=nsis_bin+1
	set "nsis_path=%ProgramFiles(x86)%\NSIS"
)
if exist "%buildtools_dir%\nsis\makensis.exe" (
	set/A nsis_bin=nsis_bin+1
	set "nsis_path=%buildtools_dir%\nsis"
)

if %nsis_bin% EQU 0 (
	echo [   MAKENSIS ] : NOT FOUND!
) else (
	echo [   MAKENSIS ] : FOUND!
	echo location: "%nsis_path%"
)

timeout /t 1 >nul

REM -- IF DEPENDANCIES NOT EXIST THEN THIS WILL DOWNLOAD AND EXTRACT IT --

if %nsis_bin% EQU 0 if %wget_bin% EQU 0 if %strip_bin% EQU 0 (
	echo.
	echo :: DOWNLOADING RETROBAT BUILDTOOLS ::
	echo.
	powershell -command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12 ; Invoke-WebRequest -Uri "https://www.retrobat.ovh/repo/tools/retrobat-buildtools.zip" -OutFile "%current_path%\retrobat-buildtools.zip""
	ping 127.0.0.1 -n 4 >nul
	timeout /t 1 >nul
	cls
	echo :: EXTRACTING RETROBAT BUILDTOOLS ::
	echo.
rem %sevenzip_path%"\7zg.exe -y x "%current_path%\nsis.zip" -o"%current_path%\tools\nsis" -aoa>nul
	powershell -command "Expand-Archive -Force -LiteralPath "%current_path%\retrobat-buildtools.zip" -DestinationPath "%current_path%""
	echo Done.
	timeout /t 1 >nul
	goto set_variables
)

if exist "%current_path%\*.zip" del/q "%current_path%\*.zip"
if exist "%current_path%\system\download\*.*" del/q "%current_path%\system\download\*.*"

timeout /t 1 >nul
goto menu_welcome

:menu_welcome

REM -- DISPLAY WELCOME SCREEN WITH BUILD INFOS --

cls
echo +===========================================================+
echo  RETROBAT BUILD SCRIPT
echo +===========================================================+
echo  This script will help you to build RetroBat from its github
echo  repository.  It will also download EmulationStation, 
echo  RetroArch and almost all compatible emulators.
echo  Then it will build the RetroBat installer with the
echo  NullSoft Scriptable Install System.
echo.
echo  Once the work is done, you will not necessary get a full  
echo  working RetroBat, depending mostly on the cloned branch.
echo  You can edit retro.bat and modify as your needs.
echo +===========================================================+
echo  (1) -- Download (get required files)
echo.
echo  (2) -- Installer compilation (files exist or download first)
echo.
echo  (Q) -- Quit this script (abort)
echo +===========================================================+
set/p user_answer="- Type your choice here (1,2,Q): "
if "%user_answer%"=="1" goto clone_retrobat
if "%user_answer%"=="2" goto clean
if "%user_answer%"=="Q" goto exit
if "%user_answer%"=="q" goto exit

:clone_retrobat

cls
if %git_bin% EQU 0 (
	cls
	echo ERROR: Git for Windows is not installed. Aborting...
	timeout /t 3 >nul
	goto exit
)
timeout /t 1 >nul

echo.
echo :: CLONING RETROBAT REPOSITORY ::
echo.

if exist "%current_path%\" (
	cd "%current_path%"
	git pull origin
	cd "%current_path%"
) else (
	git clone --depth 1 --branch "%retrobat_branch%" %retrobat_git% "%current_path%"
)

goto clone_decorations

:clone_decorations

echo.
echo :: CLONING DECORATIONS REPOSITORY ::
echo.

if exist "%current_path%\system\decorations\" (
	cd "%current_path%\system\decorations"
	git pull origin
	cd "%current_path%"
) else (
	git clone --depth 1 %decorations_git% "%current_path%\system\decorations"
)

goto download

:download

echo Creating RetroBat's folders...
echo %current_path%
"%current_path%"\retrobat.exe /NOF #MakeTree

timeout /t 2 >nul
echo.
echo :: DOWNLOADING EMULATIONSTATION ::
echo.
cd "%wget_path%"
wget --no-check-certificate -P "%current_path%\system\download" %emulationstation_url% -q --show-progress
cd "%current_path%"
rem powershell -command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12 ; Invoke-WebRequest -Uri %emulationstation_url% -OutFile "%current_path%\system\download\emulationstation.zip""
ping 127.0.0.1 -n 4 >nul
timeout /t 1 >nul
echo.
echo :: DOWNLOADING EMULATORLAUNCHER ::
echo.
cd "%wget_path%"
wget --no-check-certificate -P "%current_path%\system\download" %launcher_url% -q --show-progress
wget --no-check-certificate -P "%current_path%\emulationstation" https://github.com/fabricecaruso/batocera-ports/raw/master/ILMerge.exe -q --show-progress
wget --no-check-certificate -P "%current_path%\emulationstation" https://github.com/fabricecaruso/batocera-ports/raw/master/SharpDX.DirectInput.dll -q --show-progress
wget --no-check-certificate -P "%current_path%\emulationstation" https://github.com/fabricecaruso/batocera-ports/raw/master/SharpDX.dll -q --show-progress
wget --no-check-certificate -P "%current_path%\emulationstation" https://github.com/fabricecaruso/batocera-ports/raw/master/SharpDX.XInput.dll -q --show-progress
cd "%current_path%"
rem powershell -command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12 ; Invoke-WebRequest -Uri %launcher_url% -OutFile "%current_path%\system\download\batocera-ports.zip""
rem powershell -command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12 ; Invoke-WebRequest -Uri "https://github.com/fabricecaruso/batocera-ports/raw/master/ILMerge.exe" -OutFile "%current_path%\emulationstation\ILMerge.exe""
rem powershell -command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12 ; Invoke-WebRequest -Uri "https://github.com/fabricecaruso/batocera-ports/raw/master/SharpDX.DirectInput.dll" -OutFile "%current_path%\emulationstation\SharpDX.DirectInput.dll""
rem powershell -command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12 ; Invoke-WebRequest -Uri "https://github.com/fabricecaruso/batocera-ports/raw/master/SharpDX.dll" -OutFile "%current_path%\emulationstation\SharpDX.dll""
rem powershell -command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12 ; Invoke-WebRequest -Uri "https://github.com/fabricecaruso/batocera-ports/raw/master/SharpDX.XInput.dll" -OutFile "%current_path%\emulationstation\SharpDX.XInput.dll""
timeout /t 1 >nul

if exist "%current_path%\system\download\retroarch.7z" goto extract
echo.
echo :: DOWNLOADING RETROARCH ::
echo.
cd "%wget_path%"
wget --no-check-certificate -P "%current_path%\system\download" %retroarch_url% -q --show-progress
cd "%current_path%"
rem powershell -command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12 ; Invoke-WebRequest -Uri %retroarch_url% -OutFile "%current_path%\system\download\retroarch.7z""
timeout /t 1 >nul


REM Libretro cores download loop

::::2048_libretro.dll
::::81_libretro.dll
::::atari800_libretro.dll
::::blastem_libretro.dll
::::bluemsx_libretro.dll
::::bsnes_libretro.dll
::::bsnes_mercury_accuracy_libretro.dll
::::bsnes_mercury_balanced_libretro.dll
::::bsnes_mercury_performance_libretro.dll
::::cap32_libretro.dll
::::citra_canary_libretro.dll
::::citra_libretro.dll
::::craft_libretro.dll
::::crocods_libretro.dll
::::desmume2015_libretro.dll
::::desmume_libretro.dll
::::dosbox_core_libretro.dll
::::duckstation_libretro.dll
::::fbalpha2012_cps1_libretro.dll
::::fbalpha2012_cps2_libretro.dll
::::fbalpha2012_cps3_libretro.dll
::::fbalpha2012_libretro.dll
::::fbalpha2012_neogeo_libretro.dll
::::fbneo_libretro.dll
::::fceumm_libretro.dll
::::ffmpeg_libretro.dll
::::flycast_libretro.dll
::::fmsx_libretro.dll
::::freeintv_libretro.dll
::::frodo_libretro.dll
::::fuse_libretro.dll
::::gambatte_libretro.dll
::::gearboy_libretro.dll
::::gearsystem_libretro.dll
::::genesis_plus_gx_libretro.dll
::::gpsp_libretro.dll
::::gw_libretro.dll
::::handy_libretro.dll
::::hatari_libretro.dll
::::higan_sfc_libretro.dll
::::kronos_libretro.dll
::::lutro_libretro.dll
::::mame2003_plus_libretro.dll
::::mame2016_libretro.dll
::::mame_libretro.dll
::::mednafen_gba_libretro.dll
::::mednafen_lynx_libretro.dll
::::mednafen_ngp_libretro.dll
::::mednafen_pce_fast_libretro.dll
::::mednafen_pce_libretro.dll
::::mednafen_pcfx_libretro.dll
::::mednafen_psx_hw_libretro.dll
::::mednafen_psx_libretro.dll
::::mednafen_saturn_libretro.dll
::::mednafen_supafaust_libretro.dll
::::mednafen_supergrafx_libretro.dll
::::mednafen_vb_libretro.dll
::::mednafen_wswan_libretro.dll
::::melonds_libretro.dll
::::mesen-s_libretro.dll
::::mesen_libretro.dll
::::mgba_libretro.dll
::::mrboom_libretro.dll
::::mupen64plus_next_libretro.dll
::::nekop2_libretro.dll
::::neocd_libretro.dll
::::nestopia_libretro.dll
::::np2kai_libretro.dll
::::nxengine_libretro.dll
::::o2em_libretro.dll
::::opera_libretro.dll
::::parallel_n64_libretro.dll
::::pcsx_rearmed_libretro.dll
::::picodrive_libretro.dll
::::play_libretro.dll
::::pokemini_libretro.dll
::::ppsspp_libretro.dll
::::prboom_libretro.dll
::::prosystem_libretro.dll
::::puae_libretro.dll
::::px68k_libretro.dll
::::quasi88_libretro.dll
::::quicknes_libretro.dll
::::race_libretro.dll
::::sameboy_libretro.dll
::::scummvm_libretro.dll
::::smsplus_libretro.dll
::::snes9x_libretro.dll
::::stella2014_libretro.dll
::::stella_libretro.dll
::::tgbdual_libretro.dll
::::theodore_libretro.dll
::::tyrquake_libretro.dll
::::vbam_libretro.dll
::::vba_next_libretro.dll
::::vecx_libretro.dll
::::vice_x128_libretro.dll
::::vice_x64_libretro.dll
::::vice_xpet_libretro.dll
::::vice_xplus4_libretro.dll
::::vice_xvic_libretro.dll
::::virtualjaguar_libretro.dll
::::vitaquake2_libretro.dll
::::vitaquake3_libretro.dll
::::yabasanshiro_libretro.dll
::::yabause_libretro.dll

echo.
echo :: DOWNLOADING LIBRETRO CORES ::
echo.

for /f "delims=:::: tokens=*" %%a in ('findstr /b :::: "%~f0"') do (
rem echo %%a
 cd "%wget_path%"
rem wget --no-check-certificate -P "%current_path%\system\download" https://buildbot.libretro.com/nightly/windows/x86_64/latest/%%a.zip -q --show-progress
wget --no-check-certificate -P "%current_path%\system\download" https://www.retrobat.ovh/repo/v4/emulators/libretro_cores/x86_64/%%a.zip -q --show-progress
rem powershell -command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12 ; Invoke-WebRequest -Uri "https://buildbot.libretro.com/nightly/windows/x86_64/latest/%%a.zip" -OutFile "%current_path%\system\download\%%a.zip""
 cd "%current_path%"
 timeout /t 1 >nul
)

goto extract

:extract
echo.
echo :: EXTRACTING PACKAGES ::
echo.
echo Extracting EmulationStation...
if exist "%current_path%\system\download\EmulationStation-Win32.zip" "%sevenzip_path%"\%sevenzip_exe% -bb%sevenzip_loglevel% -y x "%current_path%\system\download\EmulationStation-Win32.zip" -o"%current_path%\emulationstation" -aoa
timeout /t 1 >nul
echo Extracting Batocera Ports...
if exist "%current_path%\system\download\batocera-ports.zip" "%sevenzip_path%"\%sevenzip_exe% -bb%sevenzip_loglevel% -y x "%current_path%\system\download\batocera-ports.zip" -o"%current_path%\emulationstation" -aoa
timeout /t 1 >nul
echo Extracting RetroArch...
if exist "%current_path%\system\download\RetroArch.7z" "%sevenzip_path%"\%sevenzip_exe% -bb%sevenzip_loglevel% -y x "%current_path%\system\download\RetroArch.7z" -o"%current_path%\emulators\retroarch" -aoa
timeout /t 1 >nul
echo Extracting Libretro cores...
if exist "%current_path%\system\download\*.dll.zip" "%sevenzip_path%"\%sevenzip_exe% -bb%sevenzip_loglevel% -y x "%current_path%\system\download\*.dll.zip" -o"%current_path%\emulators\retroarch\cores" -aoa
if exist "%current_path%\system\templates\emulationstation\retrobat-intro.mp4" (
	echo Found: retrobat-intro.mp4
	move/Y "%current_path%\system\templates\emulationstation\retrobat-intro.mp4" "%current_path%\emulationstation\.emulationstation\video"
)
timeout /t 1 >nul

echo Done.

goto clone_default_theme

:clone_default_theme

echo.
echo :: CLONING DEFAULT THEME REPOSITORY ::
echo.

if exist "%current_path%\emulationstation\.emulationstation\themes\es-theme-carbon\" (
	cd "%current_path%\emulationstation\.emulationstation\themes\es-theme-carbon"
	git pull origin
	cd %current_path%
) else (
	git clone --depth 1 --branch "%theme_branch%" %theme_git% "%current_path%\emulationstation\.emulationstation\themes\es-theme-carbon"
)

goto clean

:create_config
echo.
echo :: SETTING CONFIGURATION ::
echo.
echo Copying templates files...
%current_path%\retrobat.exe /NOF #GetConfigFiles
echo Injecting presets...
%current_path%\retrobat.exe /NOF #SetEmulationStationSettings
%current_path%\retrobat.exe /NOF #SetEmulatorsSettings
echo.
echo Done.
timeout /t 1 >nul
goto clean

:clean

echo.
echo :: CLEANING STEP ::
echo.

rem if exist "%current_path%\retrobat.ini" del/q "%current_path%\retrobat.ini"
if exist "%current_path%\*.zip" del/q "%current_path%\*.zip"
if exist "%current_path%\system\download\*.*" del/q "%current_path%\system\download\*.*"

if exist "%current_path%\emulators\retroarch\retroarch_debug.exe" del/q "%current_path%\emulators\retroarch\retroarch_debug.exe"
if exist "%current_path%\*.log" del/q "%current_path%\*.log"
if exist "%current_path%\emulators\retroarch\shaders\shaders_cg\" rd /s /q "%current_path%\emulators\retroarch\shaders\shaders_cg"

if exist "%current_path%\.git\" rmdir /s /q "%current_path%\.git"
if exist "%current_path%\system\decorations\.git\" rmdir /s /q "%current_path%\system\decorations\.git"  
if exist "%current_path%\emulationstation\.emulationstation\themes\es-theme-carbon\.git\" rmdir /s /q "%current_path%\emulationstation\.emulationstation\themes\es-theme-carbon\.git" 

if exist "%strip_path%\strip.exe" (
 cd "%strip_path%"
 strip -s "%current_path%\emulators\retroarch\retroarch.exe"
 echo striping: "%current_path%\emulators\retroarch\retroarch.exe"
 strip -s "%current_path%\emulators\retroarch\retroarch_angle.exe"
 echo striping: "%current_path%\emulators\retroarch\retroarch_angle.exe"
 for /r "%current_path%\emulators\retroarch\cores" %%i in (*.dll) do (
 strip -s %%i
 echo striping: %%i
 )
 cd "%current_path%"
)

timeout /t 1 >nul

goto menu_welcome

:build

echo.
echo :: BUILDING RETROBAT INSTALLER ::
echo.
timeout /t 1 >nul
cd %current_path%
if exist "%nsis_path%\makensis.exe" (
	cd "%nsis_path%"
	makensis.exe /V4 "%installer_dir%\%installer_source%"
	cd %current_path%
	echo.
	echo Done.
)
timeout /t 1 >nul

move/Y "%installer_dir%\*.exe" "%current_path%"

pause
goto exit

:exit
exit