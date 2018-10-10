function ll { param ([String]$path = ".") Get-ChildItem -Path $path -Exclude .* }

function la { param ([String]$path = ".") Get-ChildItem -Path $path }

function Write-Info { param ([string]$message) Write-Host -ForegroundColor DarkYellow $message}
function Write-Error { param ([string]$message) Write-Host -ForegroundColor DarkRed $message}

function List-Environment { 
    Write-Info "Get-ChildItem Env:"
    Get-ChildItem Env: 
}

function dnwr { dotnet watch run }
function dnr { dotnet run }
function dnb { dotnet build }