@echo off

REM WallCity-Server - WDMYCloud
REM Written by Sebastian Graebner <djcrackhome>
REM Licensed under: THE BEER-WARE LICENSE

chcp 1252>nul 
set ae=ä
set ss=ß
chcp 850>nul 

>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

if '%errorlevel%' NEQ '0' (
    echo WallCity-Server Click N Load
    echo -------------------------------------
    echo Erwarte Administrator-Rechte...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params = %*:"=""
    echo UAC.ShellExecute "cmd.exe", "/c %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"

call :menu

:aktivieren
cls
netsh interface portproxy add v4tov4 listenport=9666 connectaddress=wdmycloud connectport=8000 listenaddress=127.0.0.1 >NUL
echo WallCity-Server Click N Load
echo ------------------------------------------
echo Die Verbindung zu 5.9.143.146 wurde hergestellt.
pause
call :menu

:deaktivieren
cls
netsh interface portproxy delete v4tov4 listenport=9666 listenaddress=127.0.0.1 >NUL
echo WallCity-Server Click N Load
echo ------------------------------------------
echo Die Verbindung zum Server wurde getrennt.
pause
call :menu

:menu
cls
echo WallCity-Server Click N Load
echo -------------------------------------
echo Um Click N Load zu WallCity-Server zu
echo steuern, bitte hier die Einstellung %ae%ndern:
echo[
echo (1) Aktivieren
echo (2) Deaktivieren
echo (3) Schlie%ss%en
echo[
set /p option=Bitte w%ae%hle eine Option aus: 
@if %option% == 1 (
  call :aktivieren
 )else if %option% == 2 (
  call :deaktivieren
 )else if %option% == 3 (
  exit
 ) else (
  call :menu
)