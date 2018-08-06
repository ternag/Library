try {
    function Deploy($location)
    {
        $moduleFolder = $Env:USERPROFILE + "\Documents\$location\Modules";
        $profileModuleFolder = $moduleFolder + "\ProfileModule"
        New-Item -ItemType Directory -Force -Path $moduleFolder | Out-Null
        if(Test-Path $profileModuleFolder) { Remove-Item -Path $profileModuleFolder -Recurse | Out-Null }
        Copy-Item .\ProfileModule $moduleFolder -Recurse | Out-Null
        Write-Host -ForegroundColor DarkYellow "ProfileModule updated"
    }

    Deploy("PowerShell")
    Deploy("WindowsPowerShell")
}
catch {
    Write-Host -ForegroundColor DarkRed "An error occcured"
}
