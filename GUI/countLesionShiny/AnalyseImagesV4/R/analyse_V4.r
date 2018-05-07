## d�tection de l�sions sur image couleur
## phase 2 : analyse d'image

source("fonctions_analyse_V4.r")

## -------------------- Param�tres de l'analyse -----------------------------------
surface.feuille.mini <- 1000 ## surface minimum d'une feuille
bordure.feuille <- 3 ## �paisseur de bordure de feuille � supprimer
bordure.lesion <- 3 ## �paisseur de bordure de l�sion � dilater / �roder
surface.lesion.mini <- 10 ## surface minimum d'une l�sion
couleur.lesion <-  0 ## couleur des l�sions dans l'image analys�e (0=noir, 1=blanc)

## -------------------- R�pertoires et fichiers Exemple1---------------------------
path.sample <- "../Exemple1/Samples" ## R�pertoire de stockage des fichiers �chantillons
path.result <- "../Exemple1/Result"  ## R�pertoire de stockage des r�sultats d'analyse, cr�� si inexistant (peut �tre le m�me que path.image)
path.image <- "../Exemple1/Images"   ## R�pertoire de stockage des fichiers images sources
file.image <- "IMG_5593_50.jpg"      ## Fichier image source

## -------------------- R�pertoires et fichiers Exemple2 --------------------------
path.sample <- "../Exemple2/Samples"   ## R�pertoire de stockage des fichiers �chantillons
path.result <- "../Exemple2/Result"    ## R�pertoire de stockage des r�sultats d'analyse, cr�� si inexistant (peut �tre le m�me que path.image)
path.image <- "../Exemple2/Images"     ## R�pertoire de stockage des fichiers images sources
file.image <- "pCR17-6-1_kitaake3.jpg" ## Fichier image source

## -------- Exemple analyse par passage des noms de fichier -----------------------
analyse.image(path.sample=path.sample,
              path.result=path.result,
              path.image=path.image,
              file.image=c(file.image), ## peut contenir plusieurs noms
              surface.feuille.mini=surface.feuille.mini,
              bordure.feuille=bordure.feuille,
              bordure.lesion=bordure.lesion,
              surface.lesion.mini=surface.lesion.mini,
              couleur.lesion=couleur.lesion)
## ------------- Fin d'analyse ----------------------------------------------------

## -------- Exemple analyse d'un r�pertoire complet -------------------------------
analyse.image(path.sample=path.sample,
              path.result=path.result,
              path.image=path.image,
              file.image=NA, ## analyse du r�pertoire complet
              surface.feuille.mini=surface.feuille.mini,
              bordure.feuille=bordure.feuille,
              bordure.lesion=bordure.lesion,
              surface.lesion.mini=surface.lesion.mini,
              couleur.lesion=couleur.lesion)
## ------------- Fin d'analyse ----------------------------------------------------

## ----------------- Fin de fichier -----------------------------------------------
