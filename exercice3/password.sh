#!/bin/bash 


echo "Saisir mot de passe :"

read password

obfusquation=$(echo "$password" | base64)

echo " "
echo "$obfusquation"


