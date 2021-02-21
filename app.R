# this app is a minimal example of uploading a layout file using the layout uploads module
library(tidyverse)
library(shiny)
library(shinyalert) # needed to upload layout files
source("upload_layout_module.R")

    ui <- fluidPage(useShinyalert(),
            sidebarLayout(
                        sidebarPanel(width = 4,
                                     uploadLayoutUI("data")[[1]] # upload panel,
                        ),
                        mainPanel(
                            p("Layout, accessed OUTSIDE the module pair (just the head)") %>% strong(),
                            tableOutput("table_external"),
                            p("Layout, rendered INSIDE the module pair") %>% strong(),
                            uploadLayoutUI("data")[[2]] # upload panel,
                        )
                )
        )
    
    server <- function(input, output, session) {
        #### upload layout ####
        layout_raw <- uploadLayoutServer("data") # upload the data
        
        layout <- reactive(layout_raw()) # access the layout outside of the module
        output$table_external <- renderTable(head(layout()))

    }
    

shinyApp(ui = ui, server = server)
