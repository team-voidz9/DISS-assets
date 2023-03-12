@echo off
:deleteDelete
COLOR 0f
cls
:::1      
:::1             _             _         _           _        
:::1            /\ \          /\ \      / /\        / /\      
:::1           /  \ \____     \ \ \    / /  \      / /  \     
:::1          / /\ \_____\    /\ \_\  / / /\ \__  / / /\ \__  
:::1         / / /\/___  /   / /\/_/ / / /\ \___\/ / /\ \___\ 
:::1        / / /   / / /   / / /    \ \ \ \/___/\ \ \ \/___/ 
:::1       / / /   / / /   / / /      \ \ \       \ \ \       
:::1      / / /   / / /   / / /   _    \ \ \  _    \ \ \      
:::1      \ \ \__/ / /___/ / /__ /_/\__/ / / /_/\__/ / /      
:::1       \ \___\/ //\__\/_/___\\ \/___/ /  \ \/___/ /       
:::1        \/_____/ \/_________/ \_____\/    \_____\/        
:::1                                                          
for /f "delims=:::1 tokens=*" %%A in ('findstr /b :::1 "%~f0"') do @echo(%%A
echo.
echo	                                 DONE! and DONE!
echo.                   
powershell write-host -back Red These File have been installed into your SD CARD.
powershell Get-Content C:\dissbackup\DISS_version.txt 
powershell write-host -back Red .................................................
echo.
echo	 Please backup DISS_OLDSD.zip (old sd files) and DISS_ABC.zip (zip files backup)
echo	 Also we have backup it up at C:/dissbackup
echo.
if exist "%~dp0\DISS_A\assets" (RD /s /q "%~dp0\DISS_A\assets")
if exist "%~dp0\DISS_A\hekate" (RD /s /q "%~dp0\DISS_A\hekate")
if exist "%~dp0\DISS_A\cfw" (RD /s /q "%~dp0\DISS_A\cfw")
if exist "%~dp0\DISS_A\trash" (RD /s /q "%~dp0\DISS_A\trash")
if exist "%~dp0\DISS_A\temp0" (RD /s /q "%~dp0\DISS_A\temp1")
if exist "%~dp0\DISS_A\temp1" (RD /s /q "%~dp0\DISS_A\temp1")
if exist "%~dp0\DISS" (RD /s /q "%~dp0\DISS")
powershell -command "Compress-Archive -Path DISS_B\* -Destination DISS_OLDSD.zip" -verbose -Force
powershell -command "Compress-Archive -Path DISS_A\* -Destinationpath DISS_ABC.zip" -verbose -force
if exist "%~dp0\DISS_ABC.zip" (
    md C:\dissbackup\
    copy "%~dp0\DISS_ABC.zip" "C:\dissbackup\DISS_ABC.zip"
    )
if exist "%~dp0\DISS_OLDSD.zip" (
    copy "%~dp0\DISS_OLDSD.zip" "C:\dissbackup\DISS_OLDSD.zip"
    )
if exist "%sd%:\DISS_version.txt"
    copy "%sd%:\DISS_version.txt" "C:\dissbackup\DISS_version.txt"
    )
if exist "%~dp0\DISS_B" (RD /s /q "%~dp0\DISS_B")
powershell write-host -back Green  Put The SD back in your switch and boot
echo.

pause
if exist %~dp0\Clean_Clean.bat (DEL /Q /F %~dp0\Clean_Clean.bat) 
if exist %~dp0\DISS_downloader.bat (DEL /Q /F %~dp0\DISS_downloader.bat) 
if exist %~dp0\DISS_downloader.bat (DEL /Q /F %~dp0\DISS_downloader.bat)
if exist %~dp0\*.ps1 (DEL /Q /F %~dp0\*.ps1) 
pause
del %0