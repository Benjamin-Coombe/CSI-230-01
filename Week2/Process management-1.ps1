$website = "https://www.champlain.edu/current-student-hub/"

$chromeProcesses = Get-Process -Name "chrome" -ErrorAction SilentlyContinue

if ($chromeProcesses) {
    Write-Output "Chrome is running. Closing all instances."
    Stop-Process -Name "chrome" -Force
} else {
    Write-Output "Chrome is not running. Opening Chrome with $website."
    Start-Process -FilePath "chrome.exe" -ArgumentList $website
}