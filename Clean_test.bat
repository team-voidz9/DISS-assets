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

echo      ====================== DISS Downloader V0.2.0 ========================
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
ECHO ===========================================================
::19                ___  _  ___  ___ 
::19               | . \| |/ __>/ __>   DISS DOWNLOADER
::19               | | || |\__ \\__ \           V.0.2.0
::19               |___/|_|<___/<___/        team-voidz
for /f "delims=::19 tokens=*" %%A in ('findstr /b ::19 "%~f0"') do @echo(%%A
echo.
ECHO ===========================================================
ECHO.
set filepath1="%~dp0\DISS_A\atmosphere-*.zip"
for /F "delims=" %%i in (%filepath1%) do set basename1="%%~ni"
IF EXIST "%~dp0\DISS_A\atmosphere-*.zip" (
echo      CFW and SIGPATCHES READY! [4MB done!]
echo      %basename1%
) ELSE (
echo      [NO] CFW and SIGPATCHES files detected
powershell write-host -back Red Enter 1 to download
)
echo.
set filepath2="%~dp0\DISS_A\hekate_ctcaer*.zip"
for /F "delims=" %%i in (%filepath2%) do set basename2="%%~ni"
IF EXIST "%~dp0\DISS_A\hekate_ctcaer*" (
echo      Bootloader File READY! [1MB done!]
echo      %basename2%
) ELSE (
echo      [NO] Bootloader Files detected
powershell write-host -back Red Enter 2 to download
)
echo.
set filepath3="%~dp0\DISS_A\assets_*.zip"
for /F "delims=" %%i in (%filepath3%) do set basename3="%%~ni"
IF EXIST "%~dp0\DISS_A\assets_*.zip" (
echo      DISS Assets File READY! [100MB done!]
echo       %basename3%
) ELSE (
echo      [NO] Assets Files detected
powershell write-host -back Red Enter 3 to download
)
echo.
IF EXIST "%~dp0\DISS_A\assets_*.zip" IF EXIST "%~dp0\DISS_A\hekate_ctcaer*.zip" IF EXIST "%~dp0\DISS_A\atmosphere-*.zip" (
echo      Assets, Bootloader and CFW checked and ready
powershell write-host -back Red         Enter 4 to extract
) ELSE (
echo      ....................................................
)
ECHO.
ECHO =Please Download all the required files before extracting=
ECHO ==========================================================
ECHO                                        7.  exit
echo                                        0.  Download ALL
ECHO.

set st=
set /p st="Enter Your number of choice: "
for %%A in ("0" "o" "O" "0" "0") do if "%st%"==%%A (GOTO downloadALL)
for %%A in ("Y" "y" "1" "н" "Н") do if "%st%"==%%A (GOTO download1)
for %%A in ("N" "n" "2" "т" "Т") do if "%st%"==%%A (GOTO download2)
for %%A in ("3" "#" "3" "3" "3") do if "%st%"==%%A (GOTO download3)
for %%A in ("$" "4" "4" "4" "4") do if "%st%"==%%A (GOTO unpack  )
for %%A in ("5" "5" "5" "5" "5") do if "%st%"==%%A (GOTO startpoint)
for %%A in ("6" "^" "6" "6" "6") do if "%st%"==%%A (GOTO downloadextra)
for %%A in ("7" "&" "7" "7") do if "%st%"==%%A (GOTO exit)
for %%A in ("" "" "" "") do if "%st%"==%%A (GOTO exit)

:downloadXX
COLOR 0f
cls
echo.
ECHO ===========================================================
::18                ___  _  ___  ___ 
::18               | . \| |/ __>/ __>   DISS DOWNLOADER
::18               | | || |\__ \\__ \           V.0.2.0
::18               |___/|_|<___/<___/        team-voidz
for /f "delims=::18 tokens=*" %%A in ('findstr /b ::18 "%~f0"') do @echo(%%A
echo.
ECHO ===========================================================
ECHO.

IF EXIST "%~dp0\DISS_A\assets\inis\hekate_ipl.ini" IF EXIST "%~dp0\DISS_A\cfw\switch\daybreak.nro" (
echo          cfw / bootloader / assets [extracted]
powershell write-host -back Red         Enter 5 to install
) ELSE (
echo                          ...
)
echo.
echo.
ECHO ==========================================================
ECHO                                        7.  exit
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
for %%A in ("7" "&" "7" "7") do if "%st%"==%%A (GOTO exit)
for %%A in ("" "" "" "") do if "%st%"==%%A (GOTO exit)

:downloadALL
PowerShell -NoProfile -ExecutionPolicy Bypass -Command "& '%~dp0\atmos.ps1'"

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

PowerShell -NoProfile -ExecutionPolicy Bypass -Command "& '%~dp0\Hekat.ps1'"

if exist "%~dp0\hekate_*.zip" (
    move "%~dp0\hekate_*.zip" "%~dp0\DISS_A\"
    )
echo.
echo            Downloading Bootloader is done!
echo.
TIMEOUT /T 3

PowerShell -NoProfile -ExecutionPolicy Bypass -Command "& '%~dp0\DAss.ps1'"
)
if exist "%~dp0\assets_*.zip" (
    move "%~dp0\assets_*.zip" "%~dp0\DISS_A\"
    )

echo.
echo            Downloading Assets is done!
echo.
TIMEOUT /T 3
goto download0

:download1
curl "https://raw.githubusercontent.com/team-voidz/DISS-assets/main/Atmos.ps1" --output %~dp0\Atmos.ps1
PowerShell -NoProfile -ExecutionPolicy Bypass -Command "& '%~dp0\atmos.ps1'"

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
if exist "%~dp0\atmos.ps1" (
    rename %~dp0\atmos.ps1 atmos.diss.done
    move "%~dp0\atmos.diss.done" "%~dp0\DISS_A\trash\atmos.diss.done"
    )	
echo.
echo            Downloading CFW and Sigpatches is done!
echo.
TIMEOUT /T 3
goto download0

:download2
curl "https://raw.githubusercontent.com/team-voidz/DISS-assets/main/Hekat.ps1" --output %~dp0\Hekat.ps1
PowerShell -NoProfile -ExecutionPolicy Bypass -Command "& '%~dp0\Hekat.ps1'"

if exist "%~dp0\hekate_*.zip" (
    move "%~dp0\hekate_*.zip" "%~dp0\DISS_A\"
    )
if exist "%~dp0\Hekat.ps1" (
    rename %~dp0\Hekat.ps1 Hekat.diss.done
    move "%~dp0\Hekat.diss.done" "%~dp0\DISS_A\trash\Hekat.diss.done"
    )
echo.
echo            Downloading Bootloader is done!
echo.
TIMEOUT /T 3
goto download0

:download3
curl "https://raw.githubusercontent.com/team-voidz/DISS-assets/main/DAss.ps1" --output %~dp0\DAss.ps1
PowerShell -NoProfile -ExecutionPolicy Bypass -Command "& '%~dp0\DAss.ps1'"
)
if exist "%~dp0\assets_*.zip" (
    move "%~dp0\assets_*.zip" "%~dp0\DISS_A\"
    )
if exist "%~dp0\DAss.ps1" (
    rename %~dp0\DAss.ps1 DAss.diss.done
    move "%~dp0\DAss.diss.done" "%~dp0\DISS_A\trash\DAss.diss.done"
    )
echo.
echo            Downloading Assets is done
echo.
TIMEOUT /T 3
goto downloadextra

:downloadextra
curl "https://raw.githubusercontent.com/team-voidz/DISS-assets/main/BINRO.ps1" --output %~dp0\BINRO.ps1
PowerShell -NoProfile -ExecutionPolicy Bypass -Command "& '%~dp0\BINRO.ps1'"
powershell -command "Expand-Archive -LiteralPath %~dp0/breeze.zip -Destination %~dp0/DISS_A/temp1/" -verbose -force
if exist "%~dp0\breeze.zip" (
    move "%~dp0\breeze.zip" "%~dp0\DISS_A\trash\"
    )

if exist "%~dp0\Edizon.nro" (
    md "%~dp0\DISS_A\temp1\switch\EdiZon\"
    move "%~dp0\Edizon.nro" "%~dp0\DISS_A\temp1\switch\EdiZon\"
    )
if exist "%~dp0\ovlEdizon.ovl" (
    md "%~dp0\DISS_A\temp1\switch\.overlays\"
    move "%~dp0\ovlEdizon.ovl" "%~dp0\DISS_A\temp1\switch\.overlays\"
    )
if exist "%~dp0\nxdumptool.nro" (
    md "%~dp0\DISS_A\temp1\switch\nxdumptool\"
    move "%~dp0\nxdumptool.nro" "%~dp0\DISS_A\temp1\switch\nxdumptool\"
    )
if exist "%~dp0\dbi.nro" (
    move "%~dp0\dbi.nro" "%~dp0\DISS_A\temp1\switch\"
    )
if exist "%~dp0\dbi.config" (
    move "%~dp0\dbi.config" "%~dp0\DISS_A\temp1\switch\"
    )
if exist "%~dp0\jksv.nro" (
    move "%~dp0\jksv.nro" "%~dp0\DISS_A\temp1\switch\"
    )
if exist "%~dp0\Switch_90DNS_tester.nro" (
    move "%~dp0\Switch_90DNS_tester.nro" "%~dp0\DISS_A\temp1\switch\"
    )
powershell -command "Expand-Archive %~dp0/linkalho-*.zip %~dp0/DISS_A/temp1/switch" -verbose -force
if exist "%~dp0\linkalho-*.zip" (
    move "%~dp0\linkalho-*.zip" "%~dp0\DISS_A\trash\"
    )
powershell -command "Expand-Archive %~dp0/gamecard_installer.zip %~dp0/DISS_A/temp1" -verbose -force
if exist "%~dp0\gamecard_installer.zip " (
    move "%~dp0\gamecard_installer.zip " "%~dp0\DISS_A\trash\"
    )
if exist "%~dp0\TegraExplorer.bin" (
    md "%~dp0\DISS_A\assets\payloads\"
    move "%~dp0\TegraExplorer.bin" "%~dp0\DISS_A\assets\payloads"
    )
if exist "%~dp0\Lockpick_RCM.bin" (
    move "%~dp0\Lockpick_RCM.bin" "%~dp0\DISS_A\assets\payloads"
    )
if exist "%~dp0\CommonProblemResolver.bin" (
    move "%~dp0\CommonProblemResolver.bin" "%~dp0\DISS_A\assets\payloads"
    )
if exist "%~dp0\Incognito_RCM.bin" (
    move "%~dp0\Incognito_RCM.bin" "%~dp0\DISS_A\assets\payloads"
    )
if exist "%~dp0\BINRO.ps1" (
    rename %~dp0\BINRO.ps1 BINRO.diss.done
    move "%~dp0\BINRO.diss.done" "%~dp0\DISS_A\trash\BINRO.diss.done"
    )	
echo.
echo            Downloading BINs and NROs are done!
echo.
TIMEOUT /T 3
goto download0

:unpack
dir /b "%~dp0\DISS_A\*.zip" > DISS_Version.txt
echo "ATMOS, BOOTLOADER, and CFW version recorded"
echo.
TIMEOUT /T 3
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

if exist "%~dp0\DISS_Version.txt" (
    rename %~dp0\DISS_Version.txt DISS_Version.diss
    move "%~dp0\DISS_Version.diss" "%~dp0\DISS_A\temp0\DISS_Version.diss"
    )
echo.
ECHO  Extracting Assets, Bootloader, CFW is done!
echo.
TIMEOUT /T 3
goto downloadXX

:startpoint
COLOR 0f
cls
echo ------------------------------------------------------------------------
echo           STEP 1 : Copy / Remove SD Contents
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

robocopy %sd%:\ %~dp0\DISS_B\ /E /COPYALL  /XD %sd%:\emuMMC %sd%:\backup %sd%:\games %sd%:\DISS %sd%:\DISS_A %sd%:\DISS_B %sd%:\Firmware /XF %sd%:\DISS_OLDSD.zip %sd%:\DISS_ABC.zip
echo.
ECHO       Please Wait.
TIMEOUT /T 3

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
if exist "%sd%:\DISS_Version.txt" (del /s /q "%sd%:\DISS_Version.txt")
echo.
echo                     DONE
echo.
TIMEOUT /T 2

:install
cls
echo ------------------------------------------------------------------------
echo            STEP 2 : Installing New Downloaded Files
::::3            ______                     __              _____
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

robocopy %~dp0\DISS_A\assets\boot_logo\ %~dp0\DISS_A\cfw\atmosphere\exefs_patches\boot_logo\ /E /COPYALL
robocopy %~dp0\DISS_A\cfw\ %~dp0\DISS\ /E /COPYALL
robocopy %~dp0\DISS_A\hekate\ %~dp0\DISS\ /E /COPYALL
robocopy %~dp0\DISS_A\assets\app\ %~dp0\DISS\switch\ /E /COPYALL
robocopy %~dp0\DISS_A\assets\folders\ %~dp0\DISS\ /E /COPYALL
robocopy %~dp0\DISS_A\assets\payloads\ %~dp0\DISS\bootloader\payloads\ /E /COPYALL
robocopy %~dp0\DISS_A\assets\images\ %~dp0\DISS\bootloader\res\ /E /COPYALL
robocopy %~dp0\DISS_A\assets\gears\ %~dp0\DISS\ /E /COPYALL
robocopy %~dp0\DISS_A\assets\inis\ %~dp0\DISS\bootloader\ /E /COPYALL
robocopy %~dp0\DISS_A\assets\boot_logo\ %~dp0\DISS_A\cfw\atmosphere\exefs_patches\boot_logo\ /E /COPYALL
robocopy %~dp0\DISS_A\temp1 %~dp0\DISS\ /E /COPYALL

echo.
TIMEOUT /T 2
echo.
robocopy %~dp0\DISS\ %sd%:\ /E /MIR /COPYALL

echo.
echo                     DONE
echo.
TIMEOUT /T 2

cls
echo ------------------------------------------------------------------------
echo            STEP 3 : Fixing Missing Files / Attributes
:::::4           ________        ______        __    __
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
if not exist "%sd%:\DISS_Version.txt" (copy "%~dp0\DISS_A\temp0\DISS_Version.diss" "%sd%:\DISS_Version.txt")

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
echo                     DONE
echo.
TIMEOUT /T 2
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
echo.
echo	 zip files and temp folders DELETED!
echo.
echo Press any button for exit
pause>nul 2>&1
call %~dp0\DISS_delete.bat

:delete3
cls
if exist "%~dp0\DISS" (RD /s /q "%~dp0\DISS")
call %~dp0\DISS_delete.bat

:ENDgood
COLOR 0f
cls
echo.
ECHO ===========================================================
::1x                ___  _  ___  ___ 
::1x               | . \| |/ __>/ __>   DISS DOWNLOADER
::1x               | | || |\__ \\__ \           V.0.2.0
::1x               |___/|_|<___/<___/        team-voidz
for /f "delims=::1x tokens=*" %%A in ('findstr /b ::1x "%~f0"') do @echo(%%A
echo.
ECHO ==
echo.
echo               DISS installed into your SD card.
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
ECHO ===========================================================
::1y                ___  _  ___  ___ 
::1y               | . \| |/ __>/ __>   DISS DOWNLOADER
::1y               | | || |\__ \\__ \           V.0.2.0
::1y               |___/|_|<___/<___/        team-voidz
for /f "delims=::1y tokens=*" %%A in ('findstr /b ::1y "%~f0"') do @echo(%%A
echo.
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
