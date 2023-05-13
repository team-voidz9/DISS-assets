Write-Host "Asset Downloader Rev.1" -ForegroundColor green -BackgroundColor black
Write-Host "TEAM-VOIDZ"
Write-Host "Latest : -"

$repo = "team-voidz/DISS-assets"
$filenamePattern = "assets_*.zip"
$innerDirectory = $true
$preRelease = $true

if ($preRelease) {
    $releasesUri = "https://api.github.com/repos/$repo/releases"
    $downloadUri = ((Invoke-RestMethod -Method GET -Uri $releasesUri)[0].assets | Where-Object name -like $filenamePattern ).browser_download_url
}
else {
    $releasesUri = "https://api.github.com/repos/$repo/releases/latest"
    $downloadUri = ((Invoke-RestMethod -Method GET -Uri $releasesUri).assets | Where-Object name -like $filenamePattern ).browser_download_url
}

#  Casting to UriBuilder will split the URI into separate properties. Helpful for isolating path, query string, fragment, etc.
$downloadUriBuilder = [System.UriBuilder] $downloadUri

# Split for the last item in the URI Path 
# Alternative: [System.IO.Path]::GetFileName($downloadUriBuilder.Path)
$filename = Split-Path -Path ($downloadUriBuilder.Path) -Leaf       

# (Optional) Decode any URL-encoded characters
$filenameUrlDecoded = [System.Web.HttpUtility]::UrlDecode($filename)

Invoke-WebRequest -Uri $downloadUri -Out $filenameUrlDecoded
write-host -back Red "Latest DISS Assets Downloaded"
