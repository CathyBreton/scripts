#####################################################################################################
#
# Copyright 2018 CIRAD-INRA
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, see <http://www.gnu.org/licenses/> or
# write to the Free Software Foundation, Inc.,
# 51 Franklin Street, Fifth Floor, Boston,
# MA 02110-1301, USA.
#
# You should have received a copy of the CeCILL-C license with this program.
#If not see <http://www.cecill.info/licences/Licence_CeCILL-C_V1-en.txt>
#
# Intellectual property belongs to CIRAD and South Green developpement plateform
# Version 0.1.0 written by Sebastien RAVEL, François BONNOT, Sajid ALI, FOURNIER Elisabeth
#####################################################################################################

# Add specific option for run shiny
# options(shiny.port = 3838)
# options(shiny.host = "194.254.138.139")

############################################
## Global functions
############################################

rv <<- reactiveValues(exitStatus = list(code=-1, mess = "NULL", err = "NULL"))

# function derive from shinyFiles to load Home on linux and home for MACOS
getOwnVolume <- function (exclude=NULL)
{
  osSystem <- Sys.info()["sysname"]
  if (osSystem == "Darwin") {
    # disk <- list.files("/Volumes/", full.names = T)
    # names(disk) <- disk
    home <- c(home = "~")
    # volumes <- c(home, disk)
    volumes <- home
  }
  else if (osSystem == "Linux") {
    volumes <- c(root = "/")
    home <- c(home = "~")
    media <- list.files("/media", full.names = T)
    names(media) <- media
    volumes <- c(home, media, volumes)
  }
  else if (osSystem == "Windows") {
    volumes <- system("wmic logicaldisk get Caption", intern = T)
    volumes <- sub(" *\\r$", "", volumes)
    keep <- !tolower(volumes) %in% c("caption", "")
    volumes <- volumes[keep]
    volNames <- system("wmic logicaldisk get VolumeName",
                       intern = T)
    volNames <- sub(" *\\r$", "", volNames)
    volNames <- volNames[keep]
    volNames <- paste0(volNames, ifelse(volNames == "",
                                        "", " "))
    volNames <- paste0(volNames, "(", volumes, ")")
    names(volumes) <- volNames
  }
  else {
    stop("unsupported OS")
  }
  if (!is.null(exclude)) {
    volumes <- volumes[!names(volumes) %in% exclude]
  }
  volumes
}

# list of volumes acces to load data
allVolumesAvail <<- getOwnVolume()

listFilesRun <- c()

# function to test if directory pass contain sub-directory limbe, background lesion
existDirCalibration <- function(dirCalibration){
  list(
    dirLimbe = file.exists(paste(dirCalibration,"/limbe", sep = .Platform$file.sep)),
    dirBackground = file.exists(paste(dirCalibration,"/background", sep = .Platform$file.sep)),
    dirLesion = file.exists(paste(dirCalibration,"/lesion", sep = .Platform$file.sep))
  )
}
############################################
## writing server function
############################################

shinyServer(function(input, output, session) {
  
  fileReaderData <- reactiveFileReader(500, session,
                                       logfilename, readLines)
  
  output$log <- renderText({
    # Read the text, and make it a consistent number of lines so
    # that the output box doesn't grow in height.
    text <- fileReaderData()
    length(text) <- 14
    text[is.na(text)] <- ""
    paste(text, collapse = '\n')
  })
  
  # Load functions for tab calibration
  source(file.path("server_code", "tabCalibrationServer.R"), local = TRUE)$value
  
  # Load functions for tab analysis
  source(file.path("server_code", "tabAnalysisServer.R"), local = TRUE)$value

  # Load functions for tab Home
    source(file.path("server_code", "tabHomeServer.R"), local = TRUE)$value
  # output$debug <- renderPrint({
  #   sessionInfo()
  # })
  
  observeEvent(input$actu, {
    print("toto")
    showConnections(all = TRUE)
    fileReaderData()
  })
  
  observeEvent(input$close, {
    unlink(logfilename)
    closeAllConnections()
    # stopCluster(cl)
    registerDoSEQ()
    stopApp()                             # stop shiny
  })
  
  session$onSessionEnded( function() {
    unlink(logfilename)
    closeAllConnections();
    # stopCluster(cl)
    registerDoSEQ()
    stopApp()
  })
  
  observe({
    # debug output to show the listN content.
    output$debug <- renderPrint({
      rv %>% reactiveValuesToList
    })
  })
})
