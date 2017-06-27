Param(
    [Parameter(Mandatory=$true)]
    [string]$ProcessName
)

[System.Diagnostics.Process[]]$processes = @(Get-Process $ProcessName -ErrorAction Ignore) # @(...) force result to an array

if($processes)
{
    Foreach($process in $processes) 
    {
        $process.CloseMainWindow() | Out-Null;
        Stop-Process $process.Id -Force;
    } 
}