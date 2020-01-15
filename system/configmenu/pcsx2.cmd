@echo off
goto:rem
***************************************
This file is part of RetroBat Scripts. 
***************************************
:rem

taskkill /f /im emulationstation.exe>nul

:load_config
for /f "delims=" %%x in (..\..\system\retrobat.setup) do (set "%%x")
set appname=pcsx2
set appbin=%appname%.exe
set apppath=%emulators_dir%\%appname%\%appbin%
set apparg=--portable --cfgpath="%emulators_dir%\pcsx2\config"
goto check_setup

:check_setup
if exist %apppath% (
	goto runapp
) else (
	goto notfound
)

:runapp
%apppath% %apparg%
goto exit

:notfound
echo %appbin% is missing. aborting.
timeout /t 3 >nul
goto exit

:exit
exit