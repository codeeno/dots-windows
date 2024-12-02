# Dotfiles for Windows

This repository contains some configs from my Windows setup for the purpose of simplifying a fresh install.

## Setting up Git and cloning this repository

To clone this repository:

1. Install Git:

    ```powershell
    winget install -e --id Git.Git
    ```

2. Open a new terminal session and run:

    ```powershell
    git config --global user.email "sebastian@kleboth.de"
    git config --global user.name "codeeno"
    ```
3. (Optional) If not already present, create a directory for Git projects. *If done via the below command, this needs to be done with the terminal opened as an administrator*:

    ```powershell
    New-Item C:\Projects
    ```
4. Clone the repository and `cd` into it:
    ```powershell
    git clone https://github.com/codeeno/dots-windows.git C:\Projects
    cd C:\Projects\dots-windows
    ```

## Winget packages

### Installing packages from export file

To install the packages from export file contained within this repo, `cd` into the root of this repository and run:

```powershell
winget import --no-upgrade -i .\packages\winget_packages.json
```

### Saving installed packages to export file

There is a script in this repository which exports all currently installed packages to a file and, if changes are detected, creates a commit and pushes the changes to Github. To run the script:

```powershell
powershell -ExecutionPolicy Bypass -File .\packages\update_packages_json.ps1
```

### Upgrading packages

```powershell
# Listing available upgrades
winget upgrade --include-unknown

# Upgrading a specific package
winget upgrade 'Dev Home'

# Upgrading all packages
winget upgrade --all
```

### Automatically exporting packages as a scheduled task

This repository also includes a script which creates a task in the Windows Task Scheduler to periodically run the script which exports the current packages to a file. To set it up:

```powershell
cd C:\Projects\dots-windows
powershell -ExecutionPolicy Bypass -File .\packages\schedule_task_update_packages_json.ps1
```

## Custom keyboard layouts

### Layouts

* US with Umlauts: This layout is a copy of the regular US layout, but adds `AltGr + u` as a deadkey to make Umlauts, e.g. `AltGr + u --> a` to produce `ä`.

### Installing a layout

The layouts were created using [Microsoft Keyboard Layout Creator](https://msklc-guide.github.io) (MSKLC) which can be downloaded [here](https://www.microsoft.com/en-us/download/details.aspx?id=102134). *Note: At the time of this writing, there isn't yet an available Winget package for MSKLC.*

1. Install MSKLC from the aforementioned Link and launch it
2. Load the desired `*.klc` file using `File > Load Source File...`
3. Build the installer for the layout using `Project > Build DLL and Setup Package`
4. Run the newly created `setup.exe` to install the layout

The layout can then be added to the language options in the Windows settings.

## TODO
* Make the scheduled task script not flash a command line window to the user when it runs. This can be done by wrapping it in a `cmd` call. See: https://stackoverflow.com/a/67300159
* Make the scheduled task produce a log file. This has kind of worked before, also using `cmd`. See: https://superuser.com/a/1622540
