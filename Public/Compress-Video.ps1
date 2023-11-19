function Compress-Video() {
  <#
    .SYNOPSIS

    .DESCRIPTION
  #>

  param(
    [Parameter(Mandatory)][Alias('I')][string[]]$In,
    [Alias('CV')][string]$vCodec = 'libx265',
    [Alias('CA')][string]$aCodec = 'copy',
    [Alias('R')][int]$Framerate,
    [Alias('C')][int]$CRF,
    [Alias('PS')][string]$Preset,
    [Alias('EXT')][string]$Extension = 'mp4'
  )

  (Get-Item $In) | ForEach-Object {
    $I = "$($_.FullName)"                                         # Input data.
    $O = "$($_.FullName.TrimEnd($_.Extension)).${Extension}"    # Output data.

    $Param = @('-hide_banner')                                  # Hide FFmpeg banner.
    $Param += @('-i', "${I}")                                   # Input data.
    $Param += @('-c:v', "${vCodec}")                          # Video codec.
    if ($CRF) { $Param += @('-crf', "${CRF}") }             # Constant Rate Factor.
    if ($Preset) { $Param += @('-preset', "${Preset}") }    # Video preset.
    if ($Framerate) { $Param += @('-r', "${Framerate}") }   # Video frame rate.
    $Param += @('-c:a', "${aCodec}")                          # Audio codec.
    $Param += @("${O}")                                         # Output data.

    & $(Start-FFmpeg) $Param
  }
}
