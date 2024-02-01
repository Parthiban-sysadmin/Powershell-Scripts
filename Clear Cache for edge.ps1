
# Clear cache on Microsoft Edge

function Clear-EdgeCache {
    param (
        [string]$username = $env:USERNAME
    )

    $cachePath = "C:\Users\$username\AppData\Local\Microsoft\Edge\User Data\Default\Cache"

    if (Test-Path -Path $cachePath) {
        $itemsCountBefore = (Get-ChildItem -Path $cachePath -Recurse | Measure-Object).Count

        Remove-Item -Path $cachePath -Recurse -Force

        $itemsCountAfter = (Get-ChildItem -Path $cachePath -Recurse | Measure-Object).Count

        if ($itemsCountBefore -gt $itemsCountAfter) {
            Write-Host "Cache cleared for Microsoft Edge"
        } else {
            Write-Host "Failed to clear cache for Microsoft Edge"
        }
    } else {
        Write-Host "Specified path doesn't exist."
    }
}

# Call the function to clear the cache
Clear-EdgeCache
