function Parse-WebServerLogs {
    param (
        [string]$LogFilePath
    )


    $logEntries = Get-Content $LogFilePath

    
    $logPattern = '^(?<IP>\S+) - - \[(?<Time>.+?) -\d+\] "(?<Method>\S+) (?<Page>\S+) (?<Protocol>\S+)" (?<Response>\d+) \d+ "(?<Referrer>[^"]+)"'

    $parsedLogs = @()

    foreach ($entry in $logEntries) {
        if ($entry -match $logPattern) {
            $parsedLogs += [PSCustomObject]@{
                IP        = $matches['IP']
                Time      = $matches['Time'] 
                Method    = $matches['Method']
                Page      = $matches['Page']
                Protocol  = $matches['Protocol']
                Response  = $matches['Response']
                Referrer  = $matches['Referrer']
            }
        }
    }

    # Output the custom object list
    return $parsedLogs
}

# Example usage:
$logData = Parse-WebServerLogs -LogFilePath "C:\Users\champuser\Downloads\access.log"
$logData | Format-Table -AutoSize
