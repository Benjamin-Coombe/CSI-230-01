#. "c:\user\champuser\CSI-230-1\Week7\configuration.txt"
$pathToFile = Join-Path $PSScriptRoot configuration.txt
$Prompt = "`n"
$Prompt += "1 - Show Configuration`n"
$Prompt += "2 - Change Configuraton`n"
$Prompt += "3 - Exit`n"
$operation = $true
while($operation){

    
    Write-Host $Prompt | Out-String
    $choice = Read-Host 


    if($choice -eq 3){
        Write-Host "Goodbye" | Out-String
        exit
        $operation = $false 
    }
    elseif($choice -eq 1){
    #Show Configuration
        $config = Get-Content -Path ".\CSI-230-01\Week7\configuration.txt"
        $myobject = [PSCustomObject]@{
        Day = $config[0]
        Time = $config[1]
        }
        $myobject | out-string
    }

    elseif($choice -eq 2){
    #Change Configuration
       $day = Read-Host "Enter the number of days for which the logs will be obtained"
       if ($day -notmatch "^\d+$"){
       Write-Host "Invalid Input please enter a number"
       }
       $time = Read-Host "Enter the daily execution time of the script"
       if($time -notmatch "^\d{1,2}:\d{2} (AM|PM)$"){
       Write-Host "Invalid input. Please enter a valid time in H:MM AM/PM format"
       }
       Set-Content -Path $pathToFile -Value $day,$time
    }
     elseif($choice -notmatch 1,2,3){
    Write-Host "Sorry thats not an option try again"
    }
 }
   