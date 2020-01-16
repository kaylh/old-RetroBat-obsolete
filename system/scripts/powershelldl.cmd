@echo off
goto:rem
***************************************
This file is part of RetroBat Scripts.
---------------------------------------
file name: powershelldl.cmd
language: batch, powershell
author: Kayl 
***************************************
:rem
powershell -command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12 ; Invoke-WebRequest -Uri %current_url% -OutFile "%output_dir%""
goto:eof