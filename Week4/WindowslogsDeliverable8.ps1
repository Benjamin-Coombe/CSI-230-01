# Get only logs that contain 404, save into $notfounds
$notfounds = Get-Content -Path "C:\xampp\apache\logs\access.log" | Select-String -Pattern " 404 "

# Define a regex for IP addresses
$regex = [regex] "\b\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\b"

# Get $notfounds records that match to the regex
$ipsunorganized = $regex.Matches($notfounds)

# Get ips as pscustomobject
$ips = @()
for($i=0; $i -lt $ipsunorganized.Count; $i++){
    $ips += [pscustomobject] @{ "IP" = $ipsunorganized[$i].Value }
}

# Filter and display IPs that start with "10."
$ips | Where-Object { $_.IP -like "10.*" } | Select-Object -ExpandProperty IP

# Count ips from number 8
$ipsoftens = $ips | Where-Object { $_.IP -like "10.*" }

# Group IPs and count occurrences
$counts = $ipsoftens | Group-Object -Property IP | Select-Object Count, Name

# Display the counts
$counts | Format-Table -AutoSize