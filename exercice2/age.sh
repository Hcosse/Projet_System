#!/bin/bash

echo "TRIE PAR AGE"

select choix in croissant decroissant; do
    case $choix in
        croissant)
            awk -F ';' '{print $4, $0}' fake-users-base.csv | sort -k1,1n
            break
            ;;
        decroissant)
            awk -F ';' '{print $4, $0}' fake-users-base.csv | sort -k1,1nr 
            break
            ;;
        *)
            echo "Choix invalide."
            ;;
    esac
done

