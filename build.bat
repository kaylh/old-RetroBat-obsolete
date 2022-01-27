@echo off
REM -- SET PROGRAM NAME IN WINDOW TITLE --
set "name=RetroBat Builder"
set version=1.0a
title %name% %version%

:set_variables
REM -- RUNNING BUILD.BAT FOLLOWED BY A NAME IN COMMAND LINE WILL CREATE A FOLDER WITH THIS NAME INSTEAD OF DEFALT ONE --
if not "%1"=="" (
	set "clone_folder=%1"
) else (
	set "clone_folder=retrobat-git"
)

REM -- SET VARIABLES --
set retroarch_version=stable/1.10.0
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
set emulatorlauncher_url="https://github.com/fabricecaruso/batocera-ports/releases/download/continuous/batocera-ports.zip"
set retroarch_url="https://buildbot.libretro.com/%retroarch_version%/windows/x86_64/RetroArch.7z"
set retrobat_branch=master
set retrobat_git="https://github.com/kaylh/RetroBat.git"
set decorations_git="https://github.com/kaylh/batocera-bezel.git"
set theme_branch=master
set theme_git="https://github.com/kaylh/es-theme-carbon.git"
set "buildtools_dir=%current_path%\..\retrobat-buildtools"
set installer_source=installer.nsi
set "installer_dir=%current_path%\installer"
set sevenzip_loglevel=0

REM -- CHECK IF CURRENT PATH CONTAINS SPACES --
if not "%CD%"=="%cd: =%" (
	cls
	echo ***********************************************************************
	echo  ERROR
	echo ***********************************************************************
    echo  Current directory contains spaces in its path.
    echo  You need to rename the directory without spaces to launch this script.
    echo ***********************************************************************
	pause
    goto exit
)

cls
echo ******************************
echo  Starting %name% %version%...
echo ******************************
set git_bin=0
set nsis_bin=0
set sevenzip_bin=0
set strip_bin=0
set wget_bin=0

echo ******************************
echo  Checking dependancies...
echo ******************************

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

REM -- IF DEPENDANCIES NOT EXIST THEN THIS WILL DOWNLOAD AND EXTRACT IT --
if %nsis_bin% EQU 0 if %wget_bin% EQU 0 if %strip_bin% EQU 0 (
	cls
	echo ***************************************
	echo  :: DOWNLOADING RETROBAT BUILDTOOLS ::
	echo ***************************************
	powershell -command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12 ; Invoke-WebRequest -Uri "https://www.retrobat.ovh/repo/tools/retrobat-buildtools.zip" -OutFile "%current_path%\retrobat-buildtools.zip""
	ping 127.0.0.1 -n 4 >nul
	echo + RetroBat build tools downloaded
	cls
	echo **************************************
	echo  :: EXTRACTING RETROBAT BUILDTOOLS ::
	echo **************************************
rem %sevenzip_path%"\7zg.exe -y x "%current_path%\nsis.zip" -o"%current_path%\tools\nsis" -aoa>nul
	powershell -command "Expand-Archive -Force -LiteralPath "%current_path%\retrobat-buildtools.zip" -DestinationPath "%current_path%\..\.""
	echo + RetroBat build tools extracted
	
	goto set_variables
)
if exist "%current_path%\*.zip" del/q "%current_path%\*.zip"
if exist "%current_path%\system\download\*.*" del/q "%current_path%\system\download\*.*"

:menu_welcome
REM -- DISPLAY WELCOME SCREEN WITH BUILD INFOS --
cls
echo +===========================================================+
echo  %name% %version%
echo +===========================================================+
echo  This script will download all the required softwares and 
echo  build the RetroBat installer with the NullSoft 
echo  Scriptable Install System.
echo +===========================================================+
echo  (D)ownload (get required files)
echo  (B)uild installer (if files exist or download first)
echo  (Q)uit this script (abort)
echo +===========================================================+
set/p user_answer="- Type your choice here: "
if "%user_answer%"=="D" goto clone_decorations
if "%user_answer%"=="d" goto clone_decorations
if "%user_answer%"=="B" goto build
if "%user_answer%"=="b" goto build
if "%user_answer%"=="Q" goto exit
if "%user_answer%"=="q" goto exit

:clone_retrobat
cls
if %git_bin% EQU 0 (
	cls
	echo ERROR: Git for Windows is not installed. Aborting...
	goto exit
)
cls
echo ***********************************
echo  :: CLONING RETROBAT REPOSITORY ::
echo ***********************************

if exist "%current_path%\" (
	cd "%current_path%"
	git pull origin
	cd "%current_path%"
) else (
	git clone --depth 1 --branch "%retrobat_branch%" %retrobat_git% "%current_path%"
)
goto clone_decorations

:clone_decorations
echo **************************************
echo  :: CLONING DECORATIONS REPOSITORY ::
echo **************************************

if exist "%current_path%\system\decorations\" (
	cd "%current_path%\system\decorations"
	git pull origin
	cd "%current_path%"
) else (
	git clone --depth 1 %decorations_git% "%current_path%\system\decorations"
)
goto download

