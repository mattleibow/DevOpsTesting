Param(
    [string] $Version = "16/pre"
)

$ErrorActionPreference = 'Stop'

Write-Host "Downloading Visual Studio ($Version)..."
Invoke-WebRequest -UseBasicParsing `
    -Uri "https://aka.ms/vs/$Version/vs_community.exe" `
    -OutFile vs_community.exe

Write-Host "Updating the Visual Studio Installer..."
./vs_community.exe --update --quiet --norestart --wait | Out-Null

Write-Host "Installing Visual Studio..."
./vs_community.exe --quiet --norestart --wait `
  --add Microsoft.VisualStudio.Workload.NetCrossPlat `
  --add Microsoft.VisualStudio.Workload.NetCoreTools `
  --add Microsoft.VisualStudio.Workload.ManagedDesktop `
  --add Microsoft.VisualStudio.Workload.Universal `
  | Out-Null

$vsLogs = 'output\vs-logs'
New-Item -ItemType Directory -Force -Path "$vsLogs" | Out-Null
Copy-Item -Path "$env:TEMP\dd_*" -Destination "$vsLogs" -Recurse
Copy-Item -Path "$env:TEMP\dd_*\*" -Destination "$vsLogs" -Recurse

Remove-Item vs_community.exe

$vswhere = "${env:ProgramFiles(x86)}\Microsoft Visual Studio\Installer\vswhere.exe"

Write-Host "Setting Environment Variables..."
$installationPath = & $vswhere -latest -prerelease -property installationPath
Write-Host "##vso[task.prependpath]$installationPath\MSBuild\Current\Bin"
Write-Host "##vso[task.setvariable variable=VS_INSTALL]$installationPath"

Write-Host "Installed Visual Studio Versions:"
& $vswhere -all -prerelease -property installationPath

exit $LASTEXITCODE
