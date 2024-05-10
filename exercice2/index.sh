#!/bin/bash

echo "Saisir l'ID recherché : "
read index #Stocke l'entrée de l utilisateur dans index

# Trouver la ligne avec l'Index spécifié et imprimer ID et le nom
awk -F ';' -v idx="$index" '$1 == idx {print "ID: " $1 ", Nom: " $3}' fake-users-base.csv #-F permet de désigner le serparateur qui est ; ensuite on stocke la sortie de l utilisaeur dans idx via l'option -v qui permet de rattacher une viariable à awk .

