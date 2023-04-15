@echo off
mode 1000

set steam_path_default=C:\Program Files (x86)\Steam
set "steam_path=%steam_path_default%"

set game_id=444930
set zaccaria_bin=ZaccariaPinball.exe
set game_bin=%zaccaria_bin%

set kill_steam=0
set delay=14

if exist "%CD%\steam.cfg" (for /f "delims=" %%x in (%CD%\steam.cfg) do (set "%%x"))
"%steam_path%\steam.exe" -nofriendsui -applaunch %game_id% -skipmenu %1 %2 %3 %4 %5 %6 %7 %8
call :timeout

:steamwait
call :tasklist
set delay=3
if %kill_steam% == 1 if %exitcode% == 1 call :timeout & call :taskclose & goto end
if %kill_steam% == 0 if %exitcode% == 1 call :timeout & goto end
call :timeout
goto steamwait

:end
exit

:taskclose
taskkill /f /im steam.exe /t >nul
goto:eof

:tasklist
tasklist|findstr "%game_bin%" > nul
set exitcode=%errorlevel%
goto:eof

:timeout
timeout /t %delay% /nobreak
goto:eof
