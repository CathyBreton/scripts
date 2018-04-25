## d�tection de l�sions sur image couleur
## phase 1 : apprentissage � partir d'images �chantillonn�es
## path.sample est le r�pertoire contenant les sous-r�pertoires contenant les fichiers d'�channtillons
## les trois derniers arguments de la fonction apprentissage sont (dans cer ordre)
## chaque sous-r�opertoire contient un nombre ind�termin� de fichiers d'une m�me cat�gorie (fond ou limbe ou l�sion)
## trois sous-r�pertoires contenant trois cat�gories de pixels (fond, limbe, l�sion) sont requis,
## r�pertoire path.sample peut contenir d'autres sous-r�pertoires inutilis�s

source("fonctions_apprentissage_V4.r")

## Choisir Exemple1 ou Exemple2
path.sample <- "../Exemple1/Samples"
path.sample <- "../Exemple2/Samples"

apprentissage(path.sample,"fond","limbe","lesion")

## Fin de fichier
