$LastLog = 'C:\\Program Files (x86)\\Cisco Systems\\Cisco PSA Service\\logs\\log.txt'
$ErrorString = 'ERROR processing URL Exception while executing script'
$EndLine = 'URL Processing completed'

try {
    $LogContent = Get-Content $LastLog
} catch {
    Write-Output "Couldn't retrieve content from $LastLog"
    Exit 1
}

$StartingLine = ($LogContent |
    Select-String $ErrorString |
    Select-Object -Last 1).LineNumber - 1

$ErrorLine = $StartingLine

do {
    Write-Output "$($LogContent[$ErrorLine])"
    $ErrorLine++
} until (
    $LogContent[$ErrorLine] -like "*$EndLine" -or
    ($ErrorLine - $StartingLine) -gt 100
)
