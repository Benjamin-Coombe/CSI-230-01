function Get-LoginLogoutEvents {
    param (
        [int]$DaysBack  # Number of days back to search (mandatory input)
    )

    # Define log name and event source
    $LogName = "System"
    $EventSource = "Microsoft-Windows-winlogon"

    # Get event logs based on the input parameter
    $loginouts = Get-EventLog -LogName $LogName -Source $EventSource -After (Get-Date).AddDays(-$DaysBack)

    # Initialize an array to store the results
    $loginoutsTable = @()

    # Process each event log entry
    for ($i = 0; $i -lt $loginouts.Count; $i++) {
        $event = ""
        if ($loginouts[$i].InstanceId -eq 7001) { $event = "Logon" }
        if ($loginouts[$i].InstanceId -eq 7002) { $event = "Logoff" }

        $userSid = $loginouts[$i].ReplacementStrings[1]

        # Convert SID to username
        try {
            $user = ([System.Security.Principal.SecurityIdentifier]($userSid)).Translate([System.Security.Principal.NTAccount]).Value
        } catch {
            $user = $userSid 
        }

       
        $outputObject = [pscustomobject]@{
            "Time"  = $loginouts[$i].TimeGenerated;
            "Id"    = $loginouts[$i].InstanceId;
            "Event" = $event;
            "User"  = $user;
        }

       
        $loginoutsTable += $outputObject
    }

   
    return $loginoutsTable
}

$days = Read-Host "Enter the number of days to retrieve logs for"
$results = Get-LoginLogoutEvents -DaysBack $days


$results | Format-Table -AutoSize