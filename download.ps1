param(
    $county = "Galway",
    $year = 2010
)

# Invoke-WebRequest "https://www.propertypriceregister.ie/website/npsra/ppr/npsra-ppr.nsf/Downloads/PPR-2010-01-Galway.csv/`$FILE/PPR-2010-01-Galway.csv" -OutFile "PPR-2010-01-Galway.csv"

New-Item -ItemType Directory -Force -Path './data' | Out-Null

$failed = $false;

while ($failed -eq $false) {
    for ($i = 1; $i -lt 13; $i++) {
        $month = '{0:d2}' -f $i;
        $file = "$year-$month-$county";
        try {
            Invoke-WebRequest "https://www.propertypriceregister.ie/website/npsra/ppr/npsra-ppr.nsf/Downloads/PPR-$file.csv/`$FILE/PPR-$file.csv" -OutFile "./data/PPR-$file.csv";
            Write-Output "downloaded: PPR-$file.csv";
        }
        catch {
            $failed = $true;
            break;
        }
    }
    $year++;
}

Write-Output "downloads complete!"