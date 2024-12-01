# Set the current directory
$currentDirectory = Get-Location

# Define the output file name with a fixed name (it will be overwritten each time)
$outputFile = "winget_packages.json"

# Export installed packages via winget to the JSON file (overwrites the file every time)
winget export -o "$currentDirectory\$outputFile"

# Check if git is initialized in the current directory
if (-not (Test-Path -Path "$currentDirectory\.git")) {
    Write-Host "Git repository not found in the current directory. Exiting script."
    exit
}

# Change to the current directory (in case script was run from another location)
Set-Location -Path $currentDirectory

# Check if there are differences between the current file and the one in the main branch
$changes = git diff -I"CreationDate" .\winget_packages.json

# Compare the hashes to see if the file has changed
if (-not $changes) {
    Write-Host "No changes detected in '$outputFile'. Skipping commit and push."
} else {
    # Stage the changes (add the exported JSON file)
    git add "$currentDirectory\$outputFile"

    # Create the commit message using the current date and time
    $commitMessage = "Update winget export for installed packages: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"

    # Commit the changes with the date and time as the message
    git commit -m $commitMessage

    # Push the commit to the remote repository (assuming the default remote is 'origin' and the default branch is 'main')
    git push origin main

    # Notify the user that the operation is complete
    Write-Host "Exported packages and pushed commit with message: '$commitMessage'" -ForegroundColor Green
}