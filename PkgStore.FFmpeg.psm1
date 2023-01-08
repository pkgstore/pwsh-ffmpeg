function Compress-FFmpeg() {
  <#
    .SYNOPSIS

    .DESCRIPTION

    .PARAMETER Files

    .PARAMETER vCodec

    .PARAMETER CRF

    .PARAMETER Preset

    .PARAMETER aCodec

    .PARAMETER Extension

    .EXAMPLE

    .LINK
      Package Store: https://github.com/pkgstore

    .NOTES
      Author: Kitsune Solar <mail@kitsune.solar>
  #>

  [CmdletBinding()]

  Param(
    [Parameter(Mandatory)]
    [Alias('F')]
    [string[]]${Files},

    [Alias('CV')]
    [string]${vCodec} = 'libx265',

    [Alias('C')]
    [int]${CRF} = 28,

    [ValidateSet('ultrafast', 'superfast', 'veryfast', 'faster', 'fast', 'medium', 'slow', 'slower', 'veryslow', 'placebo')]
    [Alias('PS')]
    [string]${Preset} = 'medium',

    [ValidateSet('copy', 'aac')]
    [Alias('CA')]
    [string]${aCodec} = 'copy',

    [Alias('EXT')]
    [string]${Extension} = 'mp4'
  )

  # FFmpeg executable file.
  ${APP} = "${PSScriptRoot}\App\ffmpeg.exe"

  # Checking if a 'ffmpeg.exe' exist.
  if ( -not ( Test-Path -Path "${APP}" -PathType "Leaf" ) ) {
    Write-Msg -T 'E' -M "'ffmpeg.exe' not found!" -A 'Stop'
  }

  ForEach ( ${F} in ( Get-ChildItem ${Files} ) ) {
    # Composing a app command.
    ${CMD} = @( "-i", "$( ${F}.FullName )" )
    ${CMD} += @( "-c:v", "${vCodec}", "-crf", "${CRF}", "-preset", "${Preset}" )
    ${CMD} += @( "-c:a", "${aCodec}" )
    ${CMD} += @( "$( ${F}.FullName + '.' + ${Extension} )" )

    # Running a app.
    & "${APP}" ${CMD}
  }
}
