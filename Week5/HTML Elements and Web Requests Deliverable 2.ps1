$scraped_page = Invoke-WebRequest -Uri http://10.0.17.20/ToBeScraped.html

$scraped_page.AllElements