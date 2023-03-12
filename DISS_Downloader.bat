@echo off
:downloadfront
COLOR 02
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
echo      ====================== DISS Downloader V0.2.0 ========================
echo                          (cfw / bootloader / assets)
echo      1. This script will download needed files (cfw, bootloader and assets)
echo      2. Clean and backup the files/folders in your SD and Install a new one
echo.
echo      =============Free Space and an internet connection needed=============
echo.
TIMEOUT /T 3
curl "https://raw.githubusercontent.com/team-voidz/DISS-assets/main/Clean_test.bat" --output %~dp0/Clean_Clean.bat
curl "https://raw.githubusercontent.com/team-voidz/DISS-assets/main/DISS_Delete.bat" --output %~dp0/DISS_Delete.bat
TIMEOUT /T 3

call %~dp0\Clean_Clean.bat
