# Dot source the script to import the function
. "C:\Users\champuser\CSI-230-01\Week4\WindowslogsDeliverablefunction.ps1"

# Define the inputs
$pageVisited = "index.html"
$httpCode = "404"
$webBrowser = "Chrome"

# Call the function and store the result
$result = Get-ApacheLogs -PageVisited $pageVisited -HttpCode $httpCode -WebBrowser $webBrowser

# Display the result
$result | Format-Table -AutoSize