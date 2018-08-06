<#
    .SYNOPSIS
    .DESCRIPTION
    .EXAMPLE
    .PARAMETER
    .INPUTS
    .OUTPUTS
    .NOTES
    .LINK
#>
Function Verb-Noun{
    [CmdletBinding()] #Enable all the default paramters, including -Verbose
    Param(
        [Parameter(Mandatory=$true,
            ValueFromPipeline=$true,
            ValueFromPipelineByPropertyName=$true,
            HelpMessage='HelpMessage',
            Position=0)]
        [ValidatePattern('[A-Z]')] #Validate that the string only contains letter
        [String[]]$PipelineInput
    )

    Begin{
        Write-Verbose -Message "Starting $($MyInvocation.InvocationName) with $($PsCmdlet.ParameterSetName) parameterset..."
    }
    Process{
        ForEach($Object in $PipelineInput){ #Pipeline input
            try{ #Error handling
                Write-Verbose -Message "Doing something on $Object..."
                $Result = $Object | Do-SomeThing -ErrorAction Stop
                
                #Generate Output
                New-Object -TypeName PSObject -Property @{
                    Result = $Result
                    Object = $Object
                }
            }
            catch{
                Write-Error -Message "$_ went wrong on $Object"
            }
        }
    }
    End{
        Write-Verbose -Message "Ending $($MyInvocation.InvocationName)..."
    }
}