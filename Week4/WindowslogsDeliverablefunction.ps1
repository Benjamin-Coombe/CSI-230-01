function Get-ApacheLogs {
    # Prompt the user for input
    param (
        [string]$PageVisited,
        [string]$HttpCode,
        [string]$WebBrowser
    )

    # Define the path to the Apache access log file
    $logPath = "C:\xampp\apache\logs\access.log"
    
    # Check if the log file exists
    if (-Not (Test-Path $logPath)) {
        Write-Host "Log file not found at $logPath"
        return
    }
    
    # Prompt user for input if parameters are not provided
    if (-Not $PageVisited) {
        $PageVisited = Read-Host "Enter the page visited (e.g., /index.html)"
    }
    
    if (-Not $HttpCode) {
        $HttpCode = Read-Host "Enter the HTTP status code (e.g., 200)"
    }
    
    if (-Not $WebBrowser) {
        $WebBrowser = Read-Host "Enter the web browser name (e.g., Chrome)"
    }
    
    # Read the log file and filter based on the inputs
    $filteredLogs = Get-Content -Path $logPath | Select-String -Pattern "`$PageVisited.*`$HttpCode.*`$WebBrowser"
    
    # Define a regex for IP addresses
    $regex = [regex] "\b\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\b"
    
    # Extract IP addresses from the filtered logs
    $ips = @()
    foreach ($log in $filteredLogs) {
        if ($log -match $regex) {
            $ips += $matches[0]
        }
    }
    
    # Group IPs and count occurrences
    $counts = $ips | Group-Object | Select-Object Count, Name
    
    # Display the results
    if ($counts) {
        return $counts
    } else {
        Write-Host "No matching log entries found."
    }
}
