@Echo off
GOTO:REM
************************************************

 RETROBAT LAUNCHER BY KAYL

************************************************
:REM
:setVar0
Set emulator_folder=retroarch
Set emulator_bin=retroarch.exe
Set run_emu=%RUN_RETROARCH%
Goto checkInst

:checkInst
If exist %EMULATOR_PATH%\%emulator_folder%\%emulator_bin% (
	goto runEmu
) else (
	goto notFound
)

:runEmu
%run_emu%
GOTO exit

:notFound
Echo %emulator_bin% is missing. Aborting.
timeout /t 4 >nul
GOTO exit

:exit
EXIT