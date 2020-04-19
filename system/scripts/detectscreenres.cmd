@echo off
goto:rem
***************************************
file name: detectscreenres.cmd
language: batch
source: https://stackoverflow.com/questions/25594848/batch-get-display-resolution-from-windows-command-line-and-set-variable
edited by Kayl
***************************************
:rem

setlocal
for /f "tokens=4,5 delims=. " %%a in ('ver') do set "version=%%a%%b"


if version lss 62 (
    ::set "wmic_query=wmic desktopmonitor get screenheight, screenwidth /format:value"
    for /f "tokens=* delims=" %%@ in ('wmic desktopmonitor get screenwidth /format:value') do (
        for /f "tokens=2 delims==" %%# in ("%%@") do set "x=%%#"
    )
    for /f "tokens=* delims=" %%@ in ('wmic desktopmonitor get screenheight /format:value') do (
        for /f "tokens=2 delims==" %%# in ("%%@") do set "y=%%#"
    )

) else (
    ::wmic path Win32_VideoController get VideoModeDescription,CurrentVerticalResolution,CurrentHorizontalResolution /format:value
    for /f "tokens=* delims=" %%@ in ('wmic path Win32_VideoController get CurrentHorizontalResolution  /format:value') do (
        for /f "tokens=2 delims==" %%# in ("%%@") do set "x=%%#"
    )
    for /f "tokens=* delims=" %%@ in ('wmic path Win32_VideoController get CurrentVerticalResolution /format:value') do (
        for /f "tokens=2 delims==" %%# in ("%%@") do set "y=%%#"
    )

)

if exist %scripts_dir%\desktop_resolution.info break>%scripts_dir%\desktop_resolution.info
if "%set_screen_resolution%"=="1" echo desktop_xres=%x%>> %scripts_dir%\desktop_resolution.info
if "%set_screen_resolution%"=="1" echo desktop_yres=%y%>> %scripts_dir%\desktop_resolution.info
for /f "delims=" %%x in (%scripts_dir%\desktop_resolution.info) do (set "%%x")
REM if "%force_screen_res%"=="1" echo Detected desktop resolution: %desktop_xres%x%desktop_yres%

endlocal
goto:eof