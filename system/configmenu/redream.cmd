@Echo off
taskkill /F /IM emulationstation.exe>nul
:setVar0
Set emulator_folder=redream
Set emulator_bin=redream.exe
Set run_emu=%RUN_REDREAM%
Goto checkInst

:checkInst
If exist %EMULATOR_PATH%\%emulator_folder%\%emulator_bin% (
	goto runEmu
) else (
	goto notFound
)

:runEmu
START "" %run_emu%
Goto :eof

:notFound
Echo %emulator_bin% is missing. Aborting.
timeout /t 4 >nul
Goto :eof