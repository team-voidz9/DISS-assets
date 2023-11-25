Write-Host "Asset Downloader Rev.1" -ForegroundColor green -BackgroundColor black
Write-Host "TEAM-VOIDZ"
Write-Host "Latest : -"

$repo1 = "team-voidz/DISS-assets"
$filenamePattern1 = "assets_*.zip"
$innerDirectory = $true
$preRelease = $true

write-host -back Red "Downloading Assets"
Write-Host "1. DISS Assets" -ForegroundColor green -BackgroundColor black
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
write-host -back Red "Latest DISS Assets Downloaded"
