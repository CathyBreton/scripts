## d�tection de l�sions sur image couleur
## phase 2 : analyse d'image

source("fonctions_analyse.r")

## -------------------- Param�tres de l'analyse -----------------------------------
surface.feuille.mini <- 1000 ## surface minimum d'une feuille
bordure.feuille <- 3 ## �paisseur de bordure de feuille � supprimer
bordure.lesion <- 3 ## �paisseur de bordure de l�sion � dilater / �roder
surface.lesion.mini <- 10 ## surface minimum d'une l�sion
couleur.lesion <-  0 ## couleur des l�sions dans l'image analys�e (0=noir, 1=blanc)

## -------------------- R�pertoires et fichiers -----------------------------------
path.image <- "../Images" ## R�pertoire de stockage des fichiers images sources
file.image <- "IMG_5589_50.JPG" ## Fichier image source

path.sample <- "../Samples/5589" ## R�pertoire de stockage des fichiers �chantillons
background <- "fond" ## sous-r�pertoire contenant les �chantillons de fond
limb <- "limbe" ## sous-r�pertoire contenant les �chantillons de limbe
lesion <- "lesion" ## sous-r�pertoire contenant les �chantillons de lesion

path.result <- "../Result" ## R�pertoire de stockage des r�sultats d'analyse, cr�� si inexistant (peut �tre le m�me que path.image)

## --------------------- Analyse --------------------------------------------------
source("analyse_image.r")

## ------------- Fin d'analyse ----------------------------------------------------

## ------------- Les lignes suivantes sont des exemples d'autres analyses ---------
path.sample <- "../Samples/5583" ## R�pertoire de stockage des fichiers �chantillons
file.image <- "IMG_5583_50.JPG" ## Fichier image source

path.sample <- "../Samples/5605" ## R�pertoire de stockage des fichiers �chantillons
file.image <- "IMG_5605_50.JPG" ## Fichier image source

path.sample <- "../Samples/5605" ## R�pertoire de stockage des fichiers �chantillons
file.image <- "IMG_5609_50.JPG" ## Fichier image source

path.sample <- "../Samples/5605" ## R�pertoire de stockage des fichiers �chantillons
file.image <- "IMG_5598_50.JPG" ## Fichier image source

path.sample <- "../Samples/5605" ## R�pertoire de stockage des fichiers �chantillons
file.image <- "IMG_5581_50.JPG" ## Fichier image source

path.sample <- "../Samples/5605" ## R�pertoire de stockage des fichiers �chantillons
file.image <- "IMG_5583_50.JPG" ## Fichier image source

path.sample <- "../Samples/5605" ## R�pertoire de stockage des fichiers �chantillons
file.image <- "IMG_5593_50.JPG" ## Fichier image source

path.sample <- "../Samples/5605" ## R�pertoire de stockage des fichiers �chantillons
file.image <- "IMG_5591_50.JPG" ## Fichier image source

path.sample <- "../Samples/5615" ## R�pertoire de stockage des fichiers �chantillons
file.image <- "IMG_5615_50.JPG" ## Fichier image source

## ----------------- Fin de fichier -----------------------------------------------
