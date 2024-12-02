$currentDirectory = Get-Location
$scriptName = "update_packages_json.ps1"
$workingDirectory = "$currentDirectory\packages"
$scriptPath = "$workingDirectory\$scriptName"

$taskName = "RunWingetExport"
$triggerTime = "03:00"

$action = New-ScheduledTaskAction -WorkingDirectory $workingDirectory -Execute "powershell.exe" -Argument "-ExecutionPolicy Bypass -WindowStyle hidden -File $scriptPath"
$trigger = New-ScheduledTaskTrigger -Daily -At $triggerTime
$settings = New-ScheduledTaskSettingsSet -StartWhenAvailable

Register-ScheduledTask -Action $action -Trigger $trigger -TaskName $taskName -Settings $settings -Description "Runs PowerShell script to run winget export daily"