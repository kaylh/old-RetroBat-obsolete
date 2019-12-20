:: --------------------
:: ini.bat
:: ini.bat /? for usage
:: --------------------

@echo off
setlocal enabledelayedexpansion

goto begin

:usage
echo Usage: %~nx0 /i item [/v value] [/s section] inifile
echo;
echo Take the following ini file for example:
echo;
echo    [Config]
echo    password=1234
echo    usertries=0
echo    allowterminate=0
echo;
echo To read the "password" value:
echo    %~nx0 /s Config /i password inifile
echo;
echo To change the "usertries" value to 5:
echo    %~nx0 /s Config /i usertries /v 5 inifile
echo;
echo In the above examples, "/s Config" is optional, but will allow the selection of
echo a specific item where the ini file contains similar items in multiple sections.
goto :EOF

:begin
if "%~1"=="" goto usage
for %%I in (item value section found) do set %%I=
for %%I in (%*) do (
    if defined next (
        if !next!==/i set item=%%I
        if !next!==/v set value=%%I
        if !next!==/s set section=%%I
        set next=
    ) else (
        for %%x in (/i /v /s) do if "%%~I"=="%%x" set "next=%%~I"
        if not defined next (
            set "arg=%%~I"
            if "!arg:~0,1!"=="/" (
                1>&2 echo Error: Unrecognized option "%%~I"
                1>&2 echo;
                1>&2 call :usage
                exit /b 1
            ) else set "inifile=%%~I"
        )
    )
)
for %%I in (item inifile) do if not defined %%I goto usage
if not exist "%inifile%" (
    1>&2 echo Error: %inifile% not found.
    exit /b 1
)

if not defined section (
    if not defined value (
        for /f "usebackq tokens=2 delims==" %%I in (`findstr /i "^%item%\=" "%inifile%"`) do (
            echo(%%I
        )
    ) else (
        for /f "usebackq delims=" %%I in (`findstr /n "^" "%inifile%"`) do (
            set "line=%%I" && set "line=!line:*:=!"
            echo(!line! | findstr /i "^%item%\=" >NUL && (
                1>>"%inifile%.1" echo(%item%=%value%
                echo(%value%
            ) || 1>>"%inifile%.1" echo(!line!
        )
    )
) else (
    for /f "usebackq delims=" %%I in (`findstr /n "^" "%inifile%"`) do (
        set "line=%%I" && set "line=!line:*:=!"
        if defined found (
            if defined value (
                echo(!line! | findstr /i "^%item%\=" >NUL && (
                    1>>"%inifile%.1" echo(%item%=%value%
                    echo(%value%
                    set found=
                ) || 1>>"%inifile%.1" echo(!line!
            ) else echo(!line! | findstr /i "^%item%\=" >NUL && (
                for /f "tokens=2 delims==" %%x in ("!line!") do (
                    echo(%%x
                    exit /b 0
                )
            )
        ) else (
            if defined value (1>>"%inifile%.1" echo(!line!)
            echo(!line! | find /i "[%section%]" >NUL && set found=1
        )
    )
)

if exist "%inifile%.1" move /y "%inifile%.1" "%inifile%">NUL
