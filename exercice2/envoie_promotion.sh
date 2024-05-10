#!/bin/bash

awk -F ';' '{
    if ($4 > 20 && $4 < 30) {
        printf("===========================\n");
        printf("Mail envoyé à %s :\n", $6);
        printf("Promotion exceptionnelle pour les 20/30 ans ! \n");
        printf("\n");
    }
}' fake-users-base.csv

