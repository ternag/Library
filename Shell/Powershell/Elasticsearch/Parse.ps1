function Ensure-StartsWithSlash(
  [Parameter(Mandatory = $true)][String]$InputValue
) {
  if ($InputValue.StartsWith("/")) {
    return $InputValue
  }
  else {
    return "/$InputValue"
  }
}

function Get-HttpMethod(
  [Parameter(Mandatory = $true)][String]$InputString
) {
  $ValidHttpMethods = @('GET', 'POST', 'PUT', 'DELETE')

  $tokens = $InputString.Trim().ToUpper().Split(" ");
  $firstToken = $tokens[0];
  $success = $ValidHttpMethods -contains $firstToken;
  if ($success) {
    return $firstToken
  }
  else {
    throw [System.ArgumentException]::new("'$InputString' does not start with a HTTP method.")
  }
}

function Get-PathQuery([Parameter(Mandatory = $true)] [String] $InputString) {
  $tokens = $InputString.Trim().Split(" ");
  $secondToken = $tokens[1];
  if ($secondToken) {
    return $secondToken
  }
  else {
    throw [System.ArgumentException]::new("'$InputString' does not contain a path/query")
  }
  return $secondToken;
}

function Group-Lines(
  [Parameter(Position = 0, Mandatory = $true)][System.Object[]]$Lines
) {
  Process {
    $tmp = New-Object Collections.Generic.List[string];
    $result = New-Object Collections.Generic.List[Collections.Generic.List[string]];
    foreach ($line in $Lines) {
      #Write-Host " o $line"
      if (-not [string]::IsNullOrWhiteSpace($line)) {
        $tmp.Add($line);
      } else {
        if ($tmp.Length -gt 0) {
          $result.Add($tmp);
        }
        $tmp = New-Object Collections.Generic.List[string];
      }
    }
    if($tmp.Length -gt 0)
    {
      $result.Add($tmp)
    }
    
      # $a = New-Object Collections.Generic.List[string];
      # $result.Add($a)
    
    # foreach ($section in $result) {
    #   $req = Read-Request $section;
    #   Write-Host " -> $req"
    # }
    $result
  }
}

function Read-Request(
  [Parameter(Mandatory = $true)] [System.Object[]] $Lines
) {
  Process {
    $firstLine = $Lines[0]
    $method = Get-HttpMethod $firstLine
    $pathQuery = Ensure-StartsWithSlash (GET-PathQuery $firstLine)
    $json = $Lines[1..$Lines.Length]

    $objectProperty = [ordered]@{
      Method    = $method
      PathQuery = $pathQuery
      Body      = "$json"
    }
  
    $request = New-Object -TypeName psobject -Property $objectProperty

    # return new request
    $request
  }
}

function Parse-File(
  [Parameter(Mandatory = $true)] [String] $filename
)
{
  $file = Get-Content $filename
  $requests = Group-Lines $file
  @($requests | ForEach-Object { Read-Request $_ })
}