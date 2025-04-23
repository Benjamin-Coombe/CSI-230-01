#!/bin/bash

# Full URL
link="http://10.0.17.10/Courses.html"

# Get the page
fullPage=$(curl -sL "$link")

# Extract table rows using xmlstarlet
toolOutput=$(echo "$fullPage" | \
xmlstarlet fo --html --recover 2>/dev/null | \
xmlstarlet sel -t -m "//table//tr" -c . -n)

# Clean and format with sed
echo "$toolOutput" | \
  sed 's/<\/tr>/\n/g' | \
  sed -e 's/&amp;/&/g' \
      -e 's/<tr>//g' \
      -e 's/<td[^>]*>//g' \
      -e 's/<\/td>/;/g' \
      -e 's/<a[^>]*>//g' -e 's/<\/a>//g' \
      -e 's/<nobr>//g' -e 's/<\/nobr>//g' \
  > courses.txt

