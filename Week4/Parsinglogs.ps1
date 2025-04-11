Function Apachelogs1 {
    
    $logsNotformatted = Get-Content "C:\xampp\apache\logs\access.log"
    $stableRecords = @()
    $logPath = "C:\xampp\apache\logs\access.log"
    $logEntries = Get-Content -Path $logPath

    # Loop through each log entry
    for ($i = 0; $i -lt $logEntries.Count; $i++) {
        # Split the log entry into words
        $words = $logEntries[$i] -split " "

        # Create a custom object for each log entry
        $record = [pscustomobject]@{
            "IP"        = $words[0]
            "Time"      = $words[3].Trim('[')
            "Method"    = $words[5].Trim('"')
            "Page"      = $words[6]
            "Protocol"  = $words[7]
            "Response"  = $words[8]
            "Referrer"  = $words[10]
            "Client"   = $words[11..($words.Count - 1)] -join " "
        }

        # Add the record to the array
        $stableRecords += $record
    }

    # Return records where IP starts with "10.*"
    return $stableRecords | Where-Object { $_.IP -like "10.*" }
}

# Call the function and store the results
$stableRecords = Apachelogs1

# Display the results in a table format
$stableRecords | Format-Table -AutoSize -Wrap