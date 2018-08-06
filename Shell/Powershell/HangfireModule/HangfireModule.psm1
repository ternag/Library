Function New-IndexPattern {
    [CmdletBinding()] #Enable all the default paramters, including -Verbose
    Param(
        [Parameter(Mandatory = $true,
            HelpMessage = 'HelpMessage',
            Position = 0)]
        [String]$indexPatternName,

        [Parameter(Mandatory = $false,
            HelpMessage = 'ex: http://localhost:5601',
            Position = 1)]
        [String]$kibanaHostUrl = "http://localhost:5601"
    )
    End {
        # POST /api/saved_objects/index-pattern
        # {"attributes":{"title":"st-log-event*","timeFieldName":"@timestamp"}}
    
        $headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
        $headers.Add("kbn-xsrf", "reporting")
        
        $body = "{""attributes"":{""title"":""$indexPatternName"",""timeFieldName"":""@timestamp""}}"
        
        Invoke-RestMethod $kibanaHostUrl"/api/saved_objects/index-pattern" -Method Post -Body $body -Headers $headers -ContentType 'application/json'
    }
}
 
function Remove-IndexPattern {
    [CmdletBinding()] #Enable all the default paramters, including -Verbose
    Param(
        [Parameter(Mandatory = $true,
            HelpMessage = 'HelpMessage',
            Position = 0)]
        [String]$id,

        [Parameter(Mandatory = $false,
            HelpMessage = 'ex: http://localhost:5601',
            Position = 1)]
        [String]$kibanaHostUrl = "http://localhost:5601"
    )

    # DELETE /api/saved_objects/index-pattern/951947a0-9706-11e8-80c4-472ffabe5622

    Invoke-RestMethod $kibanaHostUrl"/api/saved_objects/index-pattern/$id" -Method Delete
}
  
function Get-IndexPatternId {
    [CmdletBinding()] #Enable all the default paramters, including -Verbose
    Param(
        [Parameter(Mandatory = $true,
            HelpMessage = 'HelpMessage',
            Position = 0)]
        [String]$indexPatternName,

        [Parameter(Mandatory = $false,
            HelpMessage = 'ex: http://localhost:5601',
            Position = 1)]
        [String]$kibanaHostUrl = "http://localhost:5601"
    )    
    
    # GET /api/saved_objects/?type=index-pattern&fields=title&per_page=10000
  
    $indexPatterns = Invoke-RestMethod $kibanaHostUrl"/api/saved_objects/?type=index-pattern&fields=title" | Select-Object -property 'saved_objects'
    $tmp = $indexPatterns.saved_objects | Where-Object { $_.attributes.title -eq $indexPatternName }
    $tmp.id
}

# Get-IndexPatternId("st-log*")
  
# New-IndexPattern("st-log-event*")