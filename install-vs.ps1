$path = & "C:\Program Files (x86)\Microsoft Visual Studio\Installer\vswhere.exe" -latest -property installationPath
$config = Join-Path $pwd ".vsconfig"
Write-Host "Found Visual Studio at: $path"

$installer = Join-Path $env:TEMP vs_enterprise.exe
Invoke-WebRequest -Uri 'https://aka.ms/vs/16/pre/vs_enterprise.exe' -OutFile $installer

Write-Host "Updating the installer..."
cmd /c "`"$installer`" --update --wait --quiet"

Write-Host "Installing components..."
cmd /c "`"$installer`" modify --installPath `"$path`" --config $config --quiet --norestart --includeRecommended --wait"

Write-Host "Installation complete."
