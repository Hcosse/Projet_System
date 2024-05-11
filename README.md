*# Projet 

## Exercice 1

### Question 1
Creation d'un repertoire mail dans mon repertoire personnel : 

```console
$ mkdir -p mail #Crée un répertoire

### Question 2


```console
$ chmod 700 mail # Donne les permissions
```

### Question 3

``` console 
$ sudo chgrp eleves envoi_message_hugoc # Définit le groupe
$ verification_identite 710 
$ envoyer_mail_hugoc chmod 4710 

```

### Question 4 

Avant de lancer l'exécutable il faut procéder à la vérification de l'identité de l'expéditeur ainsi dans un fichier contact.txt les noms de tous les expéditeurs autorisés à envoyer un mail sont stockés la commande grep -iq permet de rechercher si l'$USER est dans la liste ainsi deux choix possibles retour 0 REUSSI & REFUS avec return 1.


```bash
#!/bin/bash

message=$1

if grep -iq "$USER" /home/hugoc/contact.txt; then    #Verification de l'USER 

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

auth=$? # Prend directement la sortie du script

echo "$auth"

if [ "$auth" -eq 0 ]; then #Check verification si 0 accepte si 1 refus

    ./envoi_message_hugoc "$message"

elif [ "$auth" -eq 1 ]; then

    echo "Accès refusée"
else

    echo "ERREUR"

fi

```
Par la suite on retrouve l'authentification dans un autre script qui va permettre d'autoriser le lancement de l'executable en fonction du retour du script verification_identité

### Question 5 

On peut se servir de ce script en utilisant la commande grep -i qui va vérifier si l'utilisateur est bien dans la liste contact.txt et ainsi grâce au if deux choix sont possibles si le $USER est dans la liste on peut lancer l'executable à l'inverse REFUS.

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

La tête du fichier regroupe ID;prenom;nom;age;sexe;email;Téléphone de chaque user.

### Question 3

On utilise awk pour trier des informations dans un fichier : 
```bash
#!/bin/bash

echo "Saisir l'ID recherché : "
read index #Stoque l'entrée de l utilisateur dans index

# Trouver la ligne avec l'Index spécifié et imprimer ID et le nom
awk -F ';' -v idx="$index" '$1 == idx {print "ID: " $1 ", Nom: " $3}' fake-users-base.csv #-F permet de désigner le serparteur ; -v permet de rattacher la variable à awk.
```

### Question 4

On trie l'age grâce au langage AWK :
#!/bin/bash

```bash
echo "TRIE PAR AGE"

select choix in croissant decroissant; do # Select permet de créer un menu 
    case $choix in # En fonction du choix on éxécute ce que contient le choix croissant ou décroissant
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

Grâce à la condition IF, on peut remplacer les chaînes de caractères ; le print $0 permet d'afficher la ligne avec la modification effectuée.

```bash

#!/bin/bash

awk -F ';' '{
    if ($5 == "Male"){  # Si la rangée 5 est Male alors on remplace par H pareil pour  Female
        $5 = "H"; 
    print $0;##Permet d'afficher la ligne entière
    } else if ($5 == "Female"){
        $5 = "F";
    print $0;
    }

}' fake-users-base.csv

```
## Question 6

On remarque que certains numéros commençant par +33 et on veut donc les mettre sous le même format , on utilise toujours AWK.

```bash

#!/bin/bash

awk -F ';' '{gsub(/\+33/, "0", $7)} 1' fake-users-base.csv ##Pour que les numéros soientt uniformisés on implante du regex ici le regex vérifie le début si +33 alors il le switche par un 0 

```
## Question 7

J'ai effectuée des statistiques assez simples sur le nombre en  pourcentage d'hommes et de femmes ainsi que les tranches d'âges en pourcentage.

```bash
#!/bin/bash
echo " "
echo "========= STATISTIQUE fake-users-base.csv ========= "
echo " "
awk -F ';' '{if ($5 == "Male") counter_male++; if ($5 == "Female") counter_female++} END {print "Male :" counter_male "  Female :"counter_female }' fake-users-base.csv ##Stat basique si la rangée 5 est male incrémentation d'un compteur et pareil pour les femmes 
echo " "
echo "========= REPARTITION EN POURCENTAGE DES AGES ========="
echo " "
awk -F ';' '{
    if ($4 > 10 && $4 < 20) dix++; ## Si la rangée 4 est entre 10 et 20 alors on incrémente le compteur pareil pour tous 
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
    total = dix + vingt + trentaine + quarantaine + cinquantaine + soixantaine + soixantedizaine + quatrevingtaine + vieux; ## Determine la totalité des personnes dans le fichier
    printf "Entre 10-20 ans  : %.1f %\n", (dix / total) * 100; ## Crée le pourcentyage en fonction des compteurs
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
```
## Question 8

J'ai simplement listé grâce les peronnes de 20 à 30 et grâce à AWK je récupère l'adresse mail si les conditions sont réunies j'envoie le mail prédéfinis 
```bash
#!/bin/bash

awk -F ';' '{
    if ($4 > 20 && $4 < 30) { ## On vérifie la rangée 4 toutes les personnes entre 20 et 30 recevront un mail de promotion  
        printf("===========================\n");
        printf("Mail envoyé à %s :\n", $6);
        printf("Promotion exceptionnelle pour les 20/30 ans ! \n");
        printf("\n");
    }
}' fake-users-base.csv

```
## Question 9
Je crée un UID supérieur à 10000 comme demandé par la suite je vérifie la colonne mail si le mail est fini par :  /protonmail\.com/ alors je crée un nouvel UID et l'incrémente de 1 pour le prochain utilisateur 
```bash
#!/bin/bash

UID=10001

awk -F ';' '{
if ($6 ~ /protonmail\.com/) # La fonction regex vérifie si la fin du mail correspond 

uid=$UID

system("useradd -u $uid $3") # Appel systeme qui permet d'executer useradd dans un script AWK 

system("usermod -aG proton $3")

$uid ++

}'fake-users-base.csv

```

##Exercice 3

L'obfuscation consiste à dissimuler des éléments sensibles ainsi que le fonctionnement d'un script je me suis donc appuyé sur un challenge root-me ue j'ai réalisé ! 


```bash

#!/bin/bash

##  Affiche une demande de saisie du mot de passe à l'utilisateur.
demander="echo Saisir mot de passe :"
eval $demander
read entree

## Définit les commandes pour hasher le mot de passe en SHA-256.
commande_echo="echo -n"
commande_sha="sha256sum"
commande_awk="awk '{print \$1}'"
commande_hash="$commande_echo \"$entree\" | $commande_sha | $commande_awk"
mot_de_passe_hashe=$(eval $commande_hash)

## Convertit le hash en une série de valeurs ASCII.
commande_od="od -An -t u1"
commande_format="tr -s ' ' | tr ' ' ','"
commande_encodage="$commande_od | $commande_format"
ascii_encode=$(echo "$mot_de_passe_hashe" | eval $commande_encodage)

##  Affiche le mot de passe hashé et encodé en ASCII.
resultat="echo Mot de passe hashé en SHA-256 et encodé en ASCII :"
final="$resultat \$ascii_encode"
eval $final

```







