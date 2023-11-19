function Compress-Video() {
  <#
    .SYNOPSIS
    Video compression script based on FFmpeg.

    .DESCRIPTION
    FFmpeg is a free and open-source software project consisting of a suite of libraries and programs for handling video, audio, and other multimedia files and streams.

    .PARAMETER In
    An array of input files.

    .PARAMETER vCodec
    The video codec.

    .PARAMETER aCodec
    The audio codec.

    .PARAMETER Framerate
    FFmpeg can be used to change the frame rate of an existing video, such that the output frame rate is lower or higher than the input frame rate. The output duration of the video will stay the same.
    This is useful when working with, for example, high-framerate input video that needs to be temporally scaled down for devices that do not support high FPS.
    When the frame rate is changed, FFmpeg will drop or duplicate frames as necessary to achieve the targeted output frame rate.

    .PARAMETER CRF
    Constant Rate Factor.
    Use this rate control mode if you want to keep the best quality and care less about the file size. This is the recommended rate control mode for most uses.
    This method allows the encoder to attempt to achieve a certain output quality for the whole file when output file size is of less importance. This provides maximum compression efficiency with a single pass. By adjusting the so-called quantizer for each frame, it gets the bitrate it needs to keep the requested quality level. The downside is that you can't tell it to get a specific filesize or not go over a specific size or bitrate, which means that this method is not recommended for encoding videos for streaming.

    .PARAMETER Preset
    A preset is a collection of options that will provide a certain encoding speed to compression ratio. A slower preset will provide better compression (compression is quality per filesize). This means that, for example, if you target a certain file size or constant bit rate, you will achieve better quality with a slower preset. Similarly, for constant quality encoding, you will simply save bitrate by choosing a slower preset.

    .PARAMETER Extension
    The extension of the resulting files.

    .EXAMPLE
    Compress-Video -In 'File_01.MOV', 'File_02.MOV', 'File_03.MOV'

    .EXAMPLE
    Compress-Video -In '*.MOV'
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
    $I = "$($_.FullName)"                                       # Input data.
    $O = "$($_.FullName.TrimEnd($_.Extension)).${Extension}"    # Output data.

    $Param = @('-hide_banner')                              # Hide FFmpeg banner.
    $Param += @('-i', "${I}")                               # Input data.
    $Param += @('-c:v', "${vCodec}")                        # Video codec.
    if ($CRF) { $Param += @('-crf', "${CRF}") }             # Constant Rate Factor.
    if ($Preset) { $Param += @('-preset', "${Preset}") }    # Video preset.
    if ($Framerate) { $Param += @('-r', "${Framerate}") }   # Video frame rate.
    $Param += @('-c:a', "${aCodec}")                        # Audio codec.
    $Param += @("${O}")                                     # Output data.

    & $(Start-FFmpeg) $Param
  }
}
