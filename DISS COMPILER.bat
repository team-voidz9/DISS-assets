@echo off
:FRONTLOAD
ECHO off
COLOR 0f
cls
echo.
ECHO ===========================================================
::1X                ___  _  ___  ___ 
::1X               | . \| |/ __>/ __>   DISS LITE COMPILER
::1X               | | || |\__ \\__ \              V.0.3.1
::1X               |___/|_|<___/<___/           team-voidz
for /f "delims=::1X tokens=*" %%A in ('findstr /b ::1X "%~f0"') do @echo(%%A
echo.
ECHO ===========================================================
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
set SF3=DISS
if not "%~1"=="" set SF=%~1

if exist "%SF3%" (
    ECHO OLD DISS folder found. Deleting Content now! 
    RD /S /Q "%SF3%"
	MKDIR "%SF3%"
) else (
    ECHO DISS folder not found. Creating . . .
    MKDIR "%SF3%"
)
set zip1=DISS_*.zip
if not "%~1"=="" set SF=%~1

if exist "%zip1%" (
    ECHO OLD DISS_ABC.zip found. Deleting now! 
    DEL /Q /F "%zip1%"
) else (
    ECHO OLD DISS_.zip NOT found.
)
ECHO.
ECHO INITIAL FOLDERS CHECK COMPLETED
ECHO.
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
goto download2

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
goto download3

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
goto unpack

:unpack
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

powershell -command "Compress-Archive -Path DISS\* -Destination DISS_.zip"  -verbose -Force
pause