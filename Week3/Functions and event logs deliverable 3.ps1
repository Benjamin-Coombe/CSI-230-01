$loginouts = Get-EventLog -LogName System -source Microsoft-Windows-winlogon -After (Get-Date).AddDays(-100)
$loginoutsTable = @()
for ($i=0; $i -lt $loginouts.Count; $i++){

$event = ""
if($loginouts[$i].InstanceId -eq 7001) {$event="Logon"}
if($loginouts[$i].InstanceId -eq 7002) {$event="Logoff"}
try {
        $user = ([System.Security.Principal.SecurityIdentifier]($userSid)).Translate([System.Security.Principal.NTAccount]).Value
    } catch {
        $user = $userSid  # If translation fails, keep the SID
    }

$loginoutsTable += [pscustomobject]@{"Time" = $loginouts[$i].TimeGenerated;
                                        "Id" = $loginouts[$i].InstanceId;
                                         "Event" = $event;
                                         "User" = $user;
                                         }
}
$loginoutsTable