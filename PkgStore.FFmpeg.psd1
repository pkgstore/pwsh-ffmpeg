@{
  RootModule = 'PkgStore.FFmpeg.psm1'
  ModuleVersion = '1.0.0'
  GUID = '82549e1a-69f4-407b-baff-4f97d75b9852'
  Author = 'Kitsune Solar'
  CompanyName = 'v77 Development'
  Copyright = '(c) 2023 v77 Development. All rights reserved.'
  Description = ''
  PowerShellVersion = '7.1'
  RequiredModules = @('PkgStore.Kernel')
  FunctionsToExport = @('Compress-FFmpeg')
  PrivateData = @{
    PSData = @{
      Tags = @('pwsh', 'ffmpeg')
      LicenseUri = 'https://github.com/pkgstore/pwsh-ffmpeg/blob/main/LICENSE'
      ProjectUri = 'https://github.com/pkgstore/pwsh-ffmpeg'
    }
  }
}
