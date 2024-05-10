#!/bin/bash 


awk -F ';' '{
    if ($5 == "Male"){
        $5 = "H";
    print $0;
    } else if ($5 == "Female"){
        $5 = "F";
    print $0;
    }
 
}' fake-users-base.csv

