Write-Host "Payloads and Homebrews Downloader Rev.8a" -ForegroundColor green -BackgroundColor black
Write-Host "TEAM-VOIDZ"
Write-Host "Latest : remove ldn_MITM"
Write-Host "Latest : added aio_updater"

#NROs
$repo1 = "tomvita/Breeze-Beta"
$filenamePattern1 = "Breeze.zip"
$repo2 = "tomvita/EdiZon-SE"
$filenamePattern2 = "EdiZon.zip"
$repo3 = "tomvita/NXCheatCode"
$filenamePattern3 = "titles.zip"
$repo4 = "rashevskyv/dbi"
$filenamePattern41 = "dbi.nro"
$filenamePattern42 = "dbi.config"
$repo5 = "J-D-K/JKSV"
$filenamePattern5 = "jksv.nro"
$repo6 = "fortheusers/hb-appstore"
$filenamePattern6 = "appstore.nro"
$repo7 = "rdmrocha/linkalho"
$filenamePattern7 = "linkalho-*.zip"
$repo8 = "ITotalJustice/sys-patch"
$filenamePattern8 = "sys-patch.zip"
$repo9 = "HamletDuFromage/aio-switch-updater"
$filenamePattern9 = "aio-switch-updater.zip"
$repo10 = "zdm65477730/NX-Activity-Log"
$filenamePattern10 = "NX-Activity-Log.zip"

#BIN
$repo11 = "suchmememanyskill/TegraExplorer"
$filenamePattern11 = "TegraExplorer.bin"
$repo12 = "jimzrt/Incognito_RCM"
$filenamePattern12 = "Incognito_RCM.bin"

$innerDirectory = $true
$preRelease = $true

write-host -back Red "Downloading Homebrews"
Write-Host "1. Breeze" -ForegroundColor green -BackgroundColor black
if ($preRelease) {
    $releasesUri1 = "https://api.github.com/repos/$repo1/releases"
    $downloadUri1 = ((Invoke-RestMethod -Method GET -Uri $releasesUri1)[0].assets | Where-Object name -like $filenamePattern1 ).browser_download_url
}
else {
    $releasesUri1 = "https://api.github.com/repos/$repo1/releases/latest"
    $downloadUri1 = ((Invoke-RestMethod -Method GET -Uri $releasesUri1).assets | Where-Object name -like $filenamePattern1 ).browser_download_url
}
$downloadUriBuilder1 = [System.UriBuilder] $downloadUri1
$filename1 = Split-Path -Path ($downloadUriBuilder1.Path) -Leaf       
$filenameUrlDecoded1 = [System.Web.HttpUtility]::UrlDecode($filename1)
Invoke-WebRequest -Uri $downloadUri1 -Out $filenameUrlDecoded1

Write-Host "2. Edizon" -ForegroundColor green -BackgroundColor black
if ($preRelease) {
    $releasesUri2 = "https://api.github.com/repos/$repo2/releases"
    $downloadUri2 = ((Invoke-RestMethod -Method GET -Uri $releasesUri2)[0].assets | Where-Object name -like $filenamePattern2 ).browser_download_url
}
else {
    $releasesUri2 = "https://api.github.com/repos/$repo2/releases/latest"
    $downloadUri2 = ((Invoke-RestMethod -Method GET -Uri $releasesUri2).assets | Where-Object name -like $filenamePattern2 ).browser_download_url
}
$downloadUriBuilder2 = [System.UriBuilder] $downloadUri2
$filename2 = Split-Path -Path ($downloadUriBuilder2.Path) -Leaf       
$filenameUrlDecoded2 = [System.Web.HttpUtility]::UrlDecode($filename2)
Invoke-WebRequest -Uri $downloadUri2 -Out $filenameUrlDecoded2

Write-Host "3. Breeze/Edizon Cheats" -ForegroundColor green -BackgroundColor black
if ($preRelease) {
    $releasesUri3 = "https://api.github.com/repos/$repo3/releases"
    $downloadUri3 = ((Invoke-RestMethod -Method GET -Uri $releasesUri3)[0].assets | Where-Object name -like $filenamePattern3 ).browser_download_url
}
else {
    $releasesUri3 = "https://api.github.com/repos/$repo3/releases/latest"
    $downloadUri3 = ((Invoke-RestMethod -Method GET -Uri $releasesUri3).assets | Where-Object name -like $filenamePattern3 ).browser_download_url
}
$downloadUriBuilder3 = [System.UriBuilder] $downloadUri3
$filename3 = Split-Path -Path ($downloadUriBuilder3.Path) -Leaf       
$filenameUrlDecoded3 = [System.Web.HttpUtility]::UrlDecode($filename3)
Invoke-WebRequest -Uri $downloadUri3 -Out $filenameUrlDecoded3

Write-Host "4. DBI" -ForegroundColor green -BackgroundColor black
if ($preRelease) {
    $releasesUri41 = "https://api.github.com/repos/$repo4/releases"
    $downloadUri41 = ((Invoke-RestMethod -Method GET -Uri $releasesUri41)[0].assets | Where-Object name -like $filenamePattern41 ).browser_download_url
}
else {
    $releasesUri41 = "https://api.github.com/repos/$repo4/releases/latest"
    $downloadUri41 = ((Invoke-RestMethod -Method GET -Uri $releasesUri41).assets | Where-Object name -like $filenamePattern41 ).browser_download_url
}
$downloadUriBuilder41 = [System.UriBuilder] $downloadUri41
$filename41 = Split-Path -Path ($downloadUriBuilder41.Path) -Leaf       
$filenameUrlDecoded41 = [System.Web.HttpUtility]::UrlDecode($filename41)
Invoke-WebRequest -Uri $downloadUri41 -Out $filenameUrlDecoded41

if ($preRelease) {
    $releasesUri42 = "https://api.github.com/repos/$repo4/releases"
    $downloadUri42 = ((Invoke-RestMethod -Method GET -Uri $releasesUri42)[0].assets | Where-Object name -like $filenamePattern42 ).browser_download_url
}
else {
    $releasesUri42 = "https://api.github.com/repos/$repo4/releases/latest"
    $downloadUri42 = ((Invoke-RestMethod -Method GET -Uri $releasesUri42).assets | Where-Object name -like $filenamePattern42 ).browser_download_url
}
$downloadUriBuilder42 = [System.UriBuilder] $downloadUri42
$filename42 = Split-Path -Path ($downloadUriBuilder42.Path) -Leaf       
$filenameUrlDecoded42 = [System.Web.HttpUtility]::UrlDecode($filename42)
Invoke-WebRequest -Uri $downloadUri42 -Out $filenameUrlDecoded42

Write-Host "5. JKSV" -ForegroundColor green -BackgroundColor black
if ($preRelease) {
    $releasesUri5 = "https://api.github.com/repos/$repo5/releases"
    $downloadUri5 = ((Invoke-RestMethod -Method GET -Uri $releasesUri5)[0].assets | Where-Object name -like $filenamePattern5 ).browser_download_url
}
else {
    $releasesUri5 = "https://api.github.com/repos/$repo5/releases/latest"
    $downloadUri5 = ((Invoke-RestMethod -Method GET -Uri $releasesUri5).assets | Where-Object name -like $filenamePattern5 ).browser_download_url
}
$downloadUriBuilder5 = [System.UriBuilder] $downloadUri5
$filename5 = Split-Path -Path ($downloadUriBuilder5.Path) -Leaf       
$filenameUrlDecoded5 = [System.Web.HttpUtility]::UrlDecode($filename5)
Invoke-WebRequest -Uri $downloadUri5 -Out $filenameUrlDecoded5

Write-Host "6. APPSTORE" -ForegroundColor green -BackgroundColor black
if ($preRelease) {
    $releasesUri6 = "https://api.github.com/repos/$repo6/releases"
    $downloadUri6 = ((Invoke-RestMethod -Method GET -Uri $releasesUri6)[0].assets | Where-Object name -like $filenamePattern6 ).browser_download_url
}
else {
    $releasesUri6 = "https://api.github.com/repos/$repo6/releases/latest"
    $downloadUri6 = ((Invoke-RestMethod -Method GET -Uri $releasesUri6).assets | Where-Object name -like $filenamePattern6 ).browser_download_url
}
$downloadUriBuilder6 = [System.UriBuilder] $downloadUri6
$filename6 = Split-Path -Path ($downloadUriBuilder6.Path) -Leaf       
$filenameUrlDecoded6 = [System.Web.HttpUtility]::UrlDecode($filename6)
Invoke-WebRequest -Uri $downloadUri6 -Out $filenameUrlDecoded6

Write-Host "7. Linkalho" -ForegroundColor green -BackgroundColor black
if ($preRelease) {
    $releasesUri7 = "https://api.github.com/repos/$repo7/releases"
    $downloadUri7 = ((Invoke-RestMethod -Method GET -Uri $releasesUri7)[0].assets | Where-Object name -like $filenamePattern7 ).browser_download_url
}
else {
    $releasesUri7 = "https://api.github.com/repos/$repo7/releases/latest"
    $downloadUri7 = ((Invoke-RestMethod -Method GET -Uri $releasesUri7).assets | Where-Object name -like $filenamePattern7 ).browser_download_url
}
$downloadUriBuilder7 = [System.UriBuilder] $downloadUri7
$filename7 = Split-Path -Path ($downloadUriBuilder7.Path) -Leaf       
$filenameUrlDecoded7 = [System.Web.HttpUtility]::UrlDecode($filename7)
Invoke-WebRequest -Uri $downloadUri7 -Out $filenameUrlDecoded7

Write-Host "8. Sys-Patch" -ForegroundColor green -BackgroundColor black
if ($preRelease) {
    $releasesUri8 = "https://api.github.com/repos/$repo8/releases"
    $downloadUri8 = ((Invoke-RestMethod -Method GET -Uri $releasesUri8)[0].assets | Where-Object name -like $filenamePattern8 ).browser_download_url
}
else {
    $releasesUri8 = "https://api.github.com/repos/$repo8/releases/latest"
    $downloadUri8 = ((Invoke-RestMethod -Method GET -Uri $releasesUri8).assets | Where-Object name -like $filenamePattern8 ).browser_download_url
}
$downloadUriBuilder8 = [System.UriBuilder] $downloadUri8
$filename8 = Split-Path -Path ($downloadUriBuilder8.Path) -Leaf       
$filenameUrlDecoded8 = [System.Web.HttpUtility]::UrlDecode($filename8)
Invoke-WebRequest -Uri $downloadUri8 -Out $filenameUrlDecoded8

Write-Host "9. AIO-Updater" -ForegroundColor green -BackgroundColor black
if ($preRelease) {
    $releasesUri9 = "https://api.github.com/repos/$repo9/releases"
    $downloadUri9 = ((Invoke-RestMethod -Method GET -Uri $releasesUri9)[0].assets | Where-Object name -like $filenamePattern9 ).browser_download_url
}
else {
    $releasesUri9 = "https://api.github.com/repos/$repo9/releases/latest"
    $downloadUri9 = ((Invoke-RestMethod -Method GET -Uri $releasesUri9).assets | Where-Object name -like $filenamePattern9 ).browser_download_url
}
$downloadUriBuilder9 = [System.UriBuilder] $downloadUri9
$filename9 = Split-Path -Path ($downloadUriBuilder9.Path) -Leaf       
$filenameUrlDecoded9 = [System.Web.HttpUtility]::UrlDecode($filename9)
Invoke-WebRequest -Uri $downloadUri9 -Out $filenameUrlDecoded9

Write-Host "10. NX Activity Log" -ForegroundColor green -BackgroundColor black
if ($preRelease) {
    $releasesUri10 = "https://api.github.com/repos/$repo10/releases"
    $downloadUri10 = ((Invoke-RestMethod -Method GET -Uri $releasesUri10)[0].assets | Where-Object name -like $filenamePattern10 ).browser_download_url
}
else {
    $releasesUri10 = "https://api.github.com/repos/$repo10/releases/latest"
    $downloadUri10 = ((Invoke-RestMethod -Method GET -Uri $releasesUri10).assets | Where-Object name -like $filenamePattern10 ).browser_download_url
}
$downloadUriBuilder10 = [System.UriBuilder] $downloadUri10
$filename10 = Split-Path -Path ($downloadUriBuilder10.Path) -Leaf       
$filenameUrlDecoded10 = [System.Web.HttpUtility]::UrlDecode($filename10)
Invoke-WebRequest -Uri $downloadUri10 -Out $filenameUrlDecoded10


write-host -back Red "All Latest Homebrews Downloaded"
