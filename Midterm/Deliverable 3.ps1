function Parse-WebServerLogs {
    param (
        [string]$LogFilePath
    )

  
    $logEntries = Get-Content $LogFilePath

    # Define a regex pattern to extract the required fields
    $logPattern = '^(?<IP>\S+) - - \[(?<Time>.+?) -\d+\] "(?<Method>\S+) (?<Page>\S+) (?<Protocol>\S+)" (?<Response>\d+) \d+ "(?<Referrer>[^"]+)"'

    # Define an array of indicators to filter for the Page field
    $indicators = @("etc/passwd", "cmd=", "/bin/bash", "/bin/sh", "1=1#", "1=1--")

    $parsedLogs = @()

    foreach ($entry in $logEntries) {
        if ($entry -match $logPattern) {
            $page = $matches['Page']
            
           
            if ($indicators | Where-Object { $page -match [regex]::Escape($_) }) {
                $parsedLogs += [PSCustomObject]@{
                    IP        = $matches['IP']
                    Time      = $matches['Time']
                    Method    = $matches['Method']
                    Page      = $page  
                    Protocol  = $matches['Protocol']
                    Response  = $matches['Response']
                    Referrer  = $matches['Referrer']
                }
            }
        }
    }


    return $parsedLogs
}

$logData = Parse-WebServerLogs -LogFilePath "C:\Users\champuser\Downloads\access.log"
$logData | Format-Table -AutoSize