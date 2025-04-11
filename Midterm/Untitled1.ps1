#$IOC = Get-Content -Path 
$path = "C:\Users\champuser\Downloads\IOC.html"
#Write-Host $IOC

# Read the HTML file
$html = Get-Content $path -Raw

# Use regex to extract table rows
$matches = [regex]::Matches($html, "<tr>\s*<td>(.*?)</td>\s*<td>(.*?)</td>\s*</tr>")

# Initialize an array for custom objects
$iocList = @()

# Loop through matches and create custom objects
foreach ($match in $matches) {
    $iocList += [PSCustomObject]@{
        Pattern     = $match.Groups[1].Value
        Explaination = $match.Groups[2].Value
    }
}

# Output the custom object list
$iocList
