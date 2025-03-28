﻿Function gatherClasses(){
    $page = Invoke-WebRequest -TimeoutSec 2 http://10.0.17.20/courses.html;

    # Get all the tr elements of HTML document
    $trs = $page.ParsedHtml.getElementsByTagName("tr");
    
    # Empty array to hold results
    $FullTable = @();
    for ($i = 1; $i -lt $trs.length; $i++) { # Going over every tr element

        # Get every td element of current tr element
        $tds = $trs[$i].getElementsByTagName("td");
        
        # Want to separate start time and end time from one time field
        $Times = $tds[5].innerText -split " ";
        
        $FullTable += [PSCustomObject]@{
            "Class Code" = $tds[0].innerText;
            "Title"     = $tds[1].innerText;
            "Days"      = $tds[2].innerText;
            "Time Start" = $Times[0];
            "Time End"   = $Times[1];
            "Instructor" = $tds[6].innerText;
            "Location"  = $tds[7].innerText;
        }
    }
    return $FullTable;
    }