$LastLog = 'C:\\Program Files (x86)\\Cisco Systems\\Cisco PSA Service\\logs\\log.txt'
$ErrorString = 'ERROR processing URL Exception while executing script'
$EndLine = 'URL Processing completed'
$LogContent = Get-Content $LastLog
$LastError = ($LogContent |
    Select-String $ErrorString |
    Select-Object -First 1).LineNumber - 1

do {
    Write-Output "$($LogContent[$LastError])"
    $LastError++
} until ($LogContent[$LastError] -like "*$EndLine")
