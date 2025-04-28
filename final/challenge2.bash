#! /bin/bash

logFile="access.log"
IOCFile="IOC.txt"
result=$(cat "$logFile" | egrep -i -f "$IOCFile" | cut -d ' ' -f 4,1,7 | tr -d '[')
echo "$result" >> report.txt
cat "report.txt" | sort -n | uniq
