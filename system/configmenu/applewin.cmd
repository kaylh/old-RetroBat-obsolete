@Echo off
goto:rem
***************************************
This file is part of RetroBat Scripts.
***************************************
:rem

:load_config
for /f "delims=" %%x in (..\..\system\retrobat.setup) do (set "%%x")
set appname=applewin
set appbin=%appname%.exe
set apppath=%emulators_dir%\%appname%\%appbin%
:: set apparg=
goto check_setup

:check_setup
If exist %apppath% (
	goto runapp
) else (
	goto notFound
)

:runapp
%apppath% %apparg%
goto exit

:notFound
Echo %appbin% is missing. Aborting.
timeout /t 3 >nul
goto exit

:exit
exit