function ll { param ([String]$path = ".") Get-ChildItem -Path $path -Exclude .* }

function la { param ([String]$path = ".") Get-ChildItem -Path $path -Force}

function Write-Info { param ([string]$message) Write-Host -ForegroundColor DarkYellow $message}
function Write-Error { param ([string]$message) Write-Host -ForegroundColor DarkRed $message}

function List-Environment { 
    Write-Info "Get-ChildItem Env:"
    Get-ChildItem Env: 
}

function Convert-ToBase64 {
    [Cmdletbinding()]
    param(
        [parameter(ValueFromPipeline)] $Item
    )
    Process {
        return [System.Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes($Item))    
    }
}

function Convert-FromBase64 {
    [Cmdletbinding()]
    param(
        [parameter(ValueFromPipeline)] $Item
    )
    Process {
        return [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($Item))
    }
}
