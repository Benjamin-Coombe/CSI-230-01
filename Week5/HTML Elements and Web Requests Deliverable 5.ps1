$scraped_page = Invoke-WebRequest -Uri http://10.0.17.20/ToBeScraped.html
$divs1=$scraped_page.ParsedHtml.body.getElementsByTagName("div") | where { `
$_.getAttributeNode("class").value -ilike "div-1"} | select innerText

$divs1