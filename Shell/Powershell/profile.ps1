
Import-Module ProfileModule

function Start-TestShell {
    pwsh -NoExit -NoProfile -Command {
        Import-Module ProfileModule
        function prompt { 
            Write-Host -NoNewline -ForegroundColor Green "$($pwd.Path.Substring($pwd.Path.LastIndexOf("\"))) TEST";
            return ">"
        }
    }
}

Set-Alias -Name sts -Value Start-TestShell
