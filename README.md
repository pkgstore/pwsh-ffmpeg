# PowerShell FFmpeg Module

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
