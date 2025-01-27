#(Get-NetIPAddress -AddressFamily IPv4 | Where-Object { $_.InterfaceAlias -ilike "Ethernet0" }).IPAddress
#(Get-NetIPAddress -AddressFamily IPv4 | Where-Object { $_.InterfaceAlias -ilike "Ethernet0" }).PrefixLength
#Get-WmiObject -list | Where-Object { $_.Name -ilike "Win32_Net*" } | Sort-Object
#Get-CimInstance Win32_NetworkAdapterConfiguration -Filter "DHCPEnabled=$true" | Select DHCPServer | Format-Table -HideTableHeaders
#(Get-DnsClientServerAddress -AddressFamily IPv4 | Where-Object { $_.InterfaceAlias -ilike "Ethernet0" }).ServerAddresses

#cd C:\Users\champuser\CSI-230-01\week1
#$files=(Get-ChildItem)
#for ($j=0; $j -le $files.Length; $j++){
#
 #   if($files[$j].name -ilike "*ps1"){
 #       Write-Host $files[$j].name
  #  }
#}
#$folderpath="PSScriptRoot\outfolder"
#if(Get-ChildItem $folderpath){
 #   Write-Host "Folder Already Exists"
#}
#else{
#   New-Item -Name "outfolder" -ItemType "directory" -Path $folderpath
#}

cd $PsscriptRoot
$files=***

$folderpath + "$PSScriptRoot/outfolder/"
$filePath = *** $folderPath "out.csv"

$files | *** *** -eq ".ps1" * | Export-Csv -Path $filePath