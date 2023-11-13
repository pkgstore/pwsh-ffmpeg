<#PSScriptInfo
  .VERSION      0.1.0
  .GUID         82549e1a-69f4-407b-baff-4f97d75b9852
  .AUTHOR       Kitsune Solar
  .AUTHOREMAIL  mail@kitsune.solar
  .COMPANYNAME  iHub.TO
  .COPYRIGHT    2023 Kitsune Solar. All rights reserved.
  .LICENSEURI   https://github.com/pkgstore/pwsh-ffmpeg/blob/main/LICENSE
  .PROJECTURI   https://github.com/pkgstore/pwsh-ffmpeg
#>

$App = @('ffmpeg.exe')
$AppExe = @{LiteralPath = "${PSScriptRoot}"; Filter = "$($App[0])"; Recurse = $true; File = $true}
$AppExe = ((Get-ChildItem @AppExe) | Select-Object -First 1)
$NL = "$([Environment]::NewLine)"

function Compress-Video() {
  <#
    .SYNOPSIS

    .DESCRIPTION
  #>

  Param(
    [Parameter(Mandatory)][Alias('I')][string[]]$P_In,
    [Alias('CV')][string]$P_vCodec = 'libx265',
    [Alias('CA')][string]$P_aCodec = 'copy',
    [Alias('R')][int]$P_Framerate,
    [Alias('C')][int]$P_CRF,
    [Alias('PS')][string]$P_Preset,
    [Alias('EXT')][string]$P_Extension = 'mp4'
  )

  # Checking FFmpeg location.
  Test-FFmpeg

  (Get-Item $P_In) | ForEach-Object {
    $I = "$($_.FullName)"                                         # Input data.
    $O = "$($_.FullName.TrimEnd($_.Extension)).${P_Extension}"    # Output data.

    $Param = @('-hide_banner')                                    # Hide FFmpeg banner.
    $Param += @('-i', "${I}")                                   # Input data.
    $Param += @('-c:v', "${P_vCodec}")                          # Video codec.
    if ($P_CRF) { $Param += @('-crf', "${P_CRF}") }               # Constant Rate Factor.
    if ($P_Preset) { $Param += @('-preset', "${P_Preset}") }    # Video preset.
    if ($P_Framerate) { $Param += @('-r', "${P_Framerate}") }     # Video frame rate.
    $Param += @('-c:a', "${P_aCodec}")                          # Audio codec.
    $Param += @("${O}")                                         # Output data.

    & "${AppExe}" $Param
  }
}

function Test-FFmpeg {
  <#
    .SYNOPSIS

    .DESCRIPTION
  #>

  # Getting 'curl.exe' directory.
  $Dir = "$($AppExe.DirectoryName)"

  # Checking the location of files.
  $App | ForEach-Object {
    if (-not (Test-Data -T 'F' -P "${Dir}\${_}")) {
      Write-Msg -T 'W' -A 'Stop' -M ("'${_}' not found!${NL}${NL}" +
      "1. Download '${_}' from 'https://www.gyan.dev/ffmpeg/builds/'.${NL}" +
      "2. Extract all the contents of the archive into a directory '${PSScriptRoot}'.")
    }
  }
}
