@echo off
goto:rem
***************************************
This file is part of RetroBat Scripts.
---------------------------------------
file name: lr-arcade.cmd
language: batch
author: Kayl 
***************************************
:rem

:dl_fbalpha2012
cls
set core_name=fbalpha2012
If %PROCARCH%==32 set current_url=http://buildbot.libretro.com/nightly/windows/x86/latest/%core_name%_libretro.dll.zip
If %PROCARCH%==64 set current_url=http://buildbot.libretro.com/nightly/windows/x86_64/latest/%core_name%_libretro.dll.zip
set output_dir=%temp_dir%\%core_name%_libretro.dll.zip
if exist %output_dir% goto install_libretrocores
echo -- Libretro Core is now downloading ( %core_name% ) --
echo.
call %scripts_dir%\powershelldl.cmd
if %ERRORLEVEL% == 1 goto pkg_fail
ping 127.0.0.1 -n 4 >nul
echo Done.
if "%fullinstall%"=="1" (
	goto dl_fbalpha2012_neogeo
) else (
	goto install_libretrocores
)

:dl_fbalpha2012_neogeo
cls
set core_name=fbalpha2012_neogeo
If %PROCARCH%==32 set current_url=http://buildbot.libretro.com/nightly/windows/x86/latest/%core_name%_libretro.dll.zip
If %PROCARCH%==64 set current_url=http://buildbot.libretro.com/nightly/windows/x86_64/latest/%core_name%_libretro.dll.zip
set output_dir=%temp_dir%\%core_name%_libretro.dll.zip
if exist %output_dir% goto install_libretrocores
echo -- Libretro Core is now downloading ( %core_name% ) --
echo.
call %scripts_dir%\powershelldl.cmd
if %ERRORLEVEL% == 1 goto pkg_fail
ping 127.0.0.1 -n 4 >nul
echo Done.
if "%fullinstall%"=="1" (
	goto dl_fbalpha2012_cps1
) else (
	goto install_libretrocores
)

:dl_fbalpha2012_cps1
cls
set core_name=fbalpha2012_cps1
If %PROCARCH%==32 set current_url=http://buildbot.libretro.com/nightly/windows/x86/latest/%core_name%_libretro.dll.zip
If %PROCARCH%==64 set current_url=http://buildbot.libretro.com/nightly/windows/x86_64/latest/%core_name%_libretro.dll.zip
set output_dir=%temp_dir%\%core_name%_libretro.dll.zip
if exist %output_dir% goto install_libretrocores
echo -- Libretro Core is now downloading ( %core_name% ) --
echo.
call %scripts_dir%\powershelldl.cmd
if %ERRORLEVEL% == 1 goto pkg_fail
ping 127.0.0.1 -n 4 >nul
echo Done.
if "%fullinstall%"=="1" (
	goto dl_fbalpha2012_cps2
) else (
	goto install_libretrocores
)

:dl_fbalpha2012_cps2
cls
set core_name=fbalpha2012_cps2
If %PROCARCH%==32 set current_url=http://buildbot.libretro.com/nightly/windows/x86/latest/%core_name%_libretro.dll.zip
If %PROCARCH%==64 set current_url=http://buildbot.libretro.com/nightly/windows/x86_64/latest/%core_name%_libretro.dll.zip
set output_dir=%temp_dir%\%core_name%_libretro.dll.zip
if exist %output_dir% goto install_libretrocores
echo -- Libretro Core is now downloading ( %core_name% ) --
echo.
call %scripts_dir%\powershelldl.cmd
if %ERRORLEVEL% == 1 goto pkg_fail
ping 127.0.0.1 -n 4 >nul
echo Done.
if "%fullinstall%"=="1" (
	goto dl_fbneo
) else (
	goto install_libretrocores
)

:dl_fbneo
cls
set core_name=fbneo
If %PROCARCH%==32 set current_url=http://buildbot.libretro.com/nightly/windows/x86/latest/%core_name%_libretro.dll.zip
If %PROCARCH%==64 set current_url=http://buildbot.libretro.com/nightly/windows/x86_64/latest/%core_name%_libretro.dll.zip
set output_dir=%temp_dir%\%core_name%_libretro.dll.zip
if exist %output_dir% goto install_libretrocores
echo -- Libretro Core is now downloading ( %core_name% ) --
echo.
call %scripts_dir%\powershelldl.cmd
if %ERRORLEVEL% == 1 goto pkg_fail
ping 127.0.0.1 -n 4 >nul
echo Done.
if "%fullinstall%"=="1" (
	goto dl_mame2003_plus
) else (
	goto install_libretrocores
)

:dl_mame2003_plus
cls
set core_name=mame2003_plus
If %PROCARCH%==32 set current_url=http://buildbot.libretro.com/nightly/windows/x86/latest/%core_name%_libretro.dll.zip
If %PROCARCH%==64 set current_url=http://buildbot.libretro.com/nightly/windows/x86_64/latest/%core_name%_libretro.dll.zip
set output_dir=%temp_dir%\%core_name%_libretro.dll.zip
if exist %output_dir% goto install_libretrocores
echo -- Libretro Core is now downloading ( %core_name% ) --
echo.
call %scripts_dir%\powershelldl.cmd
if %ERRORLEVEL% == 1 goto pkg_fail
ping 127.0.0.1 -n 4 >nul
echo Done.
if "%fullinstall%"=="1" (
	goto dl_mame2016
) else (
	goto install_libretrocores
)

:dl_mame2016
cls
set core_name=mame2016
If %PROCARCH%==32 set current_url=http://buildbot.libretro.com/nightly/windows/x86/latest/%core_name%_libretro.dll.zip
If %PROCARCH%==64 set current_url=http://buildbot.libretro.com/nightly/windows/x86_64/latest/%core_name%_libretro.dll.zip
set output_dir=%temp_dir%\%core_name%_libretro.dll.zip
if exist %output_dir% goto install_libretrocores
echo -- Libretro Core is now downloading ( %core_name% ) --
echo.
call %scripts_dir%\powershelldl.cmd
if %ERRORLEVEL% == 1 goto pkg_fail
ping 127.0.0.1 -n 4 >nul
echo Done.
if "%fullinstall%"=="1" (
	goto install_libretrocores
) else (
	goto install_libretrocores
)

:pkg_fail
cls
Echo.
Echo  An error occured and package files can not be found.
Echo.
timeout /t 3 >nul
if exist %temp_dir%\*.dll.zip goto install_libretrocores
goto exit 

:exit
exit 

:install_libretrocores
cls
echo -- Libretro Cores are installing --
echo.
if exist %temp_dir%\*.dll.zip %zip_dir%\7zg.exe -y x "%temp_dir%\*.dll.zip" -o"%retroarch_dir%\cores" -aoa
timeout /t 1 >nul
if exist %temp_dir%\*.dll.zip del/Q %temp_dir%\*.dll.zip>nul
echo Done.
cls
goto:eof