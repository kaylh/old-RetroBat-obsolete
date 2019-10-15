@ECHO OFF
If "%CD%"=="C:\Windows\system32" GOTO admin_fail
If "%CD%"=="C:\Windows" GOTO admin_fail
If "%CD%"=="C:\WINDOWS\system32" GOTO admin_fail
If "%CD%"=="C:\WINDOWS" GOTO admin_fail
Reg Query "HKLM\Hardware\Description\System\CentralProcessor\0" | find /i "x86" > nul && set OS=32BIT || set OS=64BIT
If %OS%==32BIT goto wrongArch
If %OS%==64BIT goto set_variables0

:cleanInstall
Cd %SetupDir%
Rem Set "updateESsys="
If exist %InitSetup% del/Q %InitSetup%
Goto set_variables0

:set_variables0
SET name=RetroBat
SET/p BuildVersion=<%CD%\System\retrobat.version
SET InitSetup=setup.ini
::SET InitProfile=Profile.ini
SET LauncherFile=retro.bat
SET SetupFile=setup.bat
REM SET ScraperFile=scraper.bat
SET SetupDir="%cd:~3%">nul
SET SetupDir>nul
SET SetupDir=%SetupDir:"=%
SET SetupDir>nul
SET SFX=0
TITLE %Name% Setup
If exist SFX (
	del/q SFX
	set SFX=1
	goto setupMenu
) else (
	goto checkIni
)

:checkIni
If exist %InitSetup% goto fetchMenu
Goto setupMenu

:setupMenu
Cls
If "%SFX%"=="1" goto set_variables1
Call %CD%\System\Scripts\ShowLogo.cmd
ECHO       Version: %BuildVersion% by Kayl                                            
ECHO +-------------------------------------------+
ECHO.                                                               
ECHO  RetroBat is a set of scripts written to help 
ECHO  launching and configure EmulationStation.
ECHO.
ECHO  The frontend will be set to use the emulator
ECHO  RetroArch and many others compatible to run 
ECHO  games from your collection.
ECHO.
ECHO  WE WILL NOW MAKE A NEW CONFIGURATION IN THE
ECHO  CURRENT RETROBAT'S FOLDER:
ECHO. 
ECHO +-------------------------------------------+ 
ECHO  Setup directory:
ECHO  %CD%
ECHO +===========================================+ 
SET go=C
SET/P go="- (C)ontinue or (Q)uit: "
IF "%go%"=="C" GOTO set_variables1
IF "%go%"=="c" GOTO set_variables1
IF "%go%"=="Q" GOTO exit
IF "%go%"=="q" GOTO exit

:set_variables1
ECHO SetupDir=\%SetupDir%>> %InitSetup%
ECHO NAME=%Name%>> %InitSetup%
ECHO VERSION=%BuildVersion%>> %InitSetup%
REM ECHO SCRIPTS_PATH=\%SetupDir%\System\MainData>> %InitSetup%
ECHO SCRIPTS_PATH=\%SetupDir%\system\scripts>> %InitSetup%
ECHO CONFIG_PATH=\%SetupDir%\configs>> %InitSetup%
timeout /t 1 >nul
FOR /f "delims=" %%x IN (%InitSetup%) DO (set "%%x")
::CD %CONFIG_PATH%\Profiles
::FOR /f "delims=" %%x IN (%InitProfile%) DO (set "%%x")
::SET PROFILE_PATH=%CONFIG_PATH%\Profiles\%profile_name%
SET HOME=%CONFIG_PATH%
Set zip_path="%ProgramFiles%"\7-Zip
REM SET HOMEPATH=%HOME%
SET emulator_path=%SetupDir%\emulators
SET RETROARCH_CONFIG_DIR=%emulator_path%\retroarch\config
SET RETROARCH_OVERRIDE_DIR=%emulator_path%\retroarch\config
SET RETROARCH_OVERRIDE_FILE=retroarch-override.cfg
SET DOLPHIN_CONFIG_DIR=%emulator_path%\dolphin-emu\config
SET PCSX2_CONFIG_DIR=%emulator_path%\pcsx2\config
SET ES_PATH=%SetupDir%\emulationstation
SET ES_CONFIG_DIR=%ES_PATH%\.emulationstation
SET SCRIPTS_PATH=%SetupDir%\system\scripts
SET TemplatesPath=%SetupDir%\system\templates
SET ESTemplates=%TemplatesPath%\emulationstation
SET ConfigMenuPath=%SetupDir%\system\configmenu
Set TMP_DIR=%SetupDir%\system\!packages
::Set SCRAPER_DIR=%SetupDir%\scraper
REM specific settings for retroarch override configuration file
SET savegame_dir=%SetupDir%\saves
SET shots_dir=%SetupDir%\screenshots
SET bios_dir=%SetupDir%\bios
SET games_dir=%SetupDir%\roms
SET medias_dir=%SetupDir%\medias
SET libretro_cores_dir=%EMULATOR_PATH%\retroarch\cores
timeout /t 2 >nul
GOTO check7zip

:check7zip
If exist %zip_path%\%zip_bin% (
	goto mkFolders
) else (
	goto error1
)

:: Create RetroBat tree
:mkFolders
CLS
ECHO.
ECHO -- Checking if RetroBat's User Folders exist --
ECHO.
GOTO checkGameDir

