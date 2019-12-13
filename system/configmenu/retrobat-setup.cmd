@echo off
goto:rem
***************************************
This file is part of RetroBat Scripts.
(c) 2017-2019 Adrien Chalard "Kayl" 
***************************************
:rem

taskkill /f /im emulationstation.exe>nul

:load_config
for /f "delims=" %%x in (..\system\retrobat.setup) do (set "%%x")
set appname=setup-new
set appbin=%appname%.bat
set apppath=%setup_dir%\%appbin%
:: set apparg=
goto check_setup

:check_setup
if exist %setup_dir%\%appbin% (
	goto runapp
) else (
	goto notfound
)

:runapp
cd %setup_dir%
%appbin% && exit

:notfound
echo %appbin% is missing. aborting.
timeout /t 3 >nul
goto exit

:exit
exit