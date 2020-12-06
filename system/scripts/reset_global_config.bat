@echo off

if exist "%CD%\cmd\showlogo.cmd" (
	call "%CD%\cmd\showlogo.cmd"
) else (
	echo *****************
	echo  RetroBat Script
	echo *****************
)

set userdo=n

echo.
echo ATTENTION: This script will reset emulators to default setting.
echo.
set/p userdo="- Do you want to proceed? (y)es, (n)o: "

if "%userdo%"=="Y" goto proceed
if "%userdo%"=="y" goto proceed
if "%userdo%"=="N" goto exit
if "%userdo%"=="n" goto exit

:proceed
cls
if exist "%CD%\cmd\showlogo.cmd" (
	call "%CD%\cmd\showlogo.cmd"
) else (
	echo *****************
	echo  RetroBat Script
	echo *****************
)
echo Copying config files from templates if they not exists...
%CD%\..\..\retrobat.exe /NOF #GetConfigFiles
echo Injecting presets...
%CD%\..\..\retrobat.exe /NOF #SetEmulatorsSettings
echo Done.
timeout /t 3 >nul
goto exit

:exit

exit

