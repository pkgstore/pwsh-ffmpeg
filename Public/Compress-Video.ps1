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

  (Get-Item $P_In) | ForEach-Object {
    $I = "$($_.FullName)"                                         # Input data.
    $O = "$($_.FullName.TrimEnd($_.Extension)).${P_Extension}"    # Output data.

    $Param = @('-hide_banner')                                  # Hide FFmpeg banner.
    $Param += @('-i', "${I}")                                   # Input data.
    $Param += @('-c:v', "${P_vCodec}")                          # Video codec.
    if ($P_CRF) { $Param += @('-crf', "${P_CRF}") }             # Constant Rate Factor.
    if ($P_Preset) { $Param += @('-preset', "${P_Preset}") }    # Video preset.
    if ($P_Framerate) { $Param += @('-r', "${P_Framerate}") }   # Video frame rate.
    $Param += @('-c:a', "${P_aCodec}")                          # Audio codec.
    $Param += @("${O}")                                         # Output data.

    & $(Start-FFmpeg) $Param
  }
}
