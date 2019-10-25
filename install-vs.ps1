$path = & "C:\Program Files (x86)\Microsoft Visual Studio\Installer\vswhere.exe" -latest -property installationPath
Write-Host "Found Visual Studio at: $path"

$installer = Join-Path $env:TEMP vs_enterprise.exe
Invoke-WebRequest -Uri 'https://aka.ms/vs/16/release/vs_enterprise.exe' -OutFile $installer

Write-Host "Updating the installer..."
Start-Process -FilePath $installer -ArgumentList "--update", "--wait", "--quiet" -Wait -PassThru

Write-Host "Installing components..."
Start-Process -FilePath $installer -ArgumentList "modify", "--installPath", $path, "--add", "Microsoft.VisualStudio.Component.VC.v141.x86.x64", "--quiet", "--norestart", "--includeRecommended", "--wait" -Wait -PassThru

Write-Host "Installation complete."