:chkDefaultProfileDir
::Set PROFILE_NAME=Default
::Cd %SetupDir%
::If not exist %PROFILE_PATH%\. md %PROFILE_PATH%
::GOTO checkGameDir

:checkGameDir
Cd %SetupDir%
If exist %games_dir%\. (
    echo :: Directory "%games_dir%" already exist. Skipping.
    goto checkSavesDir
) else (
    Md %games_dir%
	echo :: Directory "%games_dir%%" created !
    goto checkSavesDir
)

:checkSavesDir
If exist %savegame_dir%\. (
    echo :: Directory "%savegame_dir%" already exist. Skipping.
    goto checkShotsDir
) else (
    Md %savegame_dir%
	echo :: Directory "%savegame_dir%" created !
    goto checkShotsDir
)

:checkShotsDir
If exist %shots_dir%\. (
    echo :: Directory "%shots_dir%" already exist. Skipping.
    goto checkBiosDir
) else (
    Md %shots_dir%
	echo :: Directory "%shots_dir%" created !
    goto checkBiosDir
)

:checkBiosDir
If exist %bios_dir%\. (
    echo :: Directory "%bios_dir%" already exist. Skipping.
    goto checkMediasDir
) else (
    Md %bios_dir%
	echo :: Directory "%bios_dir%" created !
    goto checkMediasDir
)

:checkMediasDir
If exist %medias_dir%\. (
    echo :: Directory "%medias_dir%" already exist. Skipping.
    goto checkDolphinDir
) else (
    Md %medias_dir%
	echo :: Directory "%medias_dir%" created !
    goto checkDolphinDir
)

:checkDolphinDir
If exist %DOLPHIN_CONFIG_DIR%\. (
    echo :: Directory "%emulator_path%\dolphin-emu" already exist. Skipping.
    goto checkPcsx2Dir
) else (
    Md %DOLPHIN_CONFIG_DIR%
	If exist %TemplatesPath%\Infos\info-emu.txt copy/Y %TemplatesPath%\Infos\info-emu.txt %emulator_path%\dolphin-emu\info.txt
	echo :: Directory "%DOLPHIN_CONFIG_DIR%" created !
    goto checkPcsx2Dir
)

:checkPcsx2Dir
If exist %emulator_path%\pcsx2\. (
    echo :: Directory "%emulator_path%\pcsx2" already exist. Skipping.
    goto checkPcsx2CfgDir
) else (
    Md %emulator_path%\pcsx2
	If exist %TemplatesPath%\Infos\info-emu.txt copy/Y %TemplatesPath%\Infos\info-emu.txt %emulator_path%\pcsx2\info.txt
	echo :: Directory "%emulator_path%\pcsx2" created !
    goto checkPcsx2CfgDir
)

:checkPcsx2CfgDir
If exist %PCSX2_CONFIG_DIR%\. (
    echo :: Directory "%PCSX2_CONFIG_DIR%" already exist. Skipping.
    goto checkPpssppDir
) else (
    Md %PCSX2_CONFIG_DIR%
	echo :: Directory "%PCSX2_CONFIG_DIR%" created !
    goto checkPpssppDir
)

:checkPpssppDir
If exist %emulator_path%\ppsspp\. (
    echo :: Directory "%emulator_path%\ppsspp" already exist. Skipping.
    goto checkRedreamDir
) else (
    Md %emulator_path%\ppsspp
	If exist %TemplatesPath%\Infos\info-emu.txt copy/Y %TemplatesPath%\Infos\info-emu.txt %emulator_path%\ppsspp\info.txt
	echo :: Directory "%emulator_path%\ppsspp" created !
    goto checkRedreamDir
)

:checkRedreamDir
If exist %emulator_path%\redream\. (
    echo :: Directory "%emulator_path%\redream" already exist. Skipping.
    goto checkDosboxDir
) else (
    Md %emulator_path%\redream
	If exist %TemplatesPath%\Infos\info-emu.txt copy/Y %TemplatesPath%\Infos\info-emu.txt %emulator_path%\redream\info.txt
	echo :: Directory "%emulator_path%\redream" created !
    goto checkDosboxDir
)

:checkDosboxDir
If exist %emulator_path%\dosbox\. (
    echo :: Directory "%emulator_path%\dosbox" already exist. Skipping.
    goto mkConfig
) else (
    Md %emulator_path%\dosbox
	If exist %TemplatesPath%\Infos\info-emu.txt copy/Y %TemplatesPath%\Infos\info-emu.txt %emulator_path%\dosbox\info.txt
	echo :: Directory "%emulator_path%\dosbox" created !
    goto checkRADir
)

:checkRADir
If exist %emulator_path%\retroarch\. (
    echo :: Directory "%emulator_path%\retroarch" already exist. Skipping.
    goto mkConfig
) else (
    Md %emulator_path%\retroarch
	echo :: Directory "%emulator_path%\retroarch" created !
    goto mkConfig
)

:mkConfig
If exist %TemplatesPath%\Infos\info-bios.txt copy/Y %TemplatesPath%\Infos\info-bios.txt %bios_dir%\BIOS.txt>nul
If exist %SCRIPTS_PATH%\%LauncherFile% copy/Y %SCRIPTS_PATH%\%LauncherFile% %SetupDir%\%LauncherFile%>nul
REM If exist %SCRIPTS_PATH%\%ScraperFile% copy/Y %SCRIPTS_PATH%\%ScraperFile% %SetupDir%\%ScraperFile%>nul
:: Create roms folders
Cd %games_dir%
Call %SCRIPTS_PATH%\SystemsNames.cmd
If not exist %threedo%\. md "%threedo%"
If not exist %atari2600%\. md %atari2600%
If not exist %atari5200%\. md %atari5200%
If not exist %atarijaguar%\. md %atarijaguar%
If not exist %atarilynx%\. md %atarilynx%
If not exist %ataripro%\. md %ataripro%
If not exist %atarist%\. md %atarist%
If not exist %cave%\. md %cave%
If not exist %pce%\. md %pce%
If not exist %pcecd%\. md %pcecd%
If not exist %supergrafx%\. md %supergrafx%
If not exist %n64%\. md %n64%
If not exist %nds%\. md %nds%
If not exist %gb%\. md %gb%
If not exist %gb2p%\. md %gb2p%
If not exist %gbadv%\. md %gbadv%
If not exist %gbcolor%\. md %gbcolor%
If not exist %gbc2p%\. md %gbc2p%
If not exist %nes%\. md %nes%
If not exist %snes%\. md %snes%
If not exist %gamecube%\. md %gamecube%
If not exist %wii%\. md %wii%
If not exist %sega32x%\. md %sega32x%
If not exist %dreamcast%\. md %dreamcast%
If not exist %gamegear%\. md %gamegear%
If not exist %mastersystem%\. md %mastersystem%
If not exist %megacd%\. md %megacd%
If not exist %megadrive%\. md %megadrive%
If not exist %saturn%\. md %saturn%
::If not exist %model2%\. md %model2%
If not exist %neogeo%\. md %neogeo%
If not exist %neogeocd%\. md %neogeocd%
If not exist %ngp%\. md %ngp%
If not exist %ngpc%\. md %ngpc%
If not exist %npg%\. md %npg%
If not exist %msu1%\. md %msu1%
If not exist %psx%\. md %psx%
If not exist %ps2%\. md %ps2%
If not exist %msu1%\. md %msu1%
If not exist %psx%\. md %psx%
If not exist %ps2%\. md %ps2%
If not exist %psp%\. md %psp%
If not exist %videopac%\. md %videopac%
If not exist %fba%\. md %fba%
If not exist %mame%\. md %mame%
If not exist %vb%\. md %vb%
::If exist %mame%\. cd %mame%
::If not exist %mame%\. md %mame%
::If not exist %mame2000%\. md %mame2000%
::If not exist %mame2003%\. md %mame2003%
::If not exist %mame2010%\. md %mame2010%
::If not exist %mame2014%\. md %mame2014%
::If not exist %mame2016%\. md %mame2016%
::If exist %mame2000%\. cd ..
If not exist %cps1%\. md %cps1%
If not exist %cps2%\. md %cps2%
If not exist %cps3%\. md %cps3%
If not exist %msdos%\. md %msdos%
If not exist %wswan%\. md %wswan%
If not exist %wswanc%\. md %wswanc%
If not exist %amiga%\. md %amiga%
If not exist %amstradcpc%\. md %amstradcpc%
If not exist %colecov%\. md %colecov%
If not exist %com64%\. md %com64%
::If not exist %com128%\. md %com128%
::If not exist %comvic20%\. md %comvic20%
::If not exist %complus4%\. md %complus4%
If not exist %gamewatch%\. md %gamewatch%
If not exist %intellivision%\. md %intellivision%
::If not exist %laserdisc%\. md %laserdisc%
If not exist %msx%\. md %msx%
If not exist %n3ds%\. md %n3ds%
If not exist %pcfx%\. md %pcfx%
If not exist %scummvm%\. md %scummvm%
If not exist %vectrex%\. md %vectrex%
If not exist %zxspectrum%\. md %zxspectrum%
If not exist %atomiswave%\. md %atomiswave%
If not exist %naomi%\. md %naomi%
If not exist %pcgames%\. md %pcgames%
timeout /t 2 >nul
:: Save path in Setup.ini
Cd %SetupDir%
ECHO games_dir=%games_dir%>> %InitSetup%
ECHO savegame_dir=%savegame_dir%>> %InitSetup%
ECHO shots_dir=%shots_dir%>> %InitSetup%
ECHO bios_dir=%bios_dir%>> %InitSetup%
::ECHO shaders_dir=%shaders_dir%>> %InitSetup%
ECHO ConfigMenuPath=%ConfigMenuPath%>> %InitSetup%
ECHO TMP_DIR=%TMP_DIR%>> %InitSetup%
timeout /t 1 >nul
GOTO mkConfig1

:: Post installation export variables in setup.ini
:mkConfig1
ECHO.
ECHO -- Saving Modifications --
ECHO.
ECHO PROFILE_PATH=%PROFILE_PATH%>> %InitSetup%
ECHO EMULATOR_PATH=%EMULATOR_PATH%>> %InitSetup%
ECHO RETROARCH_CONFIG_DIR=%RETROARCH_CONFIG_DIR%>> %InitSetup%
ECHO RETROARCH_OVERRIDE_DIR=%RETROARCH_OVERRIDE_DIR%>> %InitSetup%
ECHO RETROARCH_OVERRIDE_FILE=%RETROARCH_OVERRIDE_FILE%>> %InitSetup%
ECHO DOLPHIN_CONFIG_DIR=%DOLPHIN_CONFIG_DIR%>> %InitSetup%
ECHO PCSX2_CONFIG_DIR=%PCSX2_CONFIG_DIR%>> %InitSetup%
ECHO ES_PATH=%ES_PATH%>> %InitSetup%
ECHO ES_CONFIG_DIR=%ES_CONFIG_DIR%>> %InitSetup%
ECHO zip_path=%zip_path%>> %InitSetup%
ECHO SCRAPER_DIR=%SCRAPER_DIR%>> %InitSetup%
ECHO libretro_cores_dir=%libretro_cores_dir%>> %InitSetup%
ECHO TemplatesPath=%TemplatesPath%>> %InitSetup%
goto checkSFX

:checkSFX
ECHO :: Done.
timeout /t 2 >nul
If exist %RETROARCH_OVERRIDE_DIR%\%RETROARCH_OVERRIDE_FILE% set RAOF=1
If not exist %RETROARCH_OVERRIDE_DIR%\%RETROARCH_OVERRIDE_FILE% set RAOF=0
If "%RAOF%"=="1" goto mkRAcfg3
If "%SFX%"=="1" (
	goto mkRAcfg2b
) else (
	goto setupInfo
)

:setupInfo
CLS
CALL %CD%\System\Scripts\ShowLogo.cmd
ECHO  Version: %BuildVersion% by Kayl                                            
ECHO +-------------------------------------------+
ECHO.                                  
ECHO  - Setup directory: "%SetupDir%"
ECHO.
ECHO  - ROMS "%games_dir%"
ECHO  - BIOS "%bios_dir%"
ECHO  - Saves "%savegame_dir%"
ECHO  - Screenshots "%shots_dir%"
ECHO.
ECHO +===========================================+
ECHO  -- PRESS ANY KEY TO RETURN TO SETUP MENU --
pause>nul
GOTO fetchMenu

:fetchMenu
Cd %SetupDir%
Cls
for /f "delims=" %%x in (%InitSetup%) do (set "%%x")
::Cd %CONFIG_PATH%\Profiles
::for /f "delims=" %%x in (%InitProfile%) do (set "%%x")
Call %SCRIPTS_PATH%\PkgSources.cmd
REM for /f "delims=" %%x in (sources.cfg) do (set "%%x")
Call %SCRIPTS_PATH%\ShowLogo.cmd
If exist %RETROARCH_OVERRIDE_DIR%\%RETROARCH_OVERRIDE_FILE% set RAOF=1
If not exist %RETROARCH_OVERRIDE_DIR%\%RETROARCH_OVERRIDE_FILE% set RAOF=0

ECHO  Version: %BuildVersion% by Kayl                                            
ECHO +-------------------------------------------+
ECHO    1) -- LAUNCH EMULATIONSTATION FRONTEND                                        
ECHO    2) -- INSTALL EMULATIONSTATION
::ECHO    3) -- INSTALL EXTRA THEMES
ECHO    3) -- INSTALL EMULATORS
::ECHO    4) -- INSTALL COMMAND LINE SCRAPER ENGINE
ECHO    4) -- RESET RETROBAT CONFIGURATION
ECHO    5) -- UPDATE SOURCES
Echo    6) -- DELETE ALL UNNEEDED PACKAGES
Echo    7) -- VISIT JOYTOKEY WEB SITE
Echo    8) -- VISIT RETROBAT WEB SITE
ECHO    Q) -- QUIT
ECHO +===========================================+
Set mkinstall0=1
Set /p mkinstall0="Please choose one (Number or Q): "
If "%mkinstall0%"=="1" goto runES
If "%mkinstall0%"=="2" goto ESupdate0
If "%mkinstall0%"=="3" goto fetchEmulators
::If "%mkinstall0%"=="4" goto SCPupdate0
If "%mkinstall0%"=="4" goto cleanInstall
If "%mkinstall0%"=="5" goto sourcesUpdate
If "%mkinstall0%"=="6" goto cleanTMP
If "%mkinstall0%"=="7" goto visitJ2K
If "%mkinstall0%"=="8" goto visitRetroBat
If "%mkinstall0%"=="q" goto exit
If "%mkinstall0%"=="Q" goto exit
Goto fetchMenu

:cleanTMP
Echo Deleting unneeded packages...
If exist %TMP_DIR%\*-pkg.7z del %TMP_DIR%\*-pkg.7z>nul
If exist %TMP_DIR%\*-pkg.zip del %TMP_DIR%\*-pkg.zip>nul
:: If exist %TMP_DIR%\. rmdir %TMP_DIR%>nul
timeout /t 2 >nul
Echo Done.
timeout /t 2 >nul
Goto fetchMenu

:fetchEmulators
CLS
CALL %SCRIPTS_PATH%\ShowLogo.cmd
ECHO  Version: %BuildVersion% by Kayl                                            
ECHO +-------------------------------------------+
ECHO    1) -- INSTALL RETROARCH (STABLE)
ECHO    2) -- INSTALL RETROARCH (NIGHTLY BUILD)
ECHO    3) -- INSTALL LIBRETRO CORES LITE PACK
ECHO    4) -- INSTALL DOSBOX EMULATOR
ECHO    5) -- INSTALL DOLPHIN EMULATOR
ECHO    6) -- INSTALL PCSX2 EMULATOR
ECHO    7) -- VISIT REDREAM DOWNLOAD PAGE (WEB)
ECHO    8) -- VISIT PPSSPP DOWNLOAD PAGE (WEB)
ECHO    M) -- RETURN TO SETUP MENU
ECHO    Q) -- QUIT
ECHO +===========================================+
Set mkinstall0=Q
Set /p mkinstall1="Please choose one (Number, M or Q): "
if "%mkinstall1%"=="1" goto instRAl0
if "%mkinstall1%"=="2" goto instRAn0
if "%mkinstall1%"=="3" goto installCores0
if "%mkinstall1%"=="4" goto instDOSBox0
if "%mkinstall1%"=="5" goto instDolphin0
if "%mkinstall1%"=="6" goto instPcsx20
if "%mkinstall1%"=="7" goto visitRedream
if "%mkinstall1%"=="8" goto visitPpsspp
if "%mkinstall1%"=="m" goto fetchMenu
if "%mkinstall1%"=="M" goto fetchMenu
if "%mkinstall1%"=="Q" goto exit
if "%mkinstall1%"=="q" goto exit
GOTO fetchEmulators

:ESupdate0
Set warningES0=M
ECHO +===========================================+
ECHO                  ATTENTION: 
ECHO.
ECHO CHOOSE THIS OPTION ONLY IF YOU HAVE NOT 
ECHO EMULATIONSTATION ALREADY INSTALLED OR IF YOU  
ECHO WANT TO MAKE A CLEAN NEW INSTALLATION OF THE 
ECHO FRONTEND. 
ECHO THE NEW FILES WILL OVERWRITE THE OLD ONES AND
ECHO INSTALLED THEMES WILL BE ERASED.
ECHO +===========================================+
SET /p warningES0="(I)nstall, return to (M)enu or (Q)uit: "
if "%warningES0%"=="I" goto instES0
if "%warningES0%"=="i" goto instES0
if "%warningES0%"=="M" goto fetchMenu
if "%warningES0%"=="m" goto fetchMenu
if "%warningES0%"=="Q" goto exit
if "%warningES0%"=="q" goto exit

:instES0
Set pkgName=EmulationStation
Set pkgFile0=es-core-pkg.zip
Set pkgFile1=es-config-pkg.zip
Set pkgFile2=nextfull-theme-pkg.7z
Set/A ESfullPkg=0
Set/A EScheckPkg=0
CLS
REM Set updateESsys=1
Cd %SetupDir%
If exist %TMP_DIR%\%pkgFile0% set/A ESfullPkg=%ESfullPkg%+1
If exist %TMP_DIR%\%pkgFile1% set/A ESfullPkg=%ESfullPkg%+1
If exist %TMP_DIR%\%pkgFile2% set/A ESfullPkg=%ESfullPkg%+1
:: Set/A ESfullPkg=(%EScorePkg%+%ESassetsPkg%)>nul
If "%ESfullPkg%"=="3" goto instES1
If not exist %TMP_DIR%\. md %TMP_DIR%
ECHO -- %pkgName% is now downloading --
ECHO.
powershell -command "Invoke-WebRequest -Uri %emulationstation_url% -OutFile "%TMP_DIR%\%pkgFile0%""
powershell -command "Invoke-WebRequest -Uri %es_profile_url% -OutFile "%TMP_DIR%\%pkgFile1%""
powershell -command "Invoke-WebRequest -Uri %nextfull_theme_url% -OutFile "%TMP_DIR%\%pkgFile2%""
ping 127.0.0.1 -n 4 >nul
timeout /t 2 >nul
If not exist %TMP_DIR%\%pkgFile0% set/A EScheckPkg=%EScheckPkg%+1
If not exist %TMP_DIR%\%pkgFile1% set/A EScheckPkg=%EScheckPkg%+1
If not exist %TMP_DIR%\%pkgFile2% set/A EScheckPkg=%EScheckPkg%+1
If %EScheckPkg% GEQ 1 goto pkgFail
ECHO Done.
If %EScheckPkg% EQU 0 goto instES1

:instES1
CLS
If exist %ES_PATH%\emulationstation.exe rmdir /s /q %ES_PATH%
If not exist %ES_PATH%\. md %ES_PATH%
ECHO -- %pkgName% is installing --
ECHO.
%ZIP_PATH%\7zg.exe -y x "%TMP_DIR%\%pkgFile0%" -o"%ES_PATH%" -aoa >nul
%ZIP_PATH%\7zg.exe -y x "%TMP_DIR%\%pkgFile1%" -o"%ES_PATH%" -aoa >nul
%ZIP_PATH%\7zg.exe -y x "%TMP_DIR%\%pkgFile2%" -o"%ES_PATH%\.emulationstation" -aoa >nul
ECHO Done.
timeout /t 2 >nul
goto fetchMenu

:sourcesUpdate
CLS
Cd %SetupDir%
If exist %SCRIPTS_PATH%\PkgSources.cmd del/q %SCRIPTS_PATH%\PkgSources.cmd 
ECHO -- Updating sources --
ECHO.
powershell -command "Invoke-WebRequest -Uri "http://www.retrobat.ovh/repo/scripts/PkgSources.cmd" -OutFile "%SCRIPTS_PATH%\PkgSources.cmd""
ping 127.0.0.1 -n 4 >nul
CLS
ECHO Please start this script again for change to take effect
ECHO ---
timeout /t 5 >nul
GOTO exit

:SCPupdate0
Set pkgName=Scraper Engine
Set pkgFile=scraper-pkg.zip
CLS
Cd %SetupDir%
If exist %SetupDir%\Scraper\Scraper.bat rmdir /s /q %SetupDir%\Scraper
If not exist %SetupDir%\Scraper\Scraper.bat md %SetupDir%\Scraper
If not exist %TMP_DIR%\. md %TMP_DIR%
ECHO -- %pkgName% is now downloading --
ECHO.
powershell -command "Invoke-WebRequest -Uri %scraper_url% -OutFile "%TMP_DIR%\%pkgFile%""
ping 127.0.0.1 -n 4 >nul
If not exist %TMP_DIR%\%pkgFile% goto pkgFail
Goto SCPupdate1

:SCPupdate1
CLS
ECHO -- %pkgName% is installing --
ECHO.
%ZIP_PATH%\7zg.exe -y x "%TMP_DIR%\%pkgFile%" -o"%SetupDir%\Scraper" -aoa >nul
timeout /t 3 >nul
goto fetchMenu

:instRAl0
Set pkgName=RetroArch Lite
Set pkgFile=retroarch-lite-pkg.7z
CLS
Cd %SetupDir%
If exist %TMP_DIR%\%pkgFile% goto instRAl1
If exist %EMULATOR_PATH%\retroarch\retroarch.exe rmdir /s /q %EMULATOR_PATH%\retroarch
If not exist %EMULATOR_PATH%\retroarch\. md %EMULATOR_PATH%\retroarch
If not exist %TMP_DIR%\. md %TMP_DIR%
If exist %TMP_DIR%\%pkgFile% goto instRAl1
ECHO -- %pkgName% is now downloading --
ECHO.
powershell -command "Invoke-WebRequest -Uri %retroarch_lite_url% -OutFile "%TMP_DIR%\%pkgFile%""
ping 127.0.0.1 -n 4 >nul
If not exist %TMP_DIR%\%pkgFile% goto pkgFail
Goto instRAl1

:instRAl1
CLS
ECHO -- %pkgName% is installing --
ECHO.
%ZIP_PATH%\7zg.exe -y x "%TMP_DIR%\%pkgFile%" -o"%EMULATOR_PATH%\retroarch" -aoa >nul
::del "%TMP_DIR%\%pkgFile%" /q
::rmdir %TMP_DIR%
timeout /t 3 >nul
goto RAcfgMenu

:instRAn0
Set pkgName=RetroArch
Set pkgFile=retroarch-pkg.7z
CLS
Cd %SetupDir%
If exist %TMP_DIR%\%pkgFile% goto instRAn1
If exist %EMULATOR_PATH%\retroarch\retroarch.exe rmdir /s /q %EMULATOR_PATH%\retroarch
If not exist %EMULATOR_PATH%\retroarch\. md %EMULATOR_PATH%\retroarch
If not exist %TMP_DIR%\. md %TMP_DIR%
If exist %TMP_DIR%\%pkgFile% goto instRAn1
ECHO -- %pkgName% is now downloading --
ECHO.
powershell -command "Invoke-WebRequest -Uri %retroarch_nightly_url% -OutFile "%TMP_DIR%\%pkgFile%""
ping 127.0.0.1 -n 4 >nul
If not exist %TMP_DIR%\%pkgFile% goto pkgFail
Goto instRAn1

:instRAn1
CLS
ECHO -- %pkgName% is installing --
ECHO.
%ZIP_PATH%\7zg.exe -y x "%TMP_DIR%\%pkgFile%" -o"%EMULATOR_PATH%\retroarch" -aoa >nul
::del "%TMP_DIR%\%pkgFile%" /q
::rmdir %TMP_DIR%
timeout /t 3 >nul
goto RAcfgMenu

:RAcfgMenu
CLS
Set RAcfg=K
ECHO +===========================================+
ECHO    PLEASE CHOOSE A TEMPLATE FOR RETROARCH'S 
ECHO                  CONFIG FILE
ECHO +===========================================+
ECHO.
ECHO 0) -- DEFAULT SETTINGS (xmb,windowed,opengl)*
ECHO 1) -- CUSTOM SETTINGS 1 (rgui,fullscreen,opengl)
ECHO 2) -- CUSTOM SETTINGS 2 (xmb,fullscreen,directx11)*
ECHO 3) -- CUSTOM SETTINGS 3 (ozone,fullscreen,vulkan)*
ECHO.
ECHO     * require assets
ECHO +===========================================+
ECHO   CURRENT RETROARCH'S CONFIG FILES WILL BE
ECHO                  OVERWRITED !           
ECHO +===========================================+
SET /p RAcfg="Type a number or (k)eep current RetroArch config: "
if "%RAcfg%"=="0" goto mkRAcfg0 
if "%RAcfg%"=="1" goto mkRAcfg2
if "%RAcfg%"=="2" goto mkRAcfg2
if "%RAcfg%"=="3" goto mkRAcfg2
if "%RAcfg%"=="K" goto mkRAcfg3
if "%RAcfg%"=="k" goto mkRAcfg3
Goto mkRAcfg3

:mkRAcfg0
CLS
ECHO.
ECHO -- Setting up %pkgName% configuration files --
ECHO.
if "%RAcfg%"=="0" set RAcfgName=default
Goto mkRAcfg1

:mkRAcfg1
If exist %emulator_path%\retroarch\config\retroarch.cfg (
	copy/Y %emulator_path%\retroarch\config\retroarch.cfg %emulator_path%\retroarch\config\retroarch.cfg.backup
	del/q %emulator_path%\retroarch\config\retroarch.cfg
	copy/Y %emulator_path%\retroarch\retroarch.%RAcfgName%.cfg %emulator_path%\retroarch\config\retroarch.cfg
	) else (
	copy/Y %emulator_path%\retroarch\retroarch.%RAcfgName%.cfg %emulator_path%\retroarch\config\retroarch.cfg
)
timeout /t 2 >nul
Goto mkRAcfg3

:mkRAcfg2
If not exist %emulator_path%\retroarch\. md %emulator_path%\retroarch
If not exist %emulator_path%\retroarch\config\. md %emulator_path%\retroarch\config
if "%RAcfg%"=="1" set RAcfgName=custom1
if "%RAcfg%"=="2" set RAcfgName=custom2
if "%RAcfg%"=="3" set RAcfgName=custom3
If exist %emulator_path%\retroarch\config\retroarch.cfg (
	copy/Y %emulator_path%\retroarch\config\retroarch.cfg %emulators_path%\retroarch\config\retroarch.cfg.backup
	del/q %emulator_path%\retroarch\config\retroarch.cfg
	copy/Y %TemplatesPath%\retroarch\retroarch-%RAcfgName%.cfg %emulator_path%\retroarch\config\retroarch.cfg
	) else (
	copy/Y %TemplatesPath%\retroarch\retroarch-%RAcfgName%.cfg %emulator_path%\retroarch\config\retroarch.cfg
)
timeout /t 2 >nul
Goto mkRAcfg3

:mkRAcfg2b
CLS
ECHO.
ECHO -- Setting up %pkgName% configuration files --
ECHO.
Set RAcfgName=custom1
If not exist %emulator_path%\retroarch\. md %emulator_path%\retroarch
If not exist %emulator_path%\retroarch\config\. md %emulator_path%\retroarch\config
copy/Y %TemplatesPath%\retroarch\retroarch-%RAcfgName%.cfg %emulator_path%\retroarch\config\retroarch.cfg
Echo :: Done.
timeout /t 2 >nul
Goto mkRAcfg3

:mkRAcfg3
CLS
ECHO.
ECHO -- Setting up %pkgName% configuration files --
ECHO.
:: Create RetroArch override configuration file

If exist %RETROARCH_OVERRIDE_DIR%\%RETROARCH_OVERRIDE_FILE% (
    del %RETROARCH_OVERRIDE_DIR%\%RETROARCH_OVERRIDE_FILE%
    (echo screenshot_directory = "%shots_dir%" && echo system_directory = "%bios_dir%" && echo savefile_directory = "%savegame_dir%" && echo savestate_directory = "%savegame_dir%" && echo libretro_directory = "%libretro_cores_dir%")>> %RETROARCH_OVERRIDE_DIR%\%RETROARCH_OVERRIDE_FILE%
) else (
	md %RETROARCH_OVERRIDE_DIR%
    (echo screenshot_directory = "%shots_dir%" && echo system_directory = "%bios_dir%" && echo savefile_directory = "%savegame_dir%" && echo savestate_directory = "%savegame_dir%" && echo libretro_directory = "%libretro_cores_dir%")>> %RETROARCH_OVERRIDE_DIR%\%RETROARCH_OVERRIDE_FILE%
)
ECHO :: Done.
timeout /t 2 >nul
If "%RAOF%"=="1" goto fetchEmulators
If "%SFX%"=="1" goto exit
Goto fetchEmulators

:installCores0
Set pkgName=Libretro Cores Pack
Set pkgFile=libretro-cores-pkg.7z
CLS
Cd %SetupDir%
If exist %TMP_DIR%\%pkgFile% goto installCores1
If not exist %emulator_path%\retroarch\. md %emulator_path%\retroarch
If not exist %emulator_path%\retroarch\cores\. md %emulator_path%\retroarch\cores
If not exist %libretro_cores_dir%\. md %libretro_cores_dir%
If not exist %TMP_DIR%\. md %TMP_DIR%
ECHO -- %pkgName% is now downloading --
ECHO.
powershell -command "Invoke-WebRequest -Uri %libretro_cores_pack_url% -OutFile "%TMP_DIR%\%pkgFile%""
If not exist %TMP_DIR%\%pkgFile% goto pkgFail
Goto installCores1

:installCores1
CLS
ECHO -- %pkgName% is installing --
ECHO.
%ZIP_PATH%\7zg.exe -y x "%TMP_DIR%\%pkgFile%" -o"%libretro_cores_dir%" -aoa >nul
ping 127.0.0.1 -n 4 >nul
CLS
GOTO fetchEmulators

:instDOSBox0
Set pkgName=DOSBox
Set pkgFile=dosbox-pkg.zip
CLS
Cd %SetupDir%
If exist %TMP_DIR%\%pkgFile% goto instDOSBox1
If exist %EMULATOR_PATH%\dosbox\dosbox.exe rmdir /s /q %EMULATOR_PATH%\dosbox
If not exist %EMULATOR_PATH%\dosbox\. md %EMULATOR_PATH%\dosbox
If not exist %TMP_DIR%\. md %TMP_DIR%3
ECHO -- %pkgName% is now downloading --
ECHO.
powershell -command "Invoke-WebRequest -Uri %dosbox_url% -OutFile "%TMP_DIR%\%pkgFile%""
If not exist %TMP_DIR%\%pkgFile% goto pkgFail
Goto instDOSBox1

:instDOSBox1
CLS
ECHO -- %pkgName% is installing --
ECHO.
%ZIP_PATH%\7zg.exe -y x "%TMP_DIR%\%pkgFile%" -o"%EMULATOR_PATH%\dosbox" -aoa >nul
ping 127.0.0.1 -n 4 >nul
::del "%TMP_DIR%\%pkgFile%" /q
::rmdir %TMP_DIR%
CLS
GOTO fetchEmulators

:instDolphin0
Set pkgName=Dolphin
Set pkgFile=dolphin-pkg.zip
CLS
Cd %SetupDir%
If exist %TMP_DIR%\%pkgFile% goto instDolphin1
If exist %EMULATOR_PATH%\dolphin-emu\dolphin.exe rmdir /s /q %EMULATOR_PATH%\dolphin-emu
If not exist %EMULATOR_PATH%\dolphin-emu\. md %EMULATOR_PATH%\dolphin-emu
If not exist %TMP_DIR%\. md %TMP_DIR%
ECHO -- %pkgName% is now downloading --
ECHO.
powershell -command "Invoke-WebRequest -Uri %dolphin_url% -OutFile "%TMP_DIR%\%pkgFile%""
If not exist %TMP_DIR%\%pkgFile% goto pkgFail
Goto :instDolphin1

:instDolphin1
CLS
ECHO -- %pkgName% is installing --
ECHO.
%ZIP_PATH%\7zg.exe -y x "%TMP_DIR%\%pkgFile%" -o"%EMULATOR_PATH%\dolphin-emu" -aoa >nul
ping 127.0.0.1 -n 4 >nul
::del "%TMP_DIR%\%pkgFile%" /q
::rmdir %TMP_DIR%
CLS
GOTO fetchEmulators

:instPcsx20
Set pkgName=PCSX2
Set pkgFile=pcsx2-pkg.zip
CLS
Cd %SetupDir%
If exist %TMP_DIR%\%pkgFile% goto instPcsx21
If exist %EMULATOR_PATH%\pcsx2\pcsx2.exe rmdir /s /q %EMULATOR_PATH%\pcsx2
If not exist %EMULATOR_PATH%\pcsx2\. md %EMULATOR_PATH%\pcsx2
If not exist %TMP_DIR%\. md %TMP_DIR%
ECHO -- %pkgName% is now downloading --
ECHO.
powershell -command "Invoke-WebRequest -Uri %pcsx2_url% -OutFile "%TMP_DIR%\%pkgFile%""
If not exist %TMP_DIR%\%pkgFile% goto pkgFail
Goto :instPcsx21

:instPcsx21
CLS
ECHO -- %pkgName% is installing --
ECHO.
%ZIP_PATH%\7zg.exe -y x "%TMP_DIR%\%pkgFile%" -o"%EMULATOR_PATH%\pcsx2" -aoa >nul
ping 127.0.0.1 -n 4 >nul
::del "%TMP_DIR%\%pkgFile%" /q
::rmdir %TMP_DIR%
CLS
GOTO fetchEmulators

:visitRedream
START https://redream.io/download
GOTO fetchEmulators

:visitPpsspp
START https://www.ppsspp.org/downloads.html
GOTO fetchEmulators

:visitJ2K
START https://joytokey.net/en/
GOTO fetchMenu

:visitRetroBat
START https://www.retrobat.ovh
GOTO fetchMenu

:runES
Cls
Cd %SetupDir%
Call %LauncherFile%
Goto exit

:error1
Echo.
ECHO  You must gather your party before venturing forth...
Echo.
timeout /t 5 >nul
GOTO exit

:admin_fail
Echo.
ECHO  Please run this script not as administrator.
Echo.
timeout /t 5 >nul
GOTO exit

:pkgFail
Echo.
Echo  An error occured and package files could not be found. Please try
Echo  update sources in setup main menu.
Echo.
PAUSE
Goto fetchMenu 

:wrongArch
Echo.
ECHO  RetroBat Launcher Scripts only run on 64 bits system.
Echo.
PAUSE>NUL
GOTO exit

:exit
EXIT