:download
echo.
echo Creating RetroBat's folders...
echo %current_path%
"%current_path%"\retrobat.exe /NOF #MakeTree

echo ************************************
echo  :: DOWNLOADING EMULATIONSTATION ::
echo ************************************
cd "%wget_path%"
wget --no-check-certificate -P "%current_path%\system\download" %emulationstation_url% -q --show-progress
cd "%current_path%"
rem powershell -command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12 ; Invoke-WebRequest -Uri %emulationstation_url% -OutFile "%current_path%\system\download\emulationstation.zip""
rem ping 127.0.0.1 -n 4 >nul

echo ************************************
echo  :: DOWNLOADING EMULATORLAUNCHER ::
echo ************************************
cd "%wget_path%"
wget --no-check-certificate -P "%current_path%\system\download" %emulatorlauncher_url% -q --show-progress
wget --no-check-certificate -P "%current_path%\emulationstation" https://github.com/fabricecaruso/batocera-ports/raw/master/ILMerge.exe -q --show-progress
wget --no-check-certificate -P "%current_path%\emulationstation" https://github.com/fabricecaruso/batocera-ports/raw/master/SharpDX.DirectInput.dll -q --show-progress
wget --no-check-certificate -P "%current_path%\emulationstation" https://github.com/fabricecaruso/batocera-ports/raw/master/SharpDX.dll -q --show-progress
wget --no-check-certificate -P "%current_path%\emulationstation" https://github.com/fabricecaruso/batocera-ports/raw/master/SharpDX.XInput.dll -q --show-progress
cd "%current_path%"
rem powershell -command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12 ; Invoke-WebRequest -Uri %emulatorlauncher_url% -OutFile "%current_path%\system\download\batocera-ports.zip""
rem powershell -command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12 ; Invoke-WebRequest -Uri "https://github.com/fabricecaruso/batocera-ports/raw/master/ILMerge.exe" -OutFile "%current_path%\emulationstation\ILMerge.exe""
rem powershell -command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12 ; Invoke-WebRequest -Uri "https://github.com/fabricecaruso/batocera-ports/raw/master/SharpDX.DirectInput.dll" -OutFile "%current_path%\emulationstation\SharpDX.DirectInput.dll""
rem powershell -command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12 ; Invoke-WebRequest -Uri "https://github.com/fabricecaruso/batocera-ports/raw/master/SharpDX.dll" -OutFile "%current_path%\emulationstation\SharpDX.dll""
rem powershell -command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12 ; Invoke-WebRequest -Uri "https://github.com/fabricecaruso/batocera-ports/raw/master/SharpDX.XInput.dll" -OutFile "%current_path%\emulationstation\SharpDX.XInput.dll""


if exist "%current_path%\system\download\retroarch.7z" goto extract
echo *****************************
echo  :: DOWNLOADING RETROARCH ::
echo *****************************
cd "%wget_path%"
wget --no-check-certificate -P "%current_path%\system\download" %retroarch_url% -q --show-progress
cd "%current_path%"
rem powershell -command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12 ; Invoke-WebRequest -Uri %retroarch_url% -OutFile "%current_path%\system\download\retroarch.7z""

echo **********************************
echo  :: DOWNLOADING LIBRETRO CORES ::
echo **********************************
rem for /f "delims=:::: tokens=*" %%a in ('findstr /b :::: "%~f0"') do (
for /f "usebackq delims=" %%x in ("%current_path%\system\configgen\lrcores_names.list") do (
rem echo %%a
cd "%wget_path%"
wget --no-check-certificate -P "%current_path%\system\download" https://buildbot.libretro.com/nightly/windows/x86_64/latest/%%x_libretro.dll.zip -q --show-progress
rem wget --no-check-certificate -P "%current_path%\system\download" https://www.retrobat.ovh/repo/v4/emulators/libretro_cores/x86_64/%%a.zip -q --show-progress
rem powershell -command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12 ; Invoke-WebRequest -Uri "https://buildbot.libretro.com/nightly/windows/x86_64/latest/%%a.zip" -OutFile "%current_path%\system\download\%%a.zip""
cd "%current_path%"
 
)
goto extract

:extract
echo **************************
echo :: EXTRACTING PACKAGES ::
echo **************************
echo Extracting EmulationStation...
if exist "%current_path%\system\download\EmulationStation-Win32.zip" "%sevenzip_path%"\%sevenzip_exe% -bb%sevenzip_loglevel% -y x "%current_path%\system\download\EmulationStation-Win32.zip" -o"%current_path%\emulationstation" -aoa

echo Extracting Batocera Ports...
if exist "%current_path%\system\download\batocera-ports.zip" "%sevenzip_path%"\%sevenzip_exe% -bb%sevenzip_loglevel% -y x "%current_path%\system\download\batocera-ports.zip" -o"%current_path%\emulationstation" -aoa

echo Extracting RetroArch...
if exist "%current_path%\system\download\RetroArch.7z" "%sevenzip_path%"\%sevenzip_exe% -bb%sevenzip_loglevel% -y x "%current_path%\system\download\RetroArch.7z" -o"%current_path%\emulators\retroarch" -aoa
if exist "%current_path%\emulators\retroarch\RetroArch-Win64\." (
	xcopy "%current_path%\emulators\retroarch\RetroArch-Win64\*" ""%current_path%\emulators\retroarch\*" /s /e /i /Y
	rmdir /s /q "%current_path%\emulators\retroarch\RetroArch-Win64"
)
echo Extracting Libretro cores...
if exist "%current_path%\system\download\*.dll.zip" "%sevenzip_path%"\%sevenzip_exe% -bb%sevenzip_loglevel% -y x "%current_path%\system\download\*.dll.zip" -o"%current_path%\emulators\retroarch\cores" -aoa
if exist "%current_path%\system\templates\emulationstation\retrobat-neon.mp4" (
	echo Found: retrobat-neon.mp4
	move/Y "%current_path%\system\templates\emulationstation\retrobat-neon.mp4" "%current_path%\emulationstation\.emulationstation\video"
)
echo Done.
goto clone_default_theme

:clone_default_theme
echo ****************************************
echo  :: CLONING DEFAULT THEME REPOSITORY ::
echo ****************************************

if exist "%current_path%\emulationstation\.emulationstation\themes\es-theme-carbon\" (
	cd "%current_path%\emulationstation\.emulationstation\themes\es-theme-carbon"
	git pull origin
	cd %current_path%
) else (
	git clone --depth 1 --branch "%theme_branch%" %theme_git% "%current_path%\emulationstation\.emulationstation\themes\es-theme-carbon"
)
goto create_config

:create_config
echo *****************************
echo  :: SETTING CONFIGURATION ::
echo *****************************
%current_path%\retrobat.exe /NOF #GetConfigFiles
echo + Templates files copied
%current_path%\retrobat.exe /NOF #SetEmulationStationSettings
echo + EmulationStation configured
%current_path%\retrobat.exe /NOF #SetEmulatorsSettings
echo + Emulators configured
goto clean

:clean
echo *********************
echo  :: CLEANING STEP ::
echo *********************
rem if exist "%current_path%\retrobat.ini" del/q "%current_path%\retrobat.ini"
if exist "%current_path%\*.zip" del/q "%current_path%\*.zip"
if exist "%current_path%\system\download\*.*" del/q "%current_path%\system\download\*.*"
echo + Download folder's content deleted

if exist "%current_path%\emulators\retroarch\retroarch_debug.exe" del/q "%current_path%\emulators\retroarch\retroarch_debug.exe"
if exist "%current_path%\*.log" del/q "%current_path%\*.log"
if exist "%current_path%\emulators\retroarch\shaders\shaders_cg\" rd /s /q "%current_path%\emulators\retroarch\shaders\shaders_cg"

if exist "%current_path%\.git\" rmdir /s /q "%current_path%\.git"
if exist "%current_path%\system\decorations\.git\" rmdir /s /q "%current_path%\system\decorations\.git"  
if exist "%current_path%\emulationstation\.emulationstation\themes\es-theme-carbon\.git\" rmdir /s /q "%current_path%\emulationstation\.emulationstation\themes\es-theme-carbon\.git"

if exist "%current_path%\emulationstation\batocera-bluetooth.exe" del/q "%current_path%\emulationstation\batocera-bluetooth.exe"
if exist "%current_path%\emulationstation\batocera-install.exe" del/q "%current_path%\emulationstation\batocera-install.exe"
if exist "%current_path%\emulationstation\batocera-store.exe" del/q "%current_path%\emulationstation\batocera-store.exe" 
if exist "%current_path%\emulationstation\batocera-wifi.exe" del/q "%current_path%\emulationstation\batocera-wifi.exe" 
if exist "%current_path%\emulationstation\*.pdb" del/q "%current_path%\emulationstation\*.pdb"
echo + Uneeded files deleted

if exist "%strip_path%\strip.exe" (
 cd "%strip_path%"
 strip -s "%current_path%\emulators\retroarch\retroarch.exe"
 echo striping: "%current_path%\emulators\retroarch\retroarch.exe"
rem strip -s "%current_path%\emulators\retroarch\retroarch_angle.exe"
rem echo striping: "%current_path%\emulators\retroarch\retroarch_angle.exe"
 for /r "%current_path%\emulators\retroarch\cores" %%i in (*.dll) do (
 strip -s %%i
 echo striping: %%i
 )
 cd "%current_path%"
)
goto menu_welcome

:build
echo ***********************************
echo  :: BUILDING RETROBAT INSTALLER ::
echo ***********************************

cd %current_path%
if exist "%nsis_path%\makensis.exe" (
	cd "%nsis_path%"
	makensis.exe /V4 "%installer_dir%\%installer_source%"
	cd %current_path%
)
move/Y "%installer_dir%\*.exe" "%current_path%"
echo + RetroBat installer created
pause
exit