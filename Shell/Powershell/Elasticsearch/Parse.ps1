function Ensure-StartsWithSlash(
  [Parameter(Mandatory=$true)][String]$InputValue
)
{
  if($InputValue.StartsWith("/"))
  {
    return $InputValue
  } else {
    return "/$InputValue"
  }
}

function Get-HttpMethod(
  [Parameter(Mandatory=$true)][String]$InputString
)
{
  $ValidHttpMethods = @('GET', 'POST', 'PUT', 'DELETE')

  $tokens = $InputString.Trim().ToUpper().Split(" ");
  $firstToken = $tokens[0];
  $success = $ValidHttpMethods -contains $firstToken;
  if($success) {
    return $firstToken
  } else {
    throw [System.ArgumentException]::new("'$InputString' does not start with a HTTP method.")
  }
}

function GET-PathQuery(
  [Parameter(Mandatory=$true)] [String] $InputString
)
{
  $tokens = $InputString.Trim().Split(" ");
  $secondToken = $tokens[1];
  return $secondToken;
}

function Read-Requests(
  [Parameter(
    Position=0,
    Mandatory=$true,
    ValueFromPipeline=$true
  )] 
  [System.Object[]] 
  $Lines
)
{
  Process {
    $tmp = @();
    $result = @();
    foreach($line in $Lines)
    {
      if(-not [string]::IsNullOrWhiteSpace($line))
      {
        $tmp += $line;
      } else {
        if($tmp.Length -gt 0) {
          $result += $tmp;
        }
        $tmp = @()
      }
    }
    Write-Host $result.GetType()
  }
}

function Read-Request(
  [Parameter(Mandatory=$true)]
  [System.Object[]]
  $Lines
)
{
  $firstLine = $Lines[0]
  $method = Get-HttpMethod $firstLine
  $pathQuery = GET-PathQuery $firstLine
  $json = $Lines[1..$Lines.Length]

}