$Header = 'Date,Address,Postcode,County,Price,Not Full Market Price,VAT Exclusive,Description,Size'

Get-ChildItem -Path './data' -Filter PPR*.csv | Select-Object -ExpandProperty FullName | Import-Csv -Encoding 1250 | Export-Csv './data/merged.csv' -NoTypeInformation -Append

$x = Get-Content './data/merged.csv'
$x[0] = $Header
$y = $x -replace '€', ''
$y | Out-File './data/merged.csv'