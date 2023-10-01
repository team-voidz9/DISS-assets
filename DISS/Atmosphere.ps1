Write-Host "Atmosphere Downloader Rev.1" -ForegroundColor green -BackgroundColor black
Write-Host "TEAM-VOIDZ"
Write-Host "Latest : -"

$repo = "Atmosphere-NX/Atmosphere"
$filenamePattern = "*+hbmenu-*.zip"
$filenamePattern2 = "fusee.bin"
$innerDirectory = $true
$preRelease = $true
#atmos
if ($preRelease) {
    $releasesUri = "https://api.github.com/repos/$repo/releases"
    $downloadUri = ((Invoke-RestMethod -Method GET -Uri $releasesUri)[0].assets | Where-Object name -like $filenamePattern ).browser_download_url
}
else {
    $releasesUri = "https://api.github.com/repos/$repo/releases/latest"
    $downloadUri = ((Invoke-RestMethod -Method GET -Uri $releasesUri).assets | Where-Object name -like $filenamePattern ).browser_download_url
}

$downloadUriBuilder = [System.UriBuilder] $downloadUri
$filename = Split-Path -Path ($downloadUriBuilder.Path) -Leaf       
$filenameUrlDecoded = [System.Web.HttpUtility]::UrlDecode($filename)
Invoke-WebRequest -Uri $downloadUri -Out $filenameUrlDecoded

#fusee
if ($preRelease) {
    $releasesUri2 = "https://api.github.com/repos/$repo/releases"
    $downloadUri2 = ((Invoke-RestMethod -Method GET -Uri $releasesUri2)[0].assets | Where-Object name -like $filenamePattern2 ).browser_download_url
}
else {
    $releasesUri2 = "https://api.github.com/repos/$repo/releases/latest"
    $downloadUri2 = ((Invoke-RestMethod -Method GET -Uri $releasesUri2).assets | Where-Object name -like $filenamePattern2 ).browser_download_url
}

$downloadUriBuilder2 = [System.UriBuilder] $downloadUri2
$filename2 = Split-Path -Path ($downloadUriBuilder2.Path) -Leaf       
$filenameUrlDecoded2 = [System.Web.HttpUtility]::UrlDecode($filename2)

Invoke-WebRequest -Uri $downloadUri -Out $filenameUrlDecoded2

write-host -back Red "Latest Atmosphere Downloaded."
