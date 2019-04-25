pwsh -NoProfile -Command {
  Param([string]$SourceFolder, [string]$EsNodeUrl)
  
  Import-Module ./posh-elastic.psd1
  
  #$files = Get-ChildItem ./$sourceFolder
  Get-ChildItem ./$sourceFolder -Recurse -Filter *.es |
  Select-Object -ExpandProperty FullName | 
  Read-EsFile | 
  Invoke-EsRequest -hostUrl $EsNodeUrl
    
} -args "BaseObjects","http://localhost:9200"