Set-Location ~

function ll { Get-ChildItem -Exclude .* }
function la { Get-ChildItem }

function Start-TestShell {
    pwsh -NoExit -NoProfile -Command {
            function prompt { 
                Write-Host -NoNewline -ForegroundColor Green "$($pwd.Path.Substring($pwd.Path.LastIndexOf("\"))) TEST";
                return ">"
            }
        }
}

Set-Alias -Name sts -Value Start-TestShell