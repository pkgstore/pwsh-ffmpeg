function Compress-FFmpeg() {
  <#
    .SYNOPSIS

    .DESCRIPTION

    .PARAMETER Path

    .PARAMETER Time

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

    [Alias('VC')]
    [string]${vCodec} = 'libx265',

    [int]${CRF} = 28
  )

  # RAR executable file.
  ${APP} = "${PSScriptRoot}\App\ffmpeg.exe"

  ForEach ( ${F} in ( Get-ChildItem ${Files} ) ) {
    # Composing a app command.
    ${CMD} = @( "-i '$( ${F}.FullName )'" )
    ${CMD} += @( "-vcodec ${vCodec}", "-crf ${CRF}" )
    ${CMD} += @( "$( ${F}.FullName + '.' + ${Extension} )" )

    # Running a app.
    & "${APP}" ${CMD}
  }
}
