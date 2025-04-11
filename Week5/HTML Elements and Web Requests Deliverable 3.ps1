$scraped_page = Invoke-WebRequest -Uri http://10.0.17.20/ToBeScraped.html

# Display only URL and its text
$scraped_page.Links | Select-Object outerText, href