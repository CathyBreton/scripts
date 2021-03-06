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


#### Calibration Directory path ####

# option to load directory path bottom for calibration folder
shinyDirChoose(
  input,
  'dirCalibration',
  filetypes = c('', 'txt', 'Rdata', "png", "csv", "*"),
  roots = allVolumesAvail,
  session = session,
  restrictions = system.file(package = 'base')
)

# return to UI path selected for calibration
output$dirCalibration <- renderText(rv$dirCalibration)

# when click to bottom update path
observeEvent(
  input$dirCalibration,{
    home <- normalizePath(allVolumesAvail[input$dirCalibration$root])
    rv$dirCalibration <- file.path(home,paste(unlist(input$dirCalibration$path[-1]), collapse = .Platform$file.sep))
    rv$exitStatus <- list(code=-1, mess = "NULL", err = "NULL")
  }
)
  ##### Run action  ##### 
observeEvent(
  input$runButton,{
    
    show("loading-content")
      path <-rv$dirCalibration
      listdirCalibration <- existDirCalibration(path)
      if(listdirCalibration$dirLimbe == TRUE && listdirCalibration$dirBackground == TRUE && listdirCalibration$dirLesion == TRUE){
        
        progress <<- shiny::Progress$new()
        on.exit(progress$close())
        progress$set(message = 'Making calibration, please wait\n', value = 0)
        progress$inc(1/7, detail = "Start step 1/6")
        
        listReturn <- apprentissage(rv$dirCalibration,"background","limbe","lesion")
        rv$exitStatus <-list(code=listReturn$code, mess=listReturn$mess)
        rv$outCalibrationTable <- listReturn$outCalibrationTable
        rv$outCalibrationCSV <- listReturn$outCalibrationCSV
        rv$fileRData <- listReturn$fileRData
        rv$plotFileCalibration <- listReturn$plotFileCalibration
        
        progress$inc(7/7, detail = "End of calibration 6/6")
      }
      else{
        # print(paste("else inputdir",rv$datapath))
        errorMess <-tags$div("Error not find all sub-directories !!!!:",  tags$br(),
                           tags$ul(
                             tags$li(paste("limbe: ", listdirCalibration$dirLimbe)),
                             tags$li(paste("background: ", listdirCalibration$dirBackground)),
                             tags$li(paste("lesion: ", listdirCalibration$dirLesion))
                           )
        )
        rv$exitStatus <-list(code=0, err=errorMess)
      }
    hide(id = "loading-content", anim = TRUE, animType = "fade")
  }
)

#### Output when run click ####

output$code <- renderText({
  if (rv$exitStatus$code == -1){
    return(-1)
  }
  rv$exitStatus$code

})

output$mess <- renderText({
  rv$exitStatus$mess
})
output$err <- renderPrint({
  rv$exitStatus$err
})

output$img <- renderImage({
  if (rv$exitStatus$code == -1 && is.null(rv$plotFileCalibration)){
    return(NULL)
  }
  else{
    # Return a list containing the filename
    return(list(src = rv$plotFileCalibration,
         width = 400,
         height = 400,
         filetype = "image/jpeg",
         alt = "plot img"))
  }
}, deleteFile = FALSE)

output$table <- renderTable({
  rv$outCalibrationTable

},striped = TRUE, bordered = TRUE,
align = 'c',
rownames = TRUE)

