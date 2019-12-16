@Echo off
goto:rem
***************************************
This file is part of RetroBat Scripts. 
***************************************
:rem

:load_config
for /f "delims=" %%x in (..\system\retrobat.setup) do (set "%%x")
set appname=retroarch
set appbin=%appname%.exe
set apppath=%retroarch_dir%\%appbin%
set apparg=--config %retroarch_config_dir%\retroarch.cfg --appendconfig %retroarch_config_dir%\retroarch-override.cfg
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