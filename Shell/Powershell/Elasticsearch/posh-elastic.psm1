class EsRequest {
  [ValidateNotNullOrEmpty()][string]$Method
  [ValidateNotNullOrEmpty()][string]$PathQuery
  [string]$Body

  EsRequest($Method, $PathQuery, $Body) {
    $this.Method = $Method
    $this.PathQuery = $PathQuery
    $this.Body = $Body
  }

  [String] ToString() {
    return $this.Method + '; ' + $this.PathQuery + '; ' + $this.Body
  }
}

function Ensure-StartsWithSlash(
  [Parameter(Mandatory = $true, ValueFromPipeline = $true)][String]$InputValue
) {
  Begin {
    if ($InputValue.StartsWith("/")) {
      return $InputValue
    }
    else {
      return "/$InputValue"
    }
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
}

function Read-Requests(
  [Parameter(Position = 0, Mandatory = $true)][System.Object[]]$Lines
) {
  Process {
    $tmp = New-Object Collections.Generic.List[string];
    $result = @()
    foreach ($line in $Lines) {
      if ($line.Trim().StartsWith("#")) {
        #Ignore comment lines
      }
      elseif (-not [string]::IsNullOrWhiteSpace($line)) {
        $tmp.Add($line);
      }
      else {
        if ($tmp.Length -gt 0) {
          $a = Read-Request $tmp
          $result += $a
        }
        $tmp = New-Object Collections.Generic.List[string];
      }
    }
    if ($tmp.Length -gt 0) {
      $a = Read-Request $tmp
      $result += $a
    }
    $result
  }
}

function Read-Request(
  [Parameter(Mandatory = $true, ValueFromPipeline = $true)] [System.Object[]] $Lines
) {
  Process {
    #Write-Host "-> 1"
    $firstLine = $Lines[0]
    $method = Get-HttpMethod $firstLine
    $pathQuery = Ensure-StartsWithSlash (GET-PathQuery $firstLine)
    $json = $Lines[1..$Lines.Length]
    if ($json) {
      if (Test-Json "$json") {
        Write-Host "-> 2"
        [EsRequest]::new($method, $pathQuery, "$json")
      }
      else {
        Write-Host "-> 3"
        Write-Error "BAD json" #-ErrorAction Stop
        throw "BAD json"
      }
    }
  }
}

function Read-EsFile(
  [Parameter(Mandatory = $true, ValueFromPipeline = $true)] [String] $filename
) {
  Process {
    $file = Get-Content $filename
    Read-Requests $file
  }
}

function Get-Credential(
  [Parameter(Mandatory = $true)][string]$username,
  [Parameter(Mandatory = $true)][string]$password
) {
  $pwd = ConvertTo-SecureString $password -AsPlainText -Force
  New-Object System.Management.Automation.PSCredential ($username, $pwd)
}

function Invoke-EsRequest(
  [Parameter(Mandatory = $true, ValueFromPipeline = $true)] [EsRequest] $request,
  [Parameter(Mandatory = $true, HelpMessage = "ex: http://host.name:9200")] [string] $hostUrl,
  [Parameter(Mandatory = $false)][bool]$useSsl = $false,
  [Parameter(Mandatory = $false)][System.Management.Automation.PSCredential]$credential
) {
  Process {
    $uri = [System.Uri]::new($hostUrl + $request.PathQuery)
    $arguments = @{
      Uri         = $uri
      Method      = $request.Method
      ContentType = "application/json"
    }
    if ($request.Method -eq "POST" -or $request.Method -eq "PUT") {
      $arguments.Add("Body", $request.Body)
    }
    if ($useSsl) {
      #$arguments.Add("AllowUnencryptedAuthentication", $true)
      $arguments.Add("SkipCertificateCheck", $true)
      $arguments.Add("Credential", $credential)
    }
    Invoke-RestMethod @arguments
  }
}
