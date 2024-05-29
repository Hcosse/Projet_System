#!/bin/bash

message_prom="Promotion pour les 20/30 ans !"
sujet="Promotion"

awk -F ';' '{
 if ($4 > 20 && $4 < 30) {
   print $6 >> "mail_prom.txt";
    }
}' fake-users-base.csv

while IFS= read -r email
do
    echo "$message_prom" | mail -s "$sujet" "$email"
done < mail_prom.txt

rm mail_prom.txt

