@echo off
echo                    ***************************************
echo                    *           Keberos Commit            *
echo                    *            by MypowerHD             *
echo                    ***************************************
echo ******************************************************************************
echo                              Optionen festlegen!
echo ******************************************************************************

:start
set /p branch=Branch: 
if "%branch%" == "" goto start

:commiting
set /p commiting=Commit? y/n: 
if "%commiting%" == "" goto commiting
if '%commiting%'=='n' or '%add%'=='N' (
goto add
)

:commit
set /p commit=Commit Message: 
if "%commit%" == "" goto commit

:add
set /p add=Neue Datein angelegt? y/n:
if "%add%" == "" goto add

:push
set /p push=Pushen? y/n:
if "%push%" == "" goto push

echo ******************************************************************************
echo Current Branch: "%branch%"
if '%commiting%'=='y' or '%add%'=='Y' (
    echo Current Commit Message: "%commit%"
)
echo Neue Datein angelegt?: "%add%"
echo Pushen?: "%push%"
echo Current dir: "%CD%"
echo ******************************************************************************
cd /D %CD%/../../
echo In Hauptverzeichnis gewechselt
sleep 2
REM ADD
if '%add%'=='y' or '%add%'=='Y' (
echo   Add new Files and Folders to Git
    echo ************************************
        git add *
    echo ************************************
)

REM Commit
if '%commiting%'=='y' or '%commiting%'=='Y' (
echo   Fuehre Commit durch.
    echo ************************************
        git commit -am "%commit%"
    echo ************************************
)

REM Pushing to the Git-System
if '%push%'=='y' or '%push%'=='Y' (
    echo   Fuehre Commit durch.
    echo ************************************
        git commit -am "%push%"
    echo ************************************
)

echo ******************************************************************************
echo "Keberos Syncronisation abgeschlossen."
echo ******************************************************************************
sleep 10

