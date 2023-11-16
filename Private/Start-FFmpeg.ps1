function Start-FFmpeg {
  <#
    .SYNOPSIS

    .DESCRIPTION
  #>

  Param(
    [Alias('AD')][string[]]$AppData = @('ffmpeg.exe')
  )

  $AppPath = (Split-Path -Path "${PSScriptRoot}" -Parent)
  $App = @{LiteralPath = "${AppPath}"; Filter = "$($AppData[0])"; Recurse = $true; File = $true}
  $App = ((Get-ChildItem @App) | Select-Object -First 1)
  $NL = [Environment]::NewLine

  $AppData | ForEach-Object {
    if (-not (Test-Data -T 'F' -P "$($App.DirectoryName)\${_}")) {
      Write-Msg -T 'W' -A 'Stop' -M ("'${_}' not found!${NL}${NL}" +
      "1. Download '${_}' from 'https://www.gyan.dev/ffmpeg/builds/'.${NL}" +
      "2. Extract all the contents of the archive into a directory '${AppPath}'.")
    }
  }

  $App
}
