# Stop all running Chrome processes
Stop-Process -Name "chrome" -Force -ErrorAction SilentlyContinue

# Specify the user profile directory
$userProfilePath = "$env:USERPROFILE\AppData\Local\Google\Chrome\User Data\Default\Cache"

# Check if the cache directory exists
if (Test-Path -Path $userProfilePath) {
    # Get the number of items before clearing the cache
    $itemsCountBefore = Get-ChildItem -Path $userProfilePath -Recurse | Measure-Object | %{$_.Count}

    # Remove all files in the cache directory
    Remove-Item -Path $userProfilePath\* -Force -Recurse

    # Get the number of items after clearing the cache
    $itemsCountAfter = Get-ChildItem -Path $userProfilePath -Recurse | Measure-Object | %{$_.Count}

    # Check if the cache was successfully cleared
    if ($itemsCountBefore -gt $itemsCountAfter) {
        Write-Host "Cache cleared for Google Chrome"
    } else {
        Write-Host "Failed to clear cache for Google Chrome"
    }
} else {
    Write-Host "Cache directory not found for Google Chrome"
}

# Start Chrome
Start-Process "chrome.exe"
