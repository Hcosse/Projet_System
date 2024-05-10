#!/bin/bash

UID=10001

awk -F ';' '{
if ($6 ~ /protonmail\.com/)

uid=$UID

system("useradd -u $uid $3")

system("usermod -aG proton $3")

$uid ++

}'fake-users-base.csv
 

 
