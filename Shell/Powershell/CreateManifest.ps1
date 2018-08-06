param(
    [Parameter(Mandatory = $true,
    Position = 0)]
    [String]$modulename
)

$manifest = @{ 
    Path = ".\$modulename\$modulename.psd1"
    RootModule        = "$modulename.psm1"
    Author            = 'Terje Nagel'
}
New-ModuleManifest @manifest