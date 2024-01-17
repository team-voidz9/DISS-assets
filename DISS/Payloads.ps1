Write-Host "Payloads Downloader Rev.2b" -ForegroundColor green -BackgroundColor black
Write-Host "TEAM-VOIDZ"
Write-Host "Added : toolbox"

#BIN
$repo1 = "suchmememanyskill/TegraExplorer"
$filenamePattern1 = "TegraExplorer.bin"
$repo2 = "jimzrt/Incognito_RCM"
$filenamePattern2 = "Incognito_RCM.bin"
$repo3 = "hwfly-nx/hwfly-toolbox"
$filenamePattern3 = "hwfly_toolbox.bin"

$innerDirectory = $true
$preRelease = $true

write-host -back Red "Downloading Payloads"
Write-Host "1. TegraExplorer" -ForegroundColor green -BackgroundColor black
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

Write-Host "2. Incognito RCM" -ForegroundColor green -BackgroundColor black
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

Write-Host "3. HWFLY toolbox" -ForegroundColor green -BackgroundColor black
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

write-host -back Red "All Latest Payloads Downloaded"

