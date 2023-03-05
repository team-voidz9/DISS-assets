@echo off
chcp 866 >nul 2>&1

COLOR 0F

set sd=%1
if not defined %sd% (GOTO pickSD)

:initialcheck
if exist "%~dp0\DISS_OLDSD.zip" (DEL /S /Q "%~dp0\DISS_OLDSD.zip")
if exist "%~dp0\DISS_ABC.zip" (DEL /S /Q "%~dp0\DISS_ABC.zip")
if exist "%~dp0\jits.zip" (DEL /S /Q "%~dp0\jist.zip")
if exist "%~dp0\hekate.zip" (DEL /S /Q "%~dp0\hekate.zip")
if exist "%~dp0\sigpatches.zip" (DEL /S /Q "%~dp0\sigpatches.zip")
if exist "%~dp0\assets.zip" (DEL /S /Q "%~dp0\assets.zip")
if exist "%~dp0\DISS_A\temp0" (DEL /S /Q "%~dp0\DISS_A\temp0")
md %~dp0\DISS_A
md %~dp0\DISS_A\temp0
md %~dp0\DISS_B
md %~dp0\DISS

:main
COLOR 0f
cls
echo.
echo      ====================== DISS Downloader V1.0.0 ========================
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
IF EXIST "%~dp0\DISS_A\jits.zip" (
echo                   CFW and SIGPATCHES READY! [4MB done!]
) ELSE (
echo                [NO] CFW and SIGPATCHES files detected   
echo                Press 1 to download          
)
echo.
IF EXIST "%~dp0\DISS_A\hekate.zip" (
echo                   Bootloader File READY! [1MB done!]
) ELSE (
echo                [NO] Bootloader Files detected
echo                Press 2 to download  
)
echo.
IF EXIST "%~dp0\DISS_A\assets.zip" (
echo                   DISS Assets File READY! [80MB done!]
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
echo.
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


:downloadALL
for /f "tokens=1,* delims=:" %%A in ('curl -ks https://api.github.com/repos/team-voidz/DISS-assets/releases/latest ^| find "browser_download_url"') do (
    curl -kOL %%B
)
if exist "%~dp0\assets.zip" (
    move "%~dp0\assets.zip" "%~dp0\DISS_A\assets.zip"
    )
echo.
echo            Downloading Assets is done!
echo.
TIMEOUT /T 3

for /f "tokens=1,* delims=:" %%A in ('curl -ks https://api.github.com/repos/Atmosphere-NX/Atmosphere/releases/latest ^| find "browser_download_url"') do (
    curl -kOL %%B
)

if exist "%~dp0\atmosphere-*.zip" (
    rename %~dp0\atmosphere-*.zip jits.zip
    move "%~dp0\jits.zip" "%~dp0\DISS_A\jits.zip"
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
    rename %~dp0\hekate_*.zip hekate.zip
    move "%~dp0\hekate.zip" "%~dp0\DISS_A\hekate.zip"
    )

IF EXIST joiner_scripts_*.zip DEL /F joiner_scripts_*.zip
IF EXIST nyx_usb_*.reg DEL /F nyx_usb_*.reg
echo.
echo            Downloading Bootloader is done!
echo.
TIMEOUT /T 3
goto download0

:download1

for /f "tokens=1,* delims=:" %%A in ('curl -ks https://api.github.com/repos/Atmosphere-NX/Atmosphere/releases/latest ^| find "browser_download_url"') do (
    curl -kOL %%B
)

if exist "%~dp0\atmosphere-*.zip" (
    rename %~dp0\atmosphere-*.zip jits.zip
    move "%~dp0\jits.zip" "%~dp0\DISS_A\jits.zip"
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
    rename %~dp0\hekate_*.zip hekate.zip
    move "%~dp0\hekate.zip" "%~dp0\DISS_A\hekate.zip"
    )

IF EXIST joiner_scripts_*.zip DEL /F joiner_scripts_*.zip
IF EXIST nyx_usb_*.reg DEL /F nyx_usb_*.reg
echo.
echo            Downloading Bootloader is done!
echo.
TIMEOUT /T 3
goto download0

:download3
for /f "tokens=1,* delims=:" %%A in ('curl -ks https://api.github.com/repos/team-voidz/DISS-assets/releases/latest ^| find "browser_download_url"') do (
    curl -kOL %%B
)
if exist "%~dp0\assets.zip" (
    move "%~dp0\assets.zip" "%~dp0\DISS_A\assets.zip"
    )
echo.
echo            Downloading Assets is done!
echo.
TIMEOUT /T 3
goto download0

:unpack
if exist "%~dp0\DISS" (RD /s /q "%~dp0\DISS")
powershell -command "Expand-Archive DISS_A/assets.zip DISS_A/assets" -Force

if exist "%~dp0\DISS_A\assets\gear\boot.dat" (
    rename %~dp0\DISS_A\assets\gear\boot.dat boot.dat
    copy "%~dp0\DISS_A\assets\gear\boot.dat" "%~dp0\DISS_A\temp0\boot.dat.diss"
    )
if exist "%~dp0\DISS_A\assets\gear\boot.ini" (
    rename %~dp0\DISS_A\assets\gear\boot.ini boot.ini
    copy "%~dp0\DISS_A\assets\gear\boot.ini" "%~dp0\DISS_A\temp0\boot.ini.diss"
    )
if exist "%~dp0\DISS_A\assets\gear\exosphere.ini" (
    rename %~dp0\DISS_A\assets\gear\exosphere.ini exosphere.ini
    copy "%~dp0\DISS_A\assets\gear\exosphere.ini" "%~dp0\DISS_A\temp0\exosphere.ini.diss"
    )

powershell -command "Expand-Archive DISS_A/hekate.zip DISS_A/hekate" -Force
if exist "%~dp0\DISS_A\hekate\hekate_*.bin" (
    rename %~dp0\DISS_A\hekate\hekate_*.bin payload.bin
    copy "%~dp0\DISS_A\hekate\payload.bin" "%~dp0\DISS_A\hekate\bootloader\payloads\hekate.bin"
    )
if exist "%~dp0\DISS_A\hekate\payload.bin" (
    rename %~dp0\DISS_A\hekate\payload.bin payload.bin
    copy "%~dp0\DISS_A\hekate\payload.bin" "%~dp0\DISS_A\temp0\payload.bin.diss"
    )

powershell -command "Expand-Archive DISS_A/jits.zip DISS_A/cfw" -Force
if exist "%~dp0\DISS_A\temp0\fusee.bin.diss2" (
    rename %~dp0\DISS_A\temp0\fusee.bin.diss2 fusee.bin
    move "%~dp0\DISS_A\temp0\fusee.bin" "%~dp0\DISS_A\cfw\fusee.bin"
    )
if exist "%~dp0\DISS_A\cfw\fusee.bin" (
    rename %~dp0\DISS_A\cfw\fusee.bin fusee.bin
    copy "%~dp0\DISS_A\cfw\fusee.bin" "%~dp0\DISS_A\temp0\fusee.bin.diss"
    )
if exist "%~dp0\DISS_A\cfw\hbmenu.nro" (
    rename %~dp0\DISS_A\cfw\hbmenu.nro hbmenu.nro
    copy "%~dp0\DISS_A\cfw\hbmenu.nro" "%~dp0\DISS_A\temp0\hbmenu.nro.diss"
    )
powershell -command "Expand-Archive DISS_A/sigpatches.zip DISS_A/cfw" -Force
echo.
ECHO  Extracting Assets, Bootloader, CFW is done!
echo.
TIMEOUT /T 3
goto download0

:startpoint
COLOR 0f
cls
echo ------------------------------------------------------------------------
echo.
echo              Step 1 : Backup and Remove old pack files from SD                         
echo.
echo ------------------------------------------------------------------------
echo.
TIMEOUT /T 3

robocopy %sd%:\ %~dp0\DISS_B\ /E /COPYALL /PURGE /XD %sd%:\emuMMC %sd%:\backup %sd%:\games %sd%:\DISS %sd%:\DISS_A %sd%:\DISS_B %sd%:\Firmware /XF %sd%:\DISS_Clean_Install.bat %sd%:\DISS_OLDSD.zip %sd%:\DISS_ABC.zip

powershell -command "Compress-Archive -Path %~dp0/DISS_B -Destination %~dp0/DISS_OLDSD.zip -Force"
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
TIMEOUT /T 3

:install
cls
echo ------------------------------------------------------------------------
echo.
echo                   Step 2 : Installing DISS                   
echo.
echo ------------------------------------------------------------------------
xcopy "%~dp0\DISS_A\assets\boot_logo\*" "%~dp0\DISS_A\cfw\atmosphere\exefs_patches\boot_logo\" /E
xcopy "%~dp0\DISS_A\cfw\*" "%~dp0\DISS\" /E

xcopy "%~dp0\DISS_A\hekate\*" "%~dp0\DISS\" /E

xcopy "%~dp0\DISS_A\assets\app\*" "%~dp0\DISS\switch\" /E
xcopy "%~dp0\DISS_A\assets\folders\*" "%~dp0\DISS\" /E
xcopy "%~dp0\DISS_A\assets\payloads\*" "%~dp0\DISS\bootloader\payloads\" /E
xcopy "%~dp0\DISS_A\assets\images\*" "%~dp0\DISS\bootloader\res\" /E
xcopy "%~dp0\DISS_A\assets\gear\*" "%~dp0\DISS\" /E
xcopy "%~dp0\DISS_A\assets\inis\*" "%~dp0\DISS\bootloader\" /E
xcopy "%~dp0\DISS_A\assets\boot_logo\*" "%~dp0\DISS_A\cfw\atmosphere\exefs_patches\boot_logo\" /E

xcopy "%~dp0\DISS\*" "%sd%:\" /E

echo.
echo                     New file(s) copied to SD
echo.
TIMEOUT /T 3
cls
echo ------------------------------------------------------------------------
echo.
echo                  Step 3 : Fixing Folder Atributes                            
echo.
echo ------------------------------------------------------------------------
echo.

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


echo.
echo                     Folder(s) Fixed
echo.
TIMEOUT /T 3

cls
echo ------------------------------------------------------------------------
echo.
echo                  Step 4 : Delete and Backup                            
echo.
echo ------------------------------------------------------------------------
echo.

if exist "%~dp0\DISS_A\assets" (RD /s /q "%~dp0\DISS_A\assets")
if exist "%~dp0\DISS_A\hekate" (RD /s /q "%~dp0\DISS_A\hekate")
if exist "%~dp0\DISS_A\cfw" (RD /s /q "%~dp0\DISS_A\cfw")

powershell -command "Compress-Archive -Path %~dp0/DISS_A -Destination %~dp0/DISS_ABC.zip -Force"
echo.
echo.
echo.
echo                     Please Wait

if exist "%~dp0\DISS_B" (RD /s /q "%~dp0\DISS_B")
if exist "%~dp0\DISS" (RD /s /q "%~dp0\DISS")



echo.
echo                    Deleted
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

for %%A in ("Y" "y" "1" "н" "Н") do if "%st%"==%%A (GOTO delete3)
for %%A in ("N" "n" "2" "т" "Т") do if "%st%"==%%A (GOTO pickSD)
for %%A in ("3" "#" "3" "3") do if "%st%"==%%A (GOTO delete3)
for %%A in ("" "" "" "") do if "%st%"==%%A (GOTO delete3)

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
