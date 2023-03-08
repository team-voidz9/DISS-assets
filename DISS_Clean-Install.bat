@echo off
chcp 866 >nul 2>&1

COLOR 0F

set sd=%1
if not defined %sd% (GOTO pickSD)

:initialcheck
if exist DISS_OLDSD.zip (DEL /Q /F DISS_OLDSD.zip) 
if exist DISS_ABC.zip (DEL /Q /F DISS_ABC.zip) 
if exist DISS_A\temp0 (DEL /Q /F DISS_A\temp0)
md %~dp0\DISS_A
md %~dp0\DISS_A\temp0
md %~dp0\DISS_A\trash
md %~dp0\DISS_B
md %~dp0\DISS

:main
COLOR 02
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

echo      ====================== DISS Downloader V0.1.0 ========================
echo                          (cfw / bootloader / assets)
echo      1. This script will download needed files (cfw, bootloader and assets)
echo      2. Clean and backup the files/folders in your SD and Install a new one
echo.
echo      =============Free Space and an internet connection needed=============
echo.
echo.
echo Press Y to start. Press N to exit
set st=
set /p st=": "

for %%A in ("Y" "y" "1" "н" "Н") do if "%st%"==%%A (GOTO pickSD)
for %%A in ("N" "n" "2" "т" "Т") do if "%st%"==%%A (GOTO exit)

:pickSD
cls
echo.
echo Please Choose correct SD card drive letter


for /f "tokens=3-6 delims=: " %%a in ('WMIC LOGICALDISK GET FreeSpace^,Name^,Size^,filesystem^,description ^|FINDSTR /I "Removable" ^|findstr /i "exfat fat32"') do (@echo wsh.echo "Disk letter: %%c;" ^& " free: " ^& FormatNumber^(cdbl^(%%b^)/1024/1024/1024, 2^)^& " GB;"^& " size: " ^& FormatNumber^(cdbl^(%%d^)/1024/1024/1024, 2^)^& " GB;" ^& " FS: %%a" > %temp%\tmp.vbs & @if not "%%c"=="" @echo( & @cscript //nologo %temp%\tmp.vbs & del %temp%\tmp.vbs)
echo.
set /P sd="Enter SD card drive letter: "

if not exist "%sd%:\" (
	set word=        There is no SD card in %sd%-drive         
	goto WRONGSD
) else (
	if not exist "%sd%:\*" (goto WRONGSD)
)

:download0
COLOR 0f
cls
echo.
ECHO ----------------------------------------------------------
ECHO ======                 DISS Downloader               =====
ECHO ======           Assets / Bootloader / CFW           =====
ECHO ----------------------------------------------------------
ECHO.
set filepath="%~dp0\DISS_A\atmosphere-*.zip"
for /F "delims=" %%i in (%filepath%) do set basename="%%~ni"       
IF EXIST "%~dp0\DISS_A\atmosphere-*.zip" (
echo                   CFW and SIGPATCHES READY! [4MB done!]
echo                   %basename%
) ELSE (
echo                [NO] CFW and SIGPATCHES files detected   
echo                Press 1 to download          
)
echo.
set filepath="%~dp0\DISS_A\hekate_ctcaer*.zip"
for /F "delims=" %%i in (%filepath%) do set basename="%%~ni"
IF EXIST "%~dp0\DISS_A\hekate_ctcaer*" (
echo                   Bootloader File READY! [1MB done!]
echo                   %basename%
) ELSE (
echo                [NO] Bootloader Files detected
echo                Press 2 to download  
)
echo.
set filepath="%~dp0\DISS_A\assets_*.zip"
for /F "delims=" %%i in (%filepath%) do set basename="%%~ni"
IF EXIST "%~dp0\DISS_A\assets_*.zip" (
echo                   DISS Assets File READY! [80MB done!]
echo                   %basename%
) ELSE (
echo                [NO] Assets Files detected
echo                Press 3 to download  
)
echo.
IF EXIST "%~dp0\DISS_A\hekate\payload.bin" (
echo                   cfw / bootloader / assets [extracted!]
echo.
echo            5.  Install Now
) ELSE (
echo            4.  Extract cfw / bootloader / assets
)

ECHO.
ECHO =Please Download all the required files before extracting=
ECHO ==========================================================
ECHO                                        6.  Delete OLD .zip
ECHO                                        7.  exit
echo                                        0.  Download ALL 
ECHO.

set st=
set /p st="Enter Your number of choice: "
for %%A in ("0" "o" "O" "0" "0") do if "%st%"==%%A (GOTO downloadALL)
for %%A in ("Y" "y" "1" "н" "Н") do if "%st%"==%%A (GOTO download1)
for %%A in ("N" "n" "2" "т" "Т") do if "%st%"==%%A (GOTO download2)
for %%A in ("3" "#" "3" "3" "3") do if "%st%"==%%A (GOTO download3)
for %%A in ("$" "4" "4" "4" "4") do if "%st%"==%%A (GOTO unpack)
for %%A in ("5" "5" "5" "5" "5") do if "%st%"==%%A (GOTO startpoint)
for %%A in ("6" "^" "6" "6" "6") do if "%st%"==%%A (GOTO delete1)
for %%A in ("7" "&" "7" "7") do if "%st%"==%%A (GOTO ENDnotgood)
for %%A in ("" "" "" "") do if "%st%"==%%A (GOTO ENDnotgood)


:downloadXX
COLOR 0f
cls
echo.
ECHO ----------------------------------------------------------
ECHO ======                 DISS Downloader               =====
ECHO ======           Assets / Bootloader / CFW           =====
ECHO ----------------------------------------------------------
ECHO         Assets, Bootloader, and CFW are extracted
echo                       and READY!
echo.
echo.                   5.  Install Now
echo.
ECHO ==========================================================
ECHO.
ECHO                                        7.  exit
ECHO.

set st=
set /p st="Enter Your number of choice: "
for %%A in ("5" "5" "5" "5" "5") do if "%st%"==%%A (GOTO startpoint)
for %%A in ("7" "&" "7" "7") do if "%st%"==%%A (GOTO exit)
for %%A in ("" "" "" "") do if "%st%"==%%A (GOTO exit)

:downloadALL
for /f "tokens=1,* delims=:" %%A in ('curl -ks https://api.github.com/repos/Atmosphere-NX/Atmosphere/releases/latest ^| find "browser_download_url"') do (
    curl -kOL %%B
)

if exist "%~dp0\atmosphere-*.zip" (
    move "%~dp0\atmosphere-*.zip" "%~dp0\DISS_A\"
    )

if exist "%~dp0\fusee.bin" (
    rename %~dp0\fusee.bin fusee.bin.diss2
    move "%~dp0\fusee.bin.diss2" "%~dp0\DISS_A\temp0\fusee.bin.diss2"
    )

curl "https://sigmapatches.coomer.party/sigpatches.zip" --output sigpatches.zip

if exist "%~dp0\sigpatches.zip" (
    move "%~dp0\sigpatches.zip" "%~dp0\DISS_A\sigpatches.zip"
    )
echo.
echo            Downloading CFW and Sigpatches is done!
echo.
TIMEOUT /T 3

for /f "tokens=1,* delims=:" %%A in ('curl -ks https://api.github.com/repos/CTCaer/hekate/releases/latest ^| find "browser_download_url"') do (
    curl -kOL %%B
)

if exist "%~dp0\hekate_*.zip" (
    move "%~dp0\hekate_*.zip" "%~dp0\DISS_A\"
    )
if exist "%~dp0\joiner_scripts_*.zip" (
    move "%~dp0\joiner_scripts_*.zip" "%~dp0\DISS_A\trash\"
    )
if exist "%~dp0\nyx_usb_*.reg" (
    move "%~dp0\nyx_usb_*.reg" "%~dp0\DISS_A\trash\"
    )

echo.
echo            Downloading Bootloader is done!
echo.
TIMEOUT /T 3

for /f "tokens=1,* delims=:" %%A in ('curl -ks https://api.github.com/repos/team-voidz/DISS-assets/releases/latest ^| find "browser_download_url"') do (
    curl -kOL %%B
)
if exist "%~dp0\assets_*.zip" (
    move "%~dp0\assets_*.zip" "%~dp0\DISS_A\"
    )

for /f "tokens=1,* delims=:" %%A in ('curl -ks https://api.github.com/repos/tomvita/Breeze-Beta/releases/latest ^| find "browser_download_url"') do (
    curl -kOL %%B
)

powershell -command "Expand-Archive -LiteralPath %~dp0/breeze.zip -Destination %~dp0/DISS_A/temp1/" -verbose -force

if exist "%~dp0\version.txt" (
    move "%~dp0\version.txt" "%~dp0\DISS_A\trash\"
    )
if exist "%~dp0\breeze.zip" (
    move "%~dp0\breeze.zip" "%~dp0\DISS_A\trash\"
    )

for /f "tokens=1,* delims=:" %%A in ('curl -ks https://api.github.com/repos/WerWolv/EdiZon/releases/latest ^| find "browser_download_url"') do (
    curl -kOL %%B
)
if exist "%~dp0\Edizon.nro" (
    md "%~dp0\DISS_A\temp1\switch\EdiZon\"
    move "%~dp0\Edizon.nro" "%~dp0\DISS_A\temp1\switch\EdiZon\"
    )
if exist "%~dp0\ovlEdizon.ovl" (
    md "%~dp0\DISS_A\temp1\switch\.overlays\"
    move "%~dp0\ovlEdizon.ovl" "%~dp0\DISS_A\temp1\switch\EdiZon\"
    )

for /f "tokens=1,* delims=:" %%A in ('curl -ks https://api.github.com/repos/DarkMatterCore/nxdumptool/releases/latest ^| find "browser_download_url"') do (
    curl -kOL %%B
)
if exist "%~dp0\nxdumptool.nro" (
    md "%~dp0\DISS_A\temp1\switch\nxdumptool\"
    move "%~dp0\nxdumptool.nro" "%~dp0\DISS_A\temp1\switch\nxdumptool\"
    )

for /f "tokens=1,* delims=:" %%A in ('curl -ks https://api.github.com/repos/rashevskyv/dbi/releases/latest ^| find "browser_download_url"') do (
    curl -kOL %%B
)
if exist "%~dp0\dbi.nro" (
    move "%~dp0\dbi.nro" "%~dp0\DISS_A\temp1\switch\"
    )
if exist "%~dp0\dbi.config" (
    move "%~dp0\dbi.config" "%~dp0\DISS_A\temp1\switch\"
    )
if exist "%~dp0\dbibackend.exe" (
    move "%~dp0\dbibackend.exe" "%~dp0\DISS_A\trash\"
    )
if exist "%~dp0\DBI_ru.nro" (
    move "%~dp0\DBI_ru.nro" "%~dp0\DISS_A\trash\"
    )
if exist "%~dp0\dbibackend.tar.xz" (
    move "%~dp0\dbibackend.tar.xz" "%~dp0\DISS_A\trash\"
    )

for /f "tokens=1,* delims=:" %%A in ('curl -ks https://api.github.com/repos/J-D-K/JKSV/releases/latest ^| find "browser_download_url"') do (
    curl -kOL %%B
)
if exist "%~dp0\jksv.nro" (
    move "%~dp0\jksv.nro" "%~dp0\DISS_A\temp1\switch\"
    )

for /f "tokens=1,* delims=:" %%A in ('curl -ks https://api.github.com/repos/meganukebmp/Switch_90DNS_tester/releases/latest ^| find "browser_download_url"') do (
    curl -kOL %%B
)
if exist "%~dp0\Switch_90DNS_tester.nro" (
    move "%~dp0\Switch_90DNS_tester.nro" "%~dp0\DISS_A\temp1\switch\"
    )

for /f "tokens=1,* delims=:" %%A in ('curl -ks https://api.github.com/repos/rdmrocha/linkalho/releases/latest ^| find "browser_download_url"') do (
    curl -kOL %%B
)
powershell -command "Expand-Archive %~dp0/linkalho-*.zip %~dp0/DISS_A/temp1/switch" -verbose -force
if exist "%~dp0\linkalho-*.zip" (
    move "%~dp0\linkalho-*.zip" "%~dp0\DISS_A\trash\"
    )

for /f "tokens=1,* delims=:" %%A in ('curl -ks https://api.github.com/repos/ITotalJustice/Gamecard-Installer-NX/releases/latest ^| find "browser_download_url"') do (
    curl -kOL %%B
)
powershell -command "Expand-Archive %~dp0/gamecard_installer.zip %~dp0/DISS_A/temp1" -verbose -force
if exist "%~dp0\gamecard_installer.zip " (
    move "%~dp0\gamecard_installer.zip " "%~dp0\DISS_A\trash\"
    )

echo.
echo            Downloading Assets is done!
echo.
TIMEOUT /T 3
goto download0

:download1
for /f "tokens=1,* delims=:" %%A in ('curl -ks https://api.github.com/repos/Atmosphere-NX/Atmosphere/releases/latest ^| find "browser_download_url"') do (
    curl -kOL %%B
)

if exist "%~dp0\atmosphere-*.zip" (
    move "%~dp0\atmosphere-*.zip" "%~dp0\DISS_A\"
    )

if exist "%~dp0\fusee.bin" (
    rename %~dp0\fusee.bin fusee.bin.diss2
    move "%~dp0\fusee.bin.diss2" "%~dp0\DISS_A\temp0\fusee.bin.diss2"
    )

curl "https://sigmapatches.coomer.party/sigpatches.zip" --output sigpatches.zip

if exist "%~dp0\sigpatches.zip" (
    move "%~dp0\sigpatches.zip" "%~dp0\DISS_A\sigpatches.zip"
    )
echo.
echo            Downloading CFW and Sigpatches is done!
echo.
TIMEOUT /T 3
goto download0

:download2
for /f "tokens=1,* delims=:" %%A in ('curl -ks https://api.github.com/repos/CTCaer/hekate/releases/latest ^| find "browser_download_url"') do (
    curl -kOL %%B
)

if exist "%~dp0\hekate_*.zip" (
    move "%~dp0\hekate_*.zip" "%~dp0\DISS_A\"
    )
if exist "%~dp0\joiner_scripts_*.zip" (
    move "%~dp0\joiner_scripts_*.zip" "%~dp0\DISS_A\trash\"
    )
if exist "%~dp0\nyx_usb_*.reg" (
    move "%~dp0\nyx_usb_*.reg" "%~dp0\DISS_A\trash\"
    )

echo.
echo            Downloading Bootloader is done!
echo.
TIMEOUT /T 3
goto download0

:download3
for /f "tokens=1,* delims=:" %%A in ('curl -ks https://api.github.com/repos/team-voidz/DISS-assets/releases/latest ^| find "browser_download_url"') do (
    curl -kOL %%B
)
if exist "%~dp0\assets_*.zip" (
    move "%~dp0\assets_*.zip" "%~dp0\DISS_A\"
    )

for /f "tokens=1,* delims=:" %%A in ('curl -ks https://api.github.com/repos/tomvita/Breeze-Beta/releases/latest ^| find "browser_download_url"') do (
    curl -kOL %%B
)

powershell -command "Expand-Archive %~dp0/breeze.zip %~dp0/DISS_A/temp1/" -verbose -force


if exist "%~dp0\version.txt" (
    move "%~dp0\version.txt" "%~dp0\DISS_A\trash\"
    )
if exist "%~dp0\breeze.zip" (
    move "%~dp0\breeze.zip" "%~dp0\DISS_A\trash\"
    )

for /f "tokens=1,* delims=:" %%A in ('curl -ks https://api.github.com/repos/WerWolv/EdiZon/releases/latest ^| find "browser_download_url"') do (
    curl -kOL %%B
)
if exist "%~dp0\Edizon.nro" (
    md "%~dp0\DISS_A\temp1\switch\EdiZon\"
    move "%~dp0\Edizon.nro" "%~dp0\DISS_A\temp1\switch\EdiZon\"
    )
if exist "%~dp0\ovlEdizon.ovl" (
    md "%~dp0\DISS_A\temp1\switch\.overlays\"
    move "%~dp0\ovlEdizon.ovl" "%~dp0\DISS_A\temp1\switch\EdiZon\"
    )

for /f "tokens=1,* delims=:" %%A in ('curl -ks https://api.github.com/repos/DarkMatterCore/nxdumptool/releases/latest ^| find "browser_download_url"') do (
    curl -kOL %%B
)
if exist "%~dp0\nxdumptool.nro" (
    md "%~dp0\DISS_A\temp1\switch\nxdumptool\"
    move "%~dp0\nxdumptool.nro" "%~dp0\DISS_A\temp1\switch\nxdumptool\"
    )

for /f "tokens=1,* delims=:" %%A in ('curl -ks https://api.github.com/repos/rashevskyv/dbi/releases/latest ^| find "browser_download_url"') do (
    curl -kOL %%B
)
if exist "%~dp0\dbi.nro" (
    move "%~dp0\dbi.nro" "%~dp0\DISS_A\temp1\switch\"
    )
if exist "%~dp0\dbi.config" (
    move "%~dp0\dbi.config" "%~dp0\DISS_A\temp1\switch\"
    )
if exist "%~dp0\dbibackend.exe" (
    move "%~dp0\dbibackend.exe" "%~dp0\DISS_A\trash\"
    )
if exist "%~dp0\DBI_ru.nro" (
    move "%~dp0\DBI_ru.nro" "%~dp0\DISS_A\trash\"
    )
if exist "%~dp0\dbibackend.tar.xz" (
    move "%~dp0\dbibackend.tar.xz" "%~dp0\DISS_A\trash\"
    )

for /f "tokens=1,* delims=:" %%A in ('curl -ks https://api.github.com/repos/J-D-K/JKSV/releases/latest ^| find "browser_download_url"') do (
    curl -kOL %%B
)
if exist "%~dp0\jksv.nro" (
    move "%~dp0\jksv.nro" "%~dp0\DISS_A\temp1\switch\"
    )

for /f "tokens=1,* delims=:" %%A in ('curl -ks https://api.github.com/repos/meganukebmp/Switch_90DNS_tester/releases/latest ^| find "browser_download_url"') do (
    curl -kOL %%B
)
if exist "%~dp0\Switch_90DNS_tester.nro" (
    move "%~dp0\Switch_90DNS_tester.nro" "%~dp0\DISS_A\temp1\switch\"
    )

for /f "tokens=1,* delims=:" %%A in ('curl -ks https://api.github.com/repos/rdmrocha/linkalho/releases/latest ^| find "browser_download_url"') do (
    curl -kOL %%B
)
powershell -command "Expand-Archive %~dp0/linkalho-*.zip %~dp0/DISS_A/temp1/switch" -verbose -force
if exist "%~dp0\linkalho-*.zip" (
    move "%~dp0\linkalho-*.zip" "%~dp0\DISS_A\trash\"
    )

for /f "tokens=1,* delims=:" %%A in ('curl -ks https://api.github.com/repos/ITotalJustice/Gamecard-Installer-NX/releases/latest ^| find "browser_download_url"') do (
    curl -kOL %%B
)
powershell -command "Expand-Archive %~dp0/gamecard_installer.zip %~dp0/DISS_A/temp1" -verbose -force
if exist "%~dp0\gamecard_installer.zip " (
    move "%~dp0\gamecard_installer.zip " "%~dp0\DISS_A\trash\"
    )

echo.
echo            Downloading Assets is done!
echo.
TIMEOUT /T 3
goto download0

:unpack
if exist "%~dp0\DISS" (RD /s /q "%~dp0\DISS")

if exist "%~dp0\DISS_A\atmosphere-*.zip" (
    rename %~dp0\DISS_A\atmosphere-*.zip jits.zip
    )
if exist "%~dp0\DISS_A\hekate_*.zip" (
    rename %~dp0\DISS_A\hekate_*.zip hekate.zip
    )
if exist "%~dp0\DISS_A\assets_*.zip" (
    rename %~dp0\DISS_A\assets_*.zip assets.zip
    )
powershell -command "Expand-Archive %~dp0/DISS_A/assets.zip %~dp0/DISS_A/assets" -verbose -Force

if exist "%~dp0\DISS_A\assets\gear\boot.dat" (
    copy "%~dp0\DISS_A\assets\gear\boot.dat" "%~dp0\DISS_A\temp0\boot.dat.diss"
    )
if exist "%~dp0\DISS_A\assets\gear\boot.ini" (
    copy "%~dp0\DISS_A\assets\gear\boot.ini" "%~dp0\DISS_A\temp0\boot.ini.diss"
    )
if exist "%~dp0\DISS_A\assets\gear\exosphere.ini" (
    copy "%~dp0\DISS_A\assets\gear\exosphere.ini" "%~dp0\DISS_A\temp0\exosphere.ini.diss"
    )

powershell -command "Expand-Archive %~dp0/DISS_A/hekate.zip %~dp0/DISS_A/hekate" -verbose -Force
if exist "%~dp0\DISS_A\hekate\hekate_*.bin" (
    rename %~dp0\DISS_A\hekate\hekate_*.bin payload.bin
    copy "%~dp0\DISS_A\hekate\payload.bin" "%~dp0\DISS_A\hekate\bootloader\payloads\hekate.bin"
    )
if exist "%~dp0\DISS_A\hekate\payload.bin" (
    copy "%~dp0\DISS_A\hekate\payload.bin" "%~dp0\DISS_A\temp0\payload.bin.diss"
    )

powershell -command "Expand-Archive %~dp0/DISS_A/jits.zip %~dp0/DISS_A/cfw" -verbose -Force
if exist "%~dp0\DISS_A\temp0\fusee.bin.diss2" (
    rename %~dp0\DISS_A\temp0\fusee.bin.diss2 fusee.bin
    move "%~dp0\DISS_A\temp0\fusee.bin" "%~dp0\DISS_A\cfw\fusee.bin"
    )
if exist "%~dp0\DISS_A\cfw\fusee.bin" (
    copy "%~dp0\DISS_A\cfw\fusee.bin" "%~dp0\DISS_A\temp0\fusee.bin.diss"
    )
if exist "%~dp0\DISS_A\cfw\fusee.bin" (
    copy "%~dp0\DISS_A\cfw\fusee.bin" "%~dp0\DISS_A\hekate\bootloader\payloads\fusee.bin"
    )
if exist "%~dp0\DISS_A\cfw\hbmenu.nro" (
    copy "%~dp0\DISS_A\cfw\hbmenu.nro" "%~dp0\DISS_A\temp0\hbmenu.nro.diss"
    )
powershell -command "Expand-Archive %~dp0/DISS_A/sigpatches.zip %~dp0/DISS_A/cfw" -verbose -Force
echo.
ECHO  Extracting Assets, Bootloader, CFW is done!
echo.
TIMEOUT /T 3
goto downloadXX

:startpoint
COLOR 0f
cls
echo ------------------------------------------------------------------------
echo           STEP 1
:::2           _______                                                   
:::2          /       \                                                  
:::2          $$$$$$$  | ______  _____  ____   ______  __     __ ______  
:::2          $$ |__$$ |/      \/     \/    \ /      \/  \   /  /      \ 
:::2          $$    $$</$$$$$$  $$$$$$ $$$$  /$$$$$$  $$  \ /$$/$$$$$$  |
:::2          $$$$$$$  $$    $$ $$ | $$ | $$ $$ |  $$ |$$  /$$/$$    $$ |
:::2          $$ |  $$ $$$$$$$$/$$ | $$ | $$ $$ \__$$ | $$ $$/ $$$$$$$$/ 
:::2          $$ |  $$ $$       $$ | $$ | $$ $$    $$/   $$$/  $$       |
:::2          $$/   $$/ $$$$$$$/$$/  $$/  $$/ $$$$$$/     $/    $$$$$$$/ 
                                                           
for /f "delims=:::2 tokens=*" %%A in ('findstr /b :::2 "%~f0"') do @echo(%%A
echo ------------------------------------------------------------------------
echo.
TIMEOUT /T 3

robocopy %sd%:\ %~dp0\DISS_B\ /E /COPYALL /PURGE /XD %sd%:\emuMMC %sd%:\backup %sd%:\games %sd%:\DISS %sd%:\DISS_A %sd%:\DISS_B %sd%:\Firmware /XF %sd%:\DISS_Clean_Install.bat %sd%:\DISS_OLDSD.zip %sd%:\DISS_ABC.zip

powershell -command "Compress-Archive -Path %~dp0/DISS_B -Destination %~dp0/DISS_OLDSD.zip" -verbose -Force
echo.
echo.
echo.
echo.
ECHO       Please Wait.

if exist "%sd%:\atmosphere" (RD /s /q "%sd%:\atmosphere")
if exist "%sd%:\bootloader" (RD /s /q "%sd%:\bootloader")
if exist "%sd%:\config" (RD /s /q "%sd%:\config")
if exist "%sd%:\emuiibo" (RD /s /q "%sd%:\emuiibo")
if exist "%sd%:\Installer" (RD /s /q "%sd%:\Installer")
if exist "%sd%:\switch" (RD /s /q "%sd%:\switch")
if exist "%sd%:\tegraexplorer" (RD /s /q "%sd%:\tegraexplorer")
if exist "%sd%:\warmboot_mariko" (RD /s /q "%sd%:\warmboot_mariko")
if exist "%sd%:\sxos" (RD /s /q "%sd%:\sxos")
if exist "%sd%:\exosphere.ini" (del /s /q "%sd%:\exosphere.ini")
if exist "%sd%:\fusee.bin" (del /s /q "%sd%:\fusee.bin")
if exist "%sd%:\payload.bin" (del /s /q "%sd%:\payload.bin")
if exist "%sd%:\boot.dat" (del /s /q "%sd%:\boot.dat")
if exist "%sd%:\boot.ini" (del /s /q "%sd%:\boot.ini")
if exist "%sd%:\hbmenu.nro" (del /s /q "%sd%:\hbmenu.nro")
echo.
echo                     Old File(s) Removed from SD
echo.
TIMEOUT /T 2

:install
cls
echo ------------------------------------------------------------------------
echo            STEP 2
::::3           /      |                   /  |            /  /  |
::::3           $$$$$$/ _______   _______ _$$ |_    ______ $$ $$ |
::::3             $$ | /       \ /       / $$   |  /      \$$ $$ |
::::3             $$ | $$$$$$$  /$$$$$$$/$$$$$$/   $$$$$$  $$ $$ |
::::3             $$ | $$ |  $$ $$      \  $$ | __ /    $$ $$ $$ |
::::3            _$$ |_$$ |  $$ |$$$$$$  | $$ |/  /$$$$$$$ $$ $$ |
::::3           / $$   $$ |  $$ /     $$/  $$  $$/$$    $$ $$ $$ |
::::3           $$$$$$/$$/   $$/$$$$$$$/    $$$$/  $$$$$$$/$$/$$
                                                           
for /f "delims=::::3 tokens=*" %%A in ('findstr /b ::::3 "%~f0"') do @echo(%%A
echo ------------------------------------------------------------------------
echo.
TIMEOUT /T 3
xcopy "%~dp0\DISS_A\assets\boot_logo\*" "%~dp0\DISS_A\cfw\atmosphere\exefs_patches\boot_logo\" /E /y
xcopy "%~dp0\DISS_A\cfw\*" "%~dp0\DISS\" /E /y

xcopy "%~dp0\DISS_A\hekate\*" "%~dp0\DISS\" /E /y

xcopy "%~dp0\DISS_A\assets\app\*" "%~dp0\DISS\switch\" /E /y
xcopy "%~dp0\DISS_A\assets\folders\*" "%~dp0\DISS\" /E /y
xcopy "%~dp0\DISS_A\assets\payloads\*" "%~dp0\DISS\bootloader\payloads\" /E /y
xcopy "%~dp0\DISS_A\assets\images\*" "%~dp0\DISS\bootloader\res\" /E /y
xcopy "%~dp0\DISS_A\assets\gear\*" "%~dp0\DISS\" /E /y
xcopy "%~dp0\DISS_A\assets\inis\*" "%~dp0\DISS\bootloader\" /E /y
xcopy "%~dp0\DISS_A\assets\boot_logo\*" "%~dp0\DISS_A\cfw\atmosphere\exefs_patches\boot_logo\" /E /y
xcopy "%~dp0\DISS_A\temp1\*" "%~dp0\DISS\" /E /y
echo.
TIMEOUT /T 2
echo.
xcopy "%~dp0\DISS\*" "%sd%:\" /E

echo.
echo                     New file(s) Installed to SD
echo.
TIMEOUT /T 2

cls
echo ------------------------------------------------------------------------
echo            STEP 3
:::::4          /        |      /      |      /  |  /  |
:::::4          $$$$$$$$/       $$$$$$/       $$ |  $$ |
:::::4          $$ |__            $$ |        $$  \/$$/ 
:::::4          $$    |           $$ |         $$  $$<  
:::::4          $$$$$/            $$ |          $$$$  \ 
:::::4          $$ |             _$$ |_        $$ /$$  |
:::::4          $$ |            / $$   |      $$ |  $$ |
:::::4          $$/             $$$$$$/       $$/   $$/                                     
for /f "delims=:::::4 tokens=*" %%A in ('findstr /b :::::4 "%~f0"') do @echo(%%A
echo ------------------------------------------------------------------------
echo.
TIMEOUT /T 3
if not exist "%sd%:\boot.dat" (copy "%~dp0\DISS_A\temp0\boot.dat.diss" "%sd%:\boot.dat")
if not exist "%sd%:\boot.ini" (copy "%~dp0\DISS_A\temp0\boot.ini.diss" "%sd%:\boot.ini")
if not exist "%sd%:\boot.ini" (copy "%~dp0\DISS_A\temp0\boot.ini.diss" "%sd%:\boot.ini")
if not exist "%sd%:\exosphere.ini" (copy "%~dp0\DISS_A\temp0\exosphere.ini.diss" "%sd%:\exosphere.ini")
if not exist "%sd%:\payload.bin" (copy "%~dp0\DISS_A\temp0\payload.bin.diss" "%sd%:\payload.bin")
if not exist "%sd%:\fusee.bin" (copy "%~dp0\DISS_A\temp0\fusee.bin.diss" "%sd%:\fusee.bin")
if not exist "%sd%:\hbmenu.nro" (copy "%~dp0\DISS_A\temp0\hbmenu.nro.diss" "%sd%:\hbmenu.nro")

if exist "%sd%:\atmosphere" (
	attrib -A -r /S /D %sd%:\atmosphere\*
	attrib -A -r %sd%:\atmosphere)
if exist "%sd%:\atmosphere\contents" (
	attrib -A -r /S /D %sd%:\atmosphere\contents\*
	attrib -A -r %sd%:\atmosphere\contents)
if exist "%sd%:\bootloader" (
	attrib -A -r /S /D %sd%:\bootloader\*
	attrib -A -r %sd%:\bootloader)
if exist "%sd%:\config" (
	attrib -A -r /S /D %sd%:\config\*
	attrib -A -r %sd%:\config)
if exist "%sd%:\switch" (
	attrib -A -r /S /D %sd%:\switch\*
	attrib -A -r %sd%:\switch)
if exist "%sd%:\Installer" (
	attrib -A -r /S /D %sd%:\Installer\*
	attrib -A -r %sd%:\Installer)
if exist "%sd%:\themes" (
	attrib -A -r /S /D %sd%:\themes\*
	attrib -A -r %sd%:\themes)
if exist "%sd%:\emuiibo" (
	attrib -A -r /S /D %sd%:\emuiibo\*
	attrib -A -r %sd%:\emuiibo)
if exist "%sd%:\tegraexplorer" (
	attrib -A -r /S /D %sd%:\tegraexplorer\*
	attrib -A -r %sd%:\tegraexplorer)
if exist "%sd%:\warmboot_mariko" (
	attrib -A -r /S /D %sd%:\warmboot_mariko\*
	attrib -A -r %sd%:\warmboot_mariko)
if exist "%sd%:\hbmenu.nro" (attrib -A -r %sd%:\hbmenu.nro)
if exist "%sd%:\boot.dat" (attrib -A -r %sd%:\boot.dat)
if exist "%sd%:\boot.ini" (attrib -A -r %sd%:\boot.ini)
if exist "%sd%:\fusee.bin" (attrib -A -r %sd%:\fusee.bin)
if exist "%sd%:\payload.bin" (attrib -A -r %sd%:\payload.bin)
if exist "%sd%:\pegascape" (
	attrib -A /S /D %sd%:\pegascape\*
	attrib -A %sd%:\pegascape)
if exist "%sd%:\*" (
	attrib -A -r /S /D %sd%:\*
	attrib -A -r %sd%:\*)
if exist "%sd%:\*.*" (attrib -A -r %sd%:\*.*)

echo.
echo                     SD Folder(s) attribute Fixed
echo.
TIMEOUT /T 2
pause

cls
echo ------------------------------------------------------------------------
echo            STEP 4
::::::5          ______  __                            
::::::5         /      \/  |                           
::::::5        /$$$$$$  $$ | ______   ______  _______  
::::::5        $$ |  $$/$$ |/      \ /      \/       \ 
::::::5        $$ |     $$ /$$$$$$  |$$$$$$  $$$$$$$  |
::::::5        $$ |   __$$ $$    $$ |/    $$ $$ |  $$ |
::::::5        $$ \__/  $$ $$$$$$$$//$$$$$$$ $$ |  $$ |
::::::5        $$    $$/$$ $$       $$    $$ $$ |  $$ |
::::::5         $$$$$$/ $$/ $$$$$$$/ $$$$$$$/$$/   $$/                                     
for /f "delims=::::::5  tokens=*" %%A in ('findstr /b ::::::5  "%~f0"') do @echo(%%A
echo ------------------------------------------------------------------------
echo.
TIMEOUT /T 3
if exist "%~dp0\DISS_A\assets" (RD /s /q "%~dp0\DISS_A\assets")
if exist "%~dp0\DISS_A\hekate" (RD /s /q "%~dp0\DISS_A\hekate")
if exist "%~dp0\DISS_A\cfw" (RD /s /q "%~dp0\DISS_A\cfw")
if exist "%~dp0\DISS_A/trash" (RD /s /q "%~dp0\DISS_A/trash")
if exist "%~dp0\DISS_A/temp0" (RD /s /q "%~dp0\DISS_A/temp1")
if exist "%~dp0\DISS_A/temp1" (RD /s /q "%~dp0\DISS_A/temp1")

powershell -command "Compress-Archive -Path %~dp0/DISS_A -Destination %~dp0/DISS_ABC.zip" -verbose -Force
if exist "%~dp0\DISS_ABC.zip" (
    md C:\dissbackup\
    copy "%~dp0\DISS_ABC.zip" "C:\dissbackup\"
    )
if exist "%~dp0\DISS_OLDSD.zip" (
    copy "%~dp0\DISS_OLDSD.zip" "C:\dissbackup\"
    )
echo.
echo.
echo.
echo                     Please Wait

if exist "%~dp0\DISS_B" (RD /s /q "%~dp0\DISS_B")
if exist "%~dp0\DISS" (RD /s /q "%~dp0\DISS")

echo.
echo       Trash Deleted. Needed Item Backed Up. SD Cleaned 
echo.
TIMEOUT /T 3
goto ENDgood

:WRONGSD
cls
COLOR C

ECHO ----------------------------------------------------------
ECHO ======    Choosen SD drive letter is: %sd%:/         =====
ECHO ======    There is no SD card in drive %sd%:/        =====
ECHO ----------------------------------------------------------
ECHO.
ECHO. 
ECHO            1.  The SD card drive letter is correct
ECHO            2.  Choose another SD card drive letter
ECHO.
ECHO ==========================================================
ECHO                                                   3.  Exit
ECHO.

set st=
set /p st="Enter Your number of choice: "

for %%A in ("Y" "y" "1" "н" "Н") do if "%st%"==%%A (GOTO exit)
for %%A in ("N" "n" "2" "т" "Т") do if "%st%"==%%A (GOTO pickSD)
for %%A in ("3" "#" "3" "3") do if "%st%"==%%A (GOTO exit)
for %%A in ("" "" "" "") do if "%st%"==%%A (GOTO exit)

:delete1
cls
if exist "%~dp0\DISS" (RD /s /q "%~dp0\DISS")
if exist "%~dp0\DISS_A" (RD /s /q "%~dp0\DISS_A")
echo.
echo	 zip files and temp folders DELETED!
echo.
echo Press any button to go Back

pause>nul 2>&1
goto download0

:delete2
cls
if exist "%~dp0\DISS" (RD /s /q "%~dp0\DISS")
if exist "%~dp0\DISS_A" (RD /s /q "%~dp0\DISS_A")
echo.
echo	 zip files and temp folders DELETED!
echo.
echo Press any button for exit
pause>nul 2>&1
exit

:delete3
cls
if exist "%~dp0\DISS" (RD /s /q "%~dp0\DISS")
if exist "%~dp0\DISS_A" (RD /S /Q "%~dp0\DISS_A\")
COLOR 02
:::9      DDDDDDDDDDDDD      IIIIIIIIII   SSSSSSSSSSSSSSS    SSSSSSSSSSSSSSS 
:::9      D::::::::::::DDD   I::::::::I SS:::::::::::::::S SS:::::::::::::::S
:::9      D:::::::::::::::DD I::::::::IS:::::SSSSSS::::::SS:::::SSSSSS::::::S
:::9      DDD:::::DDDDD:::::DII::::::IIS:::::S     SSSSSSSS:::::S     SSSSSSS
:::9         D:::::D    D:::::D I::::I  S:::::S            S:::::S            
:::9         D:::::D     D:::::DI::::I  S:::::S            S:::::S            
:::9         D:::::D     D:::::DI::::I   S::::SSSS          S::::SSSS         
:::9         D:::::D     D:::::DI::::I    SS::::::SSSSS      SS::::::SSSSS    
:::9         D:::::D     D:::::DI::::I      SSS::::::::SS      SSS::::::::SS  
:::9         D:::::D     D:::::DI::::I         SSSSSS::::S        SSSSSS::::S 
:::9         D:::::D     D:::::DI::::I              S:::::S            S:::::S
:::9         D:::::D    D:::::D I::::I              S:::::S            S:::::S
:::9      DDD:::::DDDDD:::::DII::::::IISSSSSSS     S:::::SSSSSSSS     S:::::S
:::9      D:::::::::::::::DD I::::::::IS::::::SSSSSS:::::SS::::::SSSSSS:::::S
:::9      D::::::::::::DDD   I::::::::IS:::::::::::::::SS S:::::::::::::::SS 
:::9       DDDDDDDDDDDDD      IIIIIIIIII SSSSSSSSSSSSSSS    SSSSSSSSSSSSSSS   
for /f "delims=:::9 tokens=*" %%A in ('findstr /b :::9 "%~f0"') do @echo(%%A
echo.
echo	                                 DONE! and DONE!
echo	 Please backup DISS_OLDSD.zip (old sd files) and DISS_ABC.zip (zip files backup)
echo	                   Also we have backup it up at C:/dissbackup
echo.
echo	                    Put The SD back in your switch and boot
echo.
echo Press any button for exit
pause>nul 2>&1
exit

:ENDgood
COLOR 0f
cls
echo.
ECHO ----------------------------------------------------------
ECHO ======                 DISS Downloader               =====
ECHO ======           Assets / Bootloader / CFW           =====
ECHO ----------------------------------------------------------
ECHO.
echo.
echo               DISS installed into your SD card. 
echo                  Put it back in your Switch
echo		              ENJOY !
echo.
echo.
ECHO.
ECHO ==========================================================
ECHO                                 1.  Delete Downloaded .zip
ECHO                                 2.  Exit
ECHO.

set st=
set /p st="Enter Your number of choice: "

for %%A in ("Y" "y" "1" "н" "Н") do if "%st%"==%%A (GOTO delete2)
for %%A in ("N" "n" "2" "т" "Т") do if "%st%"==%%A (GOTO delete3)

:ENDnotgood
COLOR 0f
cls
echo.
ECHO ----------------------------------------------------------
ECHO ======                 DISS Downloader               =====
ECHO ======           Assets / Bootloader / CFW           =====
ECHO ----------------------------------------------------------
ECHO.
echo.
echo            DISS is not installed into your SD card. 
echo                     Please Try Again !
echo		   Read and follow the instructions
echo.
echo.
ECHO.
ECHO ==========================================================
ECHO                                              1.  Try Again
ECHO                                              2.  Exit
ECHO.

set st=
set /p st="Enter Your number of choice: "

for %%A in ("Y" "y" "1" "н" "Н") do if "%st%"==%%A (GOTO download0)
for %%A in ("N" "n" "2" "т" "Т") do if "%st%"==%%A (GOTO exit)
