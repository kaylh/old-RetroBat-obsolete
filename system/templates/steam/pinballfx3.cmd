@echo off
mode 1000

set "steamdir=C:\Program Files (x86)\Steam"
set steamgameid=442120
set steamkill=0
set delay=14
"%steamdir%\steam.exe" -nofriendsui -applaunch %steamgameid% -class -table_%1
call :timeout

:steamwait
call :tasklist
set delay=3
if %steamkill% == 1 if %exitcode% == 1 call :timeout & call :taskclose & goto end
if %steamkill% == 0 if %exitcode% == 1 call :timeout & goto end
call :timeout
goto steamwait

:end
exit

:taskclose
taskkill /f /im steam.exe /t >nul
goto:eof

:tasklist
tasklist|findstr "Pinball FX3.exe" > nul
set exitcode=%errorlevel%
goto:eof

:timeout
timeout /t %delay% /nobreak
goto:eof
