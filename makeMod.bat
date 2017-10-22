@echo off
setlocal enabledelayedexpansion

if not exist "release\@dorb" mkdir "release\@dorb"
if not exist "release\@dorb\addons" mkdir "release\@dorb\addons"
if not exist "release\@dorb\intercept" mkdir "release\@dorb\intercept"

if "%PROCESSOR_ARCHITECTURE%"=="AMD64" (set armake=tools\armake_w64.exe) else (set armake=tools\armake_w32.exe)

!armake! keygen -f release\Kerberos_0.18

for /d %%f in (servermod\dorb\addons\*) do (
    set folder=%%f
    set name=!folder:servermod\dorb\addons\=!
    echo   PBO  release\@dorb\addons\dorb_!name!.pbo
    !armake! build -i include -w unquoted-string -w redefinition-wo-undef -f !folder! release\@dorb\addons\dorb_!name!.pbo
    !armake! sign -f release\Kerberos_0.18.biprivatekey release\@dorb\addons\dorb_!name!.pbo
)

for /R servermod\dorb\intercept\ %%f in (*.dll) do copy %%f release\@dorb\intercept\ 1>NUL
for /R servermod\dorb\intercept\ %%f in (*.so) do copy %%f release\@dorb\intercept\ 1>NUL


REM !armake! build -p -w unquoted-string -w redefinition-wo-undef -f missions\Operation_Kerberos.Altis release\Operation_Kerberos.Altis.pbo

echo 
ping 127.0.0.1 -n 2 > nul
