#!/bin/bash
echo " "
echo "========= STATISTIQUE fake-users-base.csv ========= "
echo " " 
awk -F ';' '{if ($5 == "Male") counter_male++; if ($5 == "Female") counter_female++} END {print "Male :" counter_male "  Female :"counter_female }' fake-users-base.csv
echo " "
echo "========= REPARTITION EN POURCENTAGE DES AGES ========="
echo " "
awk -F ';' '{
    if ($4 > 10 && $4 < 20) dix++;
    if ($4 > 20 && $4 < 30) vingt++;
    if ($4 > 30 && $4 < 40) trentaine++;
    if ($4 > 40 && $4 < 50) quarantaine++;
    if ($4 > 50 && $4 < 60) cinquantaine++;
    if ($4 > 60 && $4 < 70) soixantaine++;
    if ($4 > 70 && $4 < 80) soixantedizaine++;
    if ($4 > 80 && $4 < 90) quatrevingtaine++;
    if ($4 > 90 && $4 < 100) vieux++;
}
END {
    total = dix + vingt + trentaine + quarantaine + cinquantaine + soixantaine + soixantedizaine + quatrevingtaine + vieux;
    printf "Entre 10-20 ans  : %.1f %\n", (dix / total) * 100;
    printf "Entre 20-30 ans  : %.1f %\n", (vingt / total) * 100;
    printf "Entre 30-40 ans  : %.1f %\n", (trentaine / total) * 100;
    printf "Entre 40-50 ans  : %.1f %\n", (quarantaine / total) * 100;
    printf "ENtre 50-60 ans  : %.1f %\n", (cinquantaine / total) * 100;
    printf "Entre 60-70 ans  : %.1f %\n", (soixantaine / total) * 100;
    printf "Entre 70-80 ans  : %.1f %\n", (soixantedizaine / total) * 100;
    printf "Entre 80-90 ans  : %.1f %\n", (quatrevingtaine / total) * 100;
    printf "Entre 90-100 ans : %.1f %\n", (vieux/ total) * 100;
}' fake-users-base.csv
echo " "
