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

function Get-HttpMethod(# Gets the http method
[Parameter(Mandatory=$true)]
[String]
$InputString)
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
[Parameter(Mandatory=$true)]
[String]
$InputString)
{
  $tokens = $InputString.Trim().Split(" ");
  $secondToken = $tokens[1];
  return $secondToken;
}