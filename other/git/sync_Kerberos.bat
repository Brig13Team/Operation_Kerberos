@echo off
echo ***************************************
echo *       Keberos Syncronisation        *
echo *            by MypowerHD             *
echo ***************************************

:start
set /p branch=Branch: 
if "%branch%" == "" goto start
echo ******************************************************************************
echo Current Branch: "%branch%"
echo Current dir: "%CD%"
echo ******************************************************************************
cd /D %CD%/../../
echo "In Hauptverzeichnis gewechselt"
sleep 2
echo "Fuehre Syncronisation durch."
echo ******************************************************************************
git fetch origin %branch%
git merge
echo ******************************************************************************
echo "Keberos Syncronisation abgeschlossen."
echo ******************************************************************************
sleep 10

