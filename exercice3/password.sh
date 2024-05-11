#!/bin/bash

demander="echo Saisir mot de passe :"
eval $demander
read entree

commande_echo="echo -n"
commande_sha="sha256sum"
commande_awk="awk '{print \$1}'"
commande_hash="$commande_echo \"$entree\" | $commande_sha | $commande_awk"
mot_de_passe_hashe=$(eval $commande_hash)

commande_od="od -An -t u1"
commande_format="tr -s ' ' | tr ' ' ','"
commande_encodage="$commande_od | $commande_format"
ascii_encode=$(echo "$mot_de_passe_hashe" | eval $commande_encodage)

resultat="echo Mot de passe hashé en SHA-256 et encodé en ASCII :"
final="$resultat \$ascii_encode"
eval $final

