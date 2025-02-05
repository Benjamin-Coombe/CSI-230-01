# MainScript.ps1

# Dot source the script containing the function
. '.\Week3\Functions and event logs deliverable 4.ps1'

# Now you can call the function
$loginevents = Get-LoginLogoutEvents

# Display the results
$loginevents | Format-Table -AutoSize