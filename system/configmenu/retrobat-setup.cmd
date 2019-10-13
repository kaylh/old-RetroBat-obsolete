@Echo off
taskkill /F /IM emulationstation.exe>nul
GOTO:REM
************************************************

 RETROBAT LAUNCHER BY KAYL

************************************************
:REM
:checkInst
If exist %SETUPDIR%\Setup.bat (
	goto runSetup
) else (
	goto notFound
)

:runSetup
cd %SetupDir%
Start %SETUPDIR%\Setup.bat && exit

:notFound
Echo Setup.bat is missing. Aborting.
timeout /t 4 >nul
GOTO exit

:exit
EXIT