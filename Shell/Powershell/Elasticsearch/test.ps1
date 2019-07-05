pwsh -NonInteractive -NoProfile -Command {
  Param([string]$SourceFolder, [string]$EsNodeUrl, [Boolean]$UseSSL, [string]$Username, [string]$Password)
  
  Import-Module ./posh-elastic.psd1
  
  $args = @{
    hostUrl = $EsNodeUrl
  }
  if($UseSSL -eq $true) { 
    $pwd = ConvertTo-SecureString $Password -AsPlainText -Force
    $cred = New-Object System.Management.Automation.PSCredential ($Username, $pwd)
     
    $args.Add("useSsl", $true);
    $args.Add("credential", $cred);
  }
  
  Get-ChildItem ./$SourceFolder -Recurse -Filter *.es | 
  Select-Object -ExpandProperty FullName | 
  Read-EsFile | 
  Invoke-EsRequest @args
      
} -args "Objects","http://localhost:9200",$true,"test","test" #$SourceFolder,$EsNodeUrl,$UseSSL,$Username,$Password