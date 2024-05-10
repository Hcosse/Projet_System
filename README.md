# Projet 

## Exercice 1

### Question 1
Creation d'un repertoire mail dans mon repertoire personnel : 

```console
$ mkdir -p mail
```

### Question 2


```console
$ chmod 700 mail
```

### Question 3

``` console 
$ sudo chgrp eleves envoi_message_hugoc
$ verification_identite 710
$ envoyer_mail_hugoc chmod 4710 

```

### Question 4 

Avant de lancer l'exécutable il faut procéder à la vérification de l'identité de l'expéditeur ainsi dans un fichier contact.txt les noms de tous les expéditeurs autorisé à envoyer un mail sont stockés la commande grep -iq permet de rechercher si l'$USER est dans la liste ainsi deux choix possible retour 0 REUSSI & REFUS avec return 1.

Verification_de_l'identifiant :

```bash
#!/bin/bash

message=$1

if grep -iq "$USER" /home/hugoc/contact.txt; then

    exit 0

else

    echo "Permission refusée vous n'êtes pas dans la liste !"
    exit 1

fi

```
envoi_mail.sh

```bash

#!/bin/bash

message=$1

./verification_identite

auth=$?

echo "$auth"

if [ "$auth" -eq 0 ]; then

    ./envoi_message_hugoc "$message"

elif [ "$auth" -eq 1 ]; then

    echo "Accès refusée"
else

    echo "ERREUR"

fi

```
Par la suite on retrouve l'authentification dans un autre script qui va permettre d'autoriser le lancement de l'executable en fonction du retour du script verification_identité

### Question 5 

On peut se servir de ce script en utilisant la commande grep -i qui va vérifier si l'utilisateur est bien dans la liste contact.txt et ainsi grâce au if deux choix sont possible si le $USER est dans la liste on peut lancer l'executable à l'inverse REFUS.

```bash
if grep -iq "$USER" /home/hugoc/contact.txt; then
```




## Exercice 2

### Question 1
Je me déplace jusqu'au répertoire usr/local/share/file je copie le fichier .csv avec la commande cp vers ce chemin /home/hugoc/travail/projet/exercice2.
```bash
cp fake-users.csv /home/hugoc/travail/projet/exercice2
```

### Question 2 

La tête du fichier regroupe ID;prenom;nom;age;sexe;email;Téléphone de chaque users.

### Question 3

On utilise awk pour trier des informations dans un fichier : 
```bash
#!/bin/bash

echo "Saisir l'ID recherché : "
read index #Stocke l'entrée de l utilisateur dans index

# Trouver la ligne avec l'Index spécifié et imprimer ID et le nom
awk -F ';' -v idx="$index" '$1 == idx {print "ID: " $1 ", Nom: " $3}' fake-users-base.csv #-F permet de désigner le serparteur ; -v permet de rattacher la variable à awk.
```

### Question 4

On trie l'age grâce au langage AWK :
#!/bin/bash

```bash
echo "TRIE PAR AGE"

select choix in croissant decroissant; do ##Select permet de créer un menu 
    case $choix in ## En fonction du choix on éxécute ce que contient le choix croissant ou décroissant
        croissant)
            awk -F ';' '{print $4, $0}' fake-users-base.csv | sort -k1,1n ## AWK -F permet de désignerun séparateur ';' par la suite print permet d'afficher la 4ème ligne et avec awk $0 représente la ligne entière  et la sortie est s'effectue par sort qui trie la première colonne avec -k1 et numériquement avec 1n
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
```
## Question 5





