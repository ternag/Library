# Profile

Import-Module ProfileModule -WarningAction SilentlyContinue

# install posh-git by running:
# > PowerShellGet\Install-Module posh-git -Scope CurrentUser -AllowPrerelease -Force
# Import-Module posh-git

function Start-TestShell ([string]$Module)
{
  pwsh -NoExit -NoProfile -Command {
    param($Module)
    Import-Module ProfileModule -WarningAction SilentlyContinue
    if($Module)
    {
      Import-Module -Name $Module
      Write-Host "Imported module: " $Module
    }
    function prompt { 
      Write-Host -NoNewline -ForegroundColor Green "$($pwd.Path.Substring($pwd.Path.LastIndexOf("\"))) TEST";
      return ">"
    }
  } -args $Module
}

Set-Alias -Name sts -Value Start-TestShell
