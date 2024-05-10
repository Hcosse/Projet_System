#!/bin/bash 

message="$1"

./verification_identite.sh

auth=$?

if [ "$auth" -eq 0 ]; then 

    ./envoi_message_hugoc $message

elif [ "$auth" -eq 1 ]; then 

    echo "Accès refusée"
else 

    echo "ERREUR"

fi 
