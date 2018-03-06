## d�tection de l�sions sur image couleur
## phase 1 : apprentissage � partir d'images �chantillonn�es
## path.sample est le r�pertoire contenant les sous-r�pertoires contenant les fichiers d'�channtillons
## chaque sous-r�opertoire contient u nombre ind�termin� de fichiers d'une m�me cat�gorie (fond ou limbe ou l�sion)
## tous les sous-r�pertoires sont analys�s, seuls les sous-r�pertoires utiles doivent figurer dans path.sample
## les noms des sous-r�pertoires sont libres et doivent �tre sp�cifi�s lors de la phase 2 (analyse)

source("fonctions_apprentissage.r")

## R�pertoire des sous-r�pertoires d'�chantillons
path.sample <- "../Samples/5589"
apprentissage(path.sample)
## Fin d'apprentissage

## Autres exemples
path.sample <- "../Samples/5589"
path.sample <- "../Samples/5605"
path.sample <- "../Samples/5615"

## Fin de fichier
