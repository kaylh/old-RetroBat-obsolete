@echo off
goto:rem
***************************************
This file is part of RetroBat Scripts. 
***************************************
:rem

:dl_fbalpha2012
cls
set current_url=http://buildbot.libretro.com/nightly/windows/x86_64/latest/fbalpha2012_libretro.dll.zip
set output_dir=%temp_dir%\fbalpha2012_libretro.dll.zip
if exist %output_dir% goto install_libretrocores
echo -- Libretro Core is now downloading --
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
set current_url=http://buildbot.libretro.com/nightly/windows/x86_64/latest/fbalpha2012_neogeo_libretro.dll.zip
set output_dir=%temp_dir%\fbalpha2012_neogeo_libretro.dll.zip
if exist %output_dir% goto install_libretrocores
echo -- Libretro Core is now downloading --
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
set current_url=http://buildbot.libretro.com/nightly/windows/x86_64/latest/fbalpha2012_cps1_libretro.dll.zip
set output_dir=%temp_dir%\fbalpha2012_cps1_libretro.dll.zip
if exist %output_dir% goto install_libretrocores
echo -- Libretro Core is now downloading --
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
set current_url=http://buildbot.libretro.com/nightly/windows/x86_64/latest/fbalpha2012_cps2_libretro.dll.zip
set output_dir=%temp_dir%\fbalpha2012_cps2_libretro.dll.zip
if exist %output_dir% goto install_libretrocores
echo -- Libretro Core is now downloading --
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
set current_url=http://buildbot.libretro.com/nightly/windows/x86_64/latest/fbneo_libretro.dll.zip
set output_dir=%temp_dir%\fbneo_libretro.dll.zip
if exist %output_dir% goto install_libretrocores
echo -- Libretro Core is now downloading --
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
set current_url=http://buildbot.libretro.com/nightly/windows/x86_64/latest/mame2003_plus_libretro.dll.zip
set output_dir=%temp_dir%\mame2003_plus_libretro.dll.zip
if exist %output_dir% goto install_libretrocores
echo -- Libretro Core is now downloading --
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
set current_url=http://buildbot.libretro.com/nightly/windows/x86_64/latest/mame2016_libretro.dll.zip
set output_dir=%temp_dir%\mame2016_libretro.dll.zip
if exist %output_dir% goto install_libretrocores
echo -- Libretro Core is now downloading --
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
Echo  An error occured and package files can not be found. Try to update Libretro Cores list.
Echo.
timeout /t 3 >nul
goto exit 

:install_libretrocores
cls
echo -- Libretro Cores are installing --
echo.
%zip_dir%\7zg.exe -y x "%temp_dir%\*.dll.zip" -o"%retroarch_dir%\cores" -aoa
timeout /t 1 >nul
echo Done.
goto:eof