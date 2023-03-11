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
echo.                   These File have been installed into your SD CARD.
powershell Get-Content C:\dissbackup\DISS_version.txt
echo.
echo	 Please backup DISS_OLDSD.zip (old sd files) and DISS_ABC.zip (zip files backup)
echo	                   Also we have backup it up at C:/dissbackup
echo.
echo	                    Put The SD back in your switch and boot
echo.
pause
if exist Clean_Clean.bat (DEL /Q /F Clean_Clean.bat) 
if exist DISS_downloader.bat (DEL /Q /F DISS_downloader.bat) 
pause
del %0

