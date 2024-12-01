$currentDirectory = Get-Location
$outputFile = "winget_packages.json"

# Create export containing all currently installed packages.
winget export -o "$currentDirectory\$outputFile"

# Check if packages have changed. Disregards the 'CreationDate' line as this is updated with each 'winget export' run.
$changes = git diff -I"CreationDate" .\winget_packages.json

if (-not $changes) {
    Write-Host "No changes detected in '$outputFile'. Skipping commit and push."
} else {
    $commitMessage = "Update winget export for installed packages: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
    git add "$currentDirectory\$outputFile"
    git commit -m $commitMessage
    git push origin main
    Write-Host "Exported packages and pushed commit with message: '$commitMessage'" -ForegroundColor Green
}