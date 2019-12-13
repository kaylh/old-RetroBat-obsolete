@echo off
goto:rem
***************************************
This file is part of RetroBat Scripts. 
***************************************
:rem
powershell -command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12 ; Invoke-WebRequest -Uri %current_url% -OutFile "%output_dir%""
goto:eof