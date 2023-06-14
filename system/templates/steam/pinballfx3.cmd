@echo off
mode 1000

FOR /F "tokens=2* skip=2" %%a in ('reg query "HKLM\SOFTWARE\WOW6432Node\Valve\Steam" /v "InstallPath"') DO SET "steam_path=%%b"

set game_id=442120
set pinballfx3_bin=Pinball FX3.exe
set game_bin=%pinballfx3_bin%

set kill_steam=0
set delay=14

if exist "%CD%\steam.cfg" (for /f "delims=" %%x in (%CD%\steam.cfg) do (set "%%x"))
"%steam_path%\steam.exe" -nofriendsui -applaunch %game_id% %2 %3 %4 %1
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
