@echo off
:deleteDelete
if exist "%~dp0:\Clean_Clean.bat" (
    Del /F "%~dp0:\Clean_Clean.bat"
    )
if exist "%~dp0:\DISS_downloader.bat" (
    Del /F "%~dp0:\DISS_downloader.bat"
    )
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
del /F %0

