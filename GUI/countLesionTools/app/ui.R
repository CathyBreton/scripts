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

# list of packages required
list.of.packages <- c("shiny","shinythemes","shinydashboard","shinyFiles","shinyBS","shinyjs", "DT","EBImage","MASS","lattice",
                      "parallel","foreach","doParallel","future")


#checking missing packages from list
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]

#install missing ones
if(length(new.packages)) install.packages(new.packages, dependencies = TRUE)

#Case of EBImage
if (!require('EBImage')) {
  source("https://bioconductor.org/biocLite.R")
  biocLite("EBImage")
}

#Load all library
library(shiny)
library(shinythemes)
library(shinydashboard)
library(shinyFiles)
library(shinyBS)
library(DT)
library(shinyjs)


set_wd <- function() {
  library(rstudioapi) # make sure you have it installed
  current_path <- getActiveDocumentContext()$path 
  setwd(dirname(current_path ))
  currentFilePath <<-getwd()
}
set_wd()

logfilename <<- paste0(currentFilePath,"/debug.txt")
unlink(logfilename)
# Add an entry to the log file
cat(as.character(Sys.time()), '\n', file = logfilename,
    append = TRUE)

#Load functions scripts
for(file in list.files(paste(currentFilePath,"R_code",sep = .Platform$file.sep),
                       pattern="\\.(r|R)$",
                       full.names = TRUE)) {
  source(file)
}

############################################
## Shiny dashboard start
############################################

# add header
header <- dashboardHeader(title = "Count Lesion Tools")

# Sidebar for acces to tab
sidebar <- dashboardSidebar(
  sidebarMenu(
    menuItem("Home", tabName = "tabHome", icon = icon("home")),
    menuItem("Calibration", tabName = "tabCalibration", icon = icon("balance-scale")),
    menuItem("Analysis", tabName = "tabAnalysis", icon = icon("pagelines")),
    menuItem("Debug", tabName = "tabDebug", icon = icon("dashboard"))
  )
  # actionButton('close', "Close", class = "btn btn-danger",onclick = "setTimeout(function(){window.close();},500);")
)

# Boby page
body <- dashboardBody(
  includeCSS('www/styles.css'),
  useShinyjs(),
  
  tabItems(
    # add tab for Home
    source(file.path("ui_code", "tabHomeUI.R"), local = TRUE, chdir = TRUE)$value,
    
    # add tab for calibration
    source(file.path("ui_code", "tabCalibrationUI.R"), local = TRUE, chdir = TRUE)$value,
    
    # add tab for analysis
    source(file.path("ui_code", "tabAnalysisUI.R"), local = TRUE, chdir = TRUE)$value,
    
    # other tab
    tabItem(
      tabName = "tabDebug",
      h1("DEBUG"),
      verbatimTextOutput("debug"),
      conditionalPanel(
        condition = 'input.runButtonAnalysis',
        box(
          title = "LOG", status = "info",solidHeader = TRUE, collapsible = TRUE, collapsed = TRUE,
          actionButton('actu', "actualize", class = "btn "),
          verbatimTextOutput('log', placeholder = TRUE)
        )
      ),
      shinythemes::themeSelector()  # <--- Add this somewhere in the UI
    )
  )
)

# run UI
shinyUI(
  dashboardPage(skin = "blue", header, sidebar, body)
)
