#! /bin/bash

site="10.0.17.6/IOC.html"

IOCFile="IOC.txt"

fullPage=$(curl -sL "$site")

output=$(echo "$fullPage" | \
xmlstarlet format --html --recover 2>/dev/null | \
xmlstarlet select --template --value-of \
"//table//tr//td" | awk 'NR % 2 == 1' > IOC.txt)
