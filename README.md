# PowerShell FFmpeg Module

A script for quickly batch converting video files from one format to another, mainly to reduce the size. The script is not intended for complex video editing!

## Install

```powershell
${MOD} = "FFmpeg"; ${PFX} = "PkgStore"; ${DIR} = "$( (${env:PSModulePath} -split ';')[0] )"; Invoke-WebRequest "https://github.com/pkgstore/pwsh-${MOD}/archive/refs/heads/main.zip" -OutFile "${DIR}\${MOD}.zip"; Expand-Archive -Path "${DIR}\${MOD}.zip" -DestinationPath "${DIR}"; if ( Test-Path -Path "${DIR}\${PFX}.${MOD}" ) { Remove-Item -Path "${DIR}\${PFX}.${MOD}" -Recurse -Force }; Rename-Item -Path "${DIR}\pwsh-${MOD}-main" -NewName "${DIR}\${PFX}.${MOD}"; Remove-Item -Path "${DIR}\${MOD}.zip";
```

## Syntax

For syntax information, enter module info command and get help command.

```powershell
Get-Command -Module 'PkgStore.FFmpeg'
```

```powershell
Get-Help '<COMMAND-NAME>'
```

## Documentation

- [PowerShell FFmpeg](https://lib.onl/ru/articles/2023/10/2a73410a-6611-570c-9ab4-dc8cc8998146/)
