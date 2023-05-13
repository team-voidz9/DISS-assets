@echo off
:downloadfront
cls
:::1      DDDDDDDDDDDDD      IIIIIIIIII   SSSSSSSSSSSSSSS    SSSSSSSSSSSSSSS
:::1      D::::::::::::DDD   I::::::::I SS:::::::::::::::S SS:::::::::::::::S
:::1      D:::::::::::::::DD I::::::::IS:::::SSSSSS::::::SS:::::SSSSSS::::::S
:::1      DDD:::::DDDDD:::::DII::::::IIS:::::S     SSSSSSSS:::::S     SSSSSSS
:::1         D:::::D    D:::::D I::::I  S:::::S            S:::::S
:::1         D:::::D     D:::::DI::::I  S:::::S            S:::::S
:::1         D:::::D     D:::::DI::::I   S::::SSSS          S::::SSSS
:::1         D:::::D     D:::::DI::::I    SS::::::SSSSS      SS::::::SSSSS
:::1         D:::::D     D:::::DI::::I      SSS::::::::SS      SSS::::::::SS
:::1         D:::::D     D:::::DI::::I         SSSSSS::::S        SSSSSS::::S
:::1         D:::::D     D:::::DI::::I              S:::::S            S:::::S
:::1         D:::::D    D:::::D I::::I              S:::::S            S:::::S
:::1      DDD:::::DDDDD:::::DII::::::IISSSSSSS     S:::::SSSSSSSS     S:::::S
:::1      D:::::::::::::::DD I::::::::IS::::::SSSSSS:::::SS::::::SSSSSS:::::S
:::1      D::::::::::::DDD   I::::::::IS:::::::::::::::SS S:::::::::::::::SS
:::1       DDDDDDDDDDDDD      IIIIIIIIII SSSSSSSSSSSSSSS    SSSSSSSSSSSSSSS
for /f "delims=:::1 tokens=*" %%A in ('findstr /b :::1 "%~f0"') do @echo(%%A

echo      ====================== DISS Compiler V0.3.1 ========================
echo                          (cfw / bootloader / assets)
echo      1. This script will download needed files (cfw, bootloader and assets)
echo      2. Download and compile everything for you 
echo      3. Backup your SD card if anything FUBAR.
echo.
echo      =============Free Space and an internet connection needed=============
echo.
pause

curl "https://raw.githubusercontent.com/team-voidz/DISS-assets/main/DISS/Lite/DISS_COMPILER.bat" --output %~dp0/DISS_compile.bat
TIMEOUT /T 2

call %~dp0\DISS_compile.bat