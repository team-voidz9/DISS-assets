@echo off
:FRONTLOAD
ECHO off
COLOR 0f
cls
echo.
ECHO ===========================================================
::1X                ___  _  ___  ___ 
::1X               | . \| |/ __>/ __>   DISS LITE COMPILER
::1X               | | || |\__ \\__ \              V.0.3.2
::1X               |___/|_|<___/<___/           team-voidz
for /f "delims=::1X tokens=*" %%A in ('findstr /b ::1X "%~f0"') do @echo(%%A
echo.
ECHO ===========================================================
set SF3=DISS
if not "%~1"=="" set SF=%~1

if exist "%SF3%" (
    ECHO Previous DISS folder found.
    ren "%SF3%" "old.DISS"
	MKDIR "%SF3%"
) else (
    ECHO DISS folder not found. Creating . . .
    MKDIR "%SF3%"
)
set old=old.DISS
if exist "%old%" (
    ECHO OLD.DISS folder found. Zipping and Backup-ing content now
	MKDIR "c:\dissbackup\old"
powershell -command "Compress-Archive -Path old.DISS\* -DestinationPath ('oldDISS_' + (get-date -Format yyyyMMdd) + '.zip')"
	move "oldDISS_*.zip" "c:\dissbackup\old\"
) else (
    ECHO NO OLD.DISS zip
)
set SF=DISS_A
set SFA=DISS_A\temp0
set SFB=DISS_A\trash
if not "%~1"=="" set SF=%~1

if exist "%SF%" (
    ECHO OLD DISS_A folder found. Deleting Content now! 
    RD /S /Q "%SF%"
	MKDIR "%SF%"
	MKDIR "%SFA%"
	MKDIR "%SFB%"
) else (
    ECHO DISS_A folder not found. Creating . . .
    MKDIR "%SF%"
	MKDIR "%SFA%"
	MKDIR "%SFB%"
)
set SF2=DISS_B
if not "%~1"=="" set SF=%~1

if exist "%SF2%" (
    ECHO OLD DISS_B folder found. Deleting Content now! 
    RD /S /Q "%SF2%"
	MKDIR "%SF2%"
) else (
    ECHO DISS_B folder not found. Creating . . .
    MKDIR "%SF2%"
)
set SFC=old.DISS
if not "%~1"=="" set SF=%~1

if exist "%SFC%" (
    ECHO Old.DISS folder found. Deleting Content now! 
    RD /S /Q "%SFC%"
) else (
    ECHO old.DISS folder not found.
)

ECHO.
ECHO INITIAL FOLDERS CHECK COMPLETED
ECHO.
TIMEOUT /T 3

:FRONTLOAD2
ECHO off
COLOR 0f
cls
echo.
ECHO ===========================================================
::1Y                ___  _  ___  ___ 
::1Y               | . \| |/ __>/ __>   DISS LITE COMPILER
::1Y               | | || |\__ \\__ \              V.0.3.2
::1Y               |___/|_|<___/<___/           team-voidz
for /f "delims=::1Y tokens=*" %%A in ('findstr /b ::1Y "%~f0"') do @echo(%%A
echo.
ECHO ===========================================================
set filepath1="%~dp0\DISS_A\atmosphere-*.zip"
for /F "delims=" %%i in (%filepath1%) do set basename1="%%~ni"
IF EXIST "%~dp0\DISS_A\atmosphere-*.zip" (
echo      CFW and SIGPATCHES READY! [4MB done!]
powershell write-host -back Green      %basename1%
) ELSE (
echo      [NO] CFW and SIGPATCHES files detected
powershell write-host -back Red Enter 1 to download
)
echo.
set filepath2="%~dp0\DISS_A\hekate_ctcaer*.zip"
for /F "delims=" %%i in (%filepath2%) do set basename2="%%~ni"
IF EXIST "%~dp0\DISS_A\hekate_ctcaer*" (
echo      Bootloader File READY! [1MB done!]
powershell write-host -back Green      %basename2%
) ELSE (
echo      [NO] Bootloader Files detected
powershell write-host -back Red Enter 2 to download
)
echo.
set filepath3="%~dp0\DISS_A\assets_*.zip"
for /F "delims=" %%i in (%filepath3%) do set basename3="%%~ni"
IF EXIST "%~dp0\DISS_A\assets_*.zip" (
echo      DISS Assets File READY! [100MB done!]
powershell write-host -back Green       %basename3%
) ELSE (
echo      [NO] Assets Files detected
powershell write-host -back Red Enter 3 to download
)
echo.
IF EXIST "%~dp0\DISS_A\assets_*.zip" IF EXIST "%~dp0\DISS_A\hekate_ctcaer*.zip" IF EXIST "%~dp0\DISS_A\atmosphere-*.zip" (
echo      Assets, Bootloader and CFW checked and ready
powershell write-host -back Red         Enter 4 to compile
) ELSE (
echo      ....................................................
)

ECHO.

set st=
set /p st="Enter Your number of choice: "
for %%A in ("Y" "y" "1" "н" "Н") do if "%st%"==%%A (GOTO download1)
for %%A in ("N" "n" "2" "т" "Т") do if "%st%"==%%A (GOTO download2)
for %%A in ("3" "#" "3" "3" "3") do if "%st%"==%%A (GOTO download3)
for %%A in ("$" "4" "4" "4" "4") do if "%st%"==%%A (GOTO unpack  )
for %%A in ("5" "5" "5" "5" "5") do if "%st%"==%%A (GOTO exit)
for %%A in ("6" "^" "6" "6" "6") do if "%st%"==%%A (GOTO exit)
for %%A in ("7" "&" "7" "7") do if "%st%"==%%A (GOTO exit)
for %%A in ("" "" "" "") do if "%st%"==%%A (GOTO exit)

:FRONTLOAD3
ECHO off
COLOR 0f
cls
echo.
ECHO ===========================================================
::1q                ___  _  ___  ___ 
::1q               | . \| |/ __>/ __>   DISS LITE COMPILER
::1q               | | || |\__ \\__ \              V.0.3.2
::1q               |___/|_|<___/<___/           team-voidz
for /f "delims=::1q tokens=*" %%A in ('findstr /b ::1q "%~f0"') do @echo(%%A
echo.
ECHO ===========================================================

powershell write-host -back Red These File have been downloaded and prepared.
powershell Get-Content %~dp0\DISS\DISS_Compiler/Installed.txt
echo.
echo Place the Content of "DISS" folder into you SD card ROOT
echo.
pause
RD /s /q DISS_A
RD /s /q DISS_B
del %0

:download1
cls
curl "https://raw.githubusercontent.com/team-voidz/DISS-assets/main/DISS/Atmos.ps1" --output %~dp0\Atmos.ps1
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
goto FRONTLOAD2

:download2
cls
curl "https://raw.githubusercontent.com/team-voidz/DISS-assets/main/DISS/Hekat.ps1" --output %~dp0\Hekat.ps1
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
goto FRONTLOAD2

:download3
cls
curl "https://raw.githubusercontent.com/team-voidz/DISS-assets/main/DISS/DAss.ps1" --output %~dp0\DAss.ps1
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
cls
curl "https://raw.githubusercontent.com/team-voidz/DISS-assets/main/DISS/homes.ps1" --output %~dp0\homes.ps1
PowerShell -NoProfile -ExecutionPolicy Bypass -Command "& '%~dp0\homes.ps1'"
powershell -command "Expand-Archive -LiteralPath %~dp0/breeze.zip -Destination %~dp0/DISS_A/temp1/" -verbose -force
if exist "%~dp0\breeze.zip" (
    move "%~dp0\breeze.zip" "%~dp0\DISS_A\trash\"
    )
if exist "%~dp0\ldn_mitm_*.zip" (
    rename %~dp0\ldn_mitm_*.zip ldn.zip
    )
powershell -command "Expand-Archive -LiteralPath %~dp0/ldn.zip -Destination %~dp0/DISS_A/temp1/" -verbose -force
if exist "%~dp0\ldn.zip " (
    move "%~dp0\ldn.zip " "%~dp0\DISS_A\trash\"
    )
powershell -command "Expand-Archive %~dp0/EdiZon.zip %~dp0/DISS_A/temp1" -verbose -force
if exist "%~dp0\EdiZon.zip" (
    move "%~dp0\EdiZon.zip" "%~dp0\DISS_A\trash\"
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
if exist "%~dp0\appstore.nro" (
    move "%~dp0\appstore.nro" "%~dp0\DISS_A\temp1\switch\"
    )
powershell -command "Expand-Archive %~dp0/linkalho-*.zip %~dp0/DISS_A/temp1/switch" -verbose -force
if exist "%~dp0\linkalho-*.zip" (
    move "%~dp0\linkalho-*.zip" "%~dp0\DISS_A\trash\"
    )
powershell -command "Expand-Archive %~dp0/NX-Activity-Log.zip %~dp0/DISS_A/temp1" -verbose -force
if exist "%~dp0\NX-Activity-Log.zip" (
    move "%~dp0\NX-Activity-Log.zip" "%~dp0\DISS_A\trash\"
    )
powershell -command "Expand-Archive %~dp0/sys-patch.zip %~dp0/DISS_A/temp1" -verbose -force
if exist "%~dp0\sys-patch.zip" (
    move "%~dp0\sys-patch.zip" "%~dp0\DISS_A\trash\"
    )
if exist "%~dp0\titles.zip" (
	md "%~dp0\DISS_A\temp1\switch\breeze\cheats\"
    move "%~dp0\titles.zip" "%~dp0\DISS_A\temp1\switch\breeze\cheats\"
    )
if exist "%~dp0\DISS_A\temp1\switch\breeze\cheats\titles.zip" (
    md "%~dp0\DISS_A\temp1\switch\EdiZon\cheats\"
	copy "%~dp0\DISS_A\temp1\switch\breeze\cheats\titles.zip" "%~dp0\DISS_A\temp1\switch\EdiZon\cheats\"
    )
if exist "%~dp0\Goldleaf.nro" (
    move "%~dp0\Goldleaf.nro" "%~dp0\DISS_A\temp1\switch\"
    )
if exist "%~dp0\homes.ps1" (
    rename %~dp0\homes.ps1 homes.diss.done
    move "%~dp0\homes.diss.done" "%~dp0\DISS_A\trash\homes.diss.done"
    )		
curl "https://raw.githubusercontent.com/team-voidz/DISS-assets/main/DISS/pays.ps1" --output %~dp0\pays.ps1
PowerShell -NoProfile -ExecutionPolicy Bypass -Command "& '%~dp0\pays.ps1'"	
if exist "%~dp0\TegraExplorer.bin" (
    md "%~dp0\DISS_A\assets\payloads\"
    move "%~dp0\TegraExplorer.bin" "%~dp0\DISS_A\assets\payloads"
    )
if exist "%~dp0\Incognito_RCM.bin" (
    move "%~dp0\Incognito_RCM.bin" "%~dp0\DISS_A\assets\payloads"
    )
if exist "%~dp0\pays.ps1" (
    rename %~dp0\pays.ps1 pays.diss.done
    move "%~dp0\pays.diss.done" "%~dp0\DISS_A\trash\pays.diss.done"
    )
echo.
echo            Downloading Payloads and Homebrews are done!
echo.
TIMEOUT /T 3
goto FRONTLOAD2

:unpack
cls
dir /b "%~dp0\DISS_A\*.zip" > DISS_Version.txt
echo.
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
goto copy

:copy
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

goto attribute
:attribute
if not exist "%%~dp0\DISS\boot.dat" (copy "%~dp0\DISS_A\temp0\boot.dat.diss" "%~dp0\DISS\boot.dat")
if not exist "%~dp0\DISS\boot.ini" (copy "%~dp0\DISS_A\temp0\boot.ini.diss" "%~dp0\DISS\boot.ini")
if not exist "%~dp0\DISS\boot.ini" (copy "%~dp0\DISS_A\temp0\boot.ini.diss" "%~dp0\DISS\boot.ini")
if not exist "%~dp0\DISS\exosphere.ini" (copy "%~dp0\DISS_A\temp0\exosphere.ini.diss" "%~dp0\DISS\exosphere.ini")
if not exist "%~dp0\DISS\payload.bin" (copy "%~dp0\DISS_A\temp0\payload.bin.diss" "%~dp0\DISS\payload.bin")
if not exist "%~dp0\DISS\hekate.bin" (copy "%~dp0\DISS_A\temp0\payload.bin.diss" "%~dp0\DISS\Hekate.bin")
if not exist "%~dp0\DISS\fusee.bin" (copy "%~dp0\DISS_A\temp0\fusee.bin.diss" "%~dp0\DISS\fusee.bin")
if not exist "%~dp0\DISS\hbmenu.nro" (copy "%~dp0\DISS_A\temp0\hbmenu.nro.diss" "%~dp0\DISS\hbmenu.nro")
if not exist "%~dp0\DISS\DISS_Version.txt" (copy "%~dp0\DISS_A\temp0\DISS_Version.diss" "%~dp0\DISS\DISS_Version.txt")

if exist "%~dp0\DISS\atmosphere" (
	attrib -A -r /S /D %~dp0\DISS\atmosphere\*
	attrib -A -r %~dp0\DISS\atmosphere)
if exist "%~dp0\DISS\atmosphere\contents" (
	attrib -A -r /S /D %~dp0\DISS\atmosphere\contents\*
	attrib -A -r %~dp0\DISS\atmosphere\contents)
if exist "%~dp0\DISS\bootloader" (
	attrib -A -r /S /D %~dp0\DISS\bootloader\*
	attrib -A -r %~dp0\DISS\bootloader)
if exist "%~dp0\DISS\config" (
	attrib -A -r /S /D %~dp0\DISS\config\*
	attrib -A -r %~dp0\DISS\config)
if exist "%~dp0\DISS\switch" (
	attrib -A -r /S /D %~dp0\DISS\switch\*
	attrib -A -r %~dp0\DISS\switch)
if exist "%~dp0\DISS\Installer" (
	attrib -A -r /S /D %~dp0\DISS\Installer\*
	attrib -A -r %~dp0\DISS\Installer)
if exist "%~dp0\DISS\themes" (
	attrib -A -r /S /D %~dp0\DISS\themes\*
	attrib -A -r %~dp0\DISS\themes)
if exist "%~dp0\DISS\emuiibo" (
	attrib -A -r /S /D %~dp0\DISS\emuiibo\*
	attrib -A -r %~dp0\DISS\emuiibo)
if exist "%~dp0\DISS\tegraexplorer" (
	attrib -A -r /S /D %~dp0\DISS\tegraexplorer\*
	attrib -A -r %~dp0\DISS\tegraexplorer)
if exist "%~dp0\DISS\warmboot_mariko" (
	attrib -A -r /S /D %~dp0\DISS\warmboot_mariko\*
	attrib -A -r %~dp0\DISS\warmboot_mariko)
if exist "%~dp0\DISS\hbmenu.nro" (attrib -A -r %~dp0\DISS\hbmenu.nro)
if exist "%~dp0\DISS\boot.dat" (attrib -A -r %~dp0\DISS\boot.dat)
if exist "%~dp0\DISS\boot.ini" (attrib -A -r %~dp0\DISS\boot.ini)
if exist "%~dp0\DISS\fusee.bin" (attrib -A -r %~dp0\DISS\fusee.bin)
if exist "%~dp0\DISS\payload.bin" (attrib -A -r %~dp0\DISS\payload.bin)
if exist "%~dp0\DISS\pegascape" (
	attrib -A /S /D %~dp0\DISS\pegascape\*
	attrib -A %~dp0\DISS\pegascape)
if exist "%~dp0\DISS\*" (
	attrib -A -r /S /D %~dp0\DISS\*
	attrib -A -r %~dp0\DISS\*)
if exist "%~dp0\DISS\*.*" (attrib -A -r %~dp0\DISS\*.*)

echo.
echo                     DONE
echo.
dir /b "%~dp0\DISS\bootloader\payloads" > DISS_NRO.txt
echo "NROS recorded"
dir /b "%~dp0\DISS\switch" > DISS_BIN.txt
echo "BINs recorded"
dir /b "%~dp0\DISS\Installer" > DISS_y2.txt
echo "NSPs recorded"
echo.
md "%~dp0\DISS\DISS_Compiler\X\"
if not exist "%~dp0\DISS\DISS_NRO.txt" (move "%~dp0\DISS_NRO.txt" "%~dp0\DISS\DISS_NRO.txt")
if not exist "%~dp0\DISS\DISS_Version.txt" (move "%~dp0\DISS_Version.txt" "%~dp0\DISS\DISS_Version.txt")
if not exist "%~dp0\DISS\DISS_BIN.txt" (move "%~dp0\DISS_BIN.txt" "%~dp0\DISS\DISS_BIN.txt")
if not exist "%~dp0\DISS\DISS_y2.txt" (move "%~dp0\DISS_y2.txt" "%~dp0\DISS\DISS_y2.txt")
if exist "%~dp0\DISS\DISS_BIN.txt" (
    move "%~dp0\DISS\DISS_BIN.txt" "%~dp0\DISS\DISS_Compiler\X\"
    )
if exist "%~dp0\DISS\DISS_NRO.txt" (
    move "%~dp0\DISS\DISS_NRO.txt" "%~dp0\DISS\DISS_Compiler\X\"
    )
if exist "%~dp0\DISS\DISS_Version.txt" (
    move "%~dp0\DISS\DISS_Version.txt" "%~dp0\DISS\DISS_Compiler\X\"
    )
if exist "%~dp0\DISS\DISS_y2.txt" (
    move "%~dp0\DISS\DISS_y2.txt" "%~dp0\DISS\DISS_Compiler\X\"
    )
curl "https://raw.githubusercontent.com/team-voidz/DISS-assets/main/DISS/spacers.zip" --output %~dp0\DISS\spacers.zip	
powershell -command "Expand-Archive -LiteralPath %~dp0/DISS/spacers.zip -Destination %~dp0/DISS/DISS_Compiler/X1/" -verbose -force
if exist "%~dp0\DISS\DISS_Compiler\X1\DISS_*.txt" (
    move "%~dp0\DISS\DISS_Compiler\X1\*.txt" "%~dp0\DISS\DISS_Compiler\X\"
    )
copy "%~dp0\DISS\DISS_Compiler\X\*.txt" "%~dp0\DISS\DISS_Compiler\Installed.txt"
if exist  "%~dp0\DISS\spacers.zip" (
    move  "%~dp0\DISS\spacers.zip" "%~dp0\DISS\DISS_Compiler\X\spacers.zip"
    )
RD /s /q "%~dp0\DISS\DISS_Compiler\X\"
RD /s /q "%~dp0\DISS\DISS_Compiler\X1\"

tree /f "%~dp0\DISS"> AllFiles_Folders.txt
if exist  "%~dp0\AllFiles_Folders.txt" (
    move  "%~dp0\AllFiles_Folders.txt" "%~dp0\DISS\DISS_Compiler\AllFiles_Folders.txt"
    )
TIMEOUT /T 3
powershell -command "Compress-Archive -Path DISS\* -DestinationPath ('DISS_Hats_' + (get-date -Format yyyyMMdd) + '.zip')"
goto FRONTLOAD3
