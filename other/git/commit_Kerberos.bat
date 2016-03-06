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
if '%commiting%'=='n' goto add

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

sleep 1
echo Current Branch: "%branch%"
sleep 1
if '%commiting%'=='y' (
    echo Current Commit Message: "%commit%"
sleep 1
)
echo Neue Datein angelegt?: "%add%"
sleep 1
echo Pushen?: "%push%"
sleep 1
echo Current dir: "%CD%"
echo ******************************************************************************
cd /D %CD%/../../
echo In Hauptverzeichnis gewechselt
sleep 2

REM ADD
if '%add%'=='y' (
echo   Add new Files and Folders to Git
    echo ************************************
        git add *
    echo ************************************
)

REM Commit
if '%commiting%'=='y' (
echo   Fuehre Commit durch.
    echo ************************************
        git commit -am "%commit%"
    echo ************************************
)

REM Pushing to the Git-System
if '%push%'=='y' (
echo   Fuehre Push durch.
    echo ************************************
        git push origin %branch%
    echo ************************************
)

echo ******************************************************************************
if '%push%'=='y' (
    echo "Keberos Commit und Push abgeschlossen."
) else (
    echo "Keberos Commit abgeschlossen."
)
echo ******************************************************************************
sleep 10

