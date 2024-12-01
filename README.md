# Dotfiles for Windows

## Winget

There is a script in this repository which:

1. Exports all currently installed packages to a file
2. Commits the file to Github

It can be run with:

```powershell
powershell -ExecutionPolicy Bypass -File .\export_winget_packages.ps1
```