#datastep and global

if(!require(shiny)) install.packages('shiny'); library(shiny)
if(!require(DBI)) install.packages('DBI'); library(DBI)
if(!require(odbc)) install.packages('odbc'); library(odbc)
if(!require(DT)) install.packages('DT'); library(DT)
if(!require(shinydashboard)) install.packages('shinydashboard'); library(shinydashboard)
if(!require(shinyWidgets)) install.packages('shinyWidgets'); library(shinyWidgets)
if(!require(tidyverse)) install.packages('tidyverse'); library(tidyverse)
if(!require(readxl)) install.packages('readxl'); library(readxl)



library(shiny)
ui     = fluidPage(
  titlePanel("COVID SEOUL"), 
  sidebarLayout(
    sidebarPanel(), 
    mainPanel()
  ) 
  
)
server = function(input, output){}
shinyApp(ui = ui, server = server)


odbc::odbcListDrivers()
con <- DBI::dbConnect(odbc::odbc(),
                      Driver   = "PostgreSQL Unicode",
                      Server   = "localhost",
                      Database = "ocdm",
                      UID = "open_cdm", 
                      PWD = "j2data2020",
                      #UID      = rstudioapi::askForPassword("Database user"),
                      #PWD      = rstudioapi::askForPassword("Database password"),
                      Port     = 5432)


#write 
dbSendQuery(con, "create schema project")
dbWriteTable(con, SQL("project.covid_seoul"), value = covid_seoul)
dbWriteTable(con, SQL("project.covid_cases"), value = covid_cases)
dbWriteTable(con, SQL("project.seoul_demo"), value = seoul_demo)
dbWriteTable(con, SQL("project.seoul_move"), value = seoul_move)
dbWriteTable(con, SQL("project.seoul_area2"), value = seoul_area2)
dbWriteTable(con, SQL("project.seoul_hospt_wk"), value = seoul_hospt_wk)
dbWriteTable(con, SQL("project.seoul_hospt"), value = seoul_hospt)
dbWriteTable(con, SQL("project.seoul_amb"), value = seoul_amb)



odbc::odbcListDrivers()
con <- DBI::dbConnect(odbc::odbc(),
                      Driver   = "PostgreSQL Unicode",
                      Server   = "localhost",
                      Database = "ocdm",
                      UID = "open_cdm", 
                      PWD = "j2data2020",
                      #UID      = rstudioapi::askForPassword("Database user"),
                      #PWD      = rstudioapi::askForPassword("Database password"),
                      Port     = 5432)

covid_seoul = dbGetQuery(con, "select * from project.covid_seoul")
covid_cases = dbGetQuery(con, "select * from project.covid_cases")
seoul_demo = dbGetQuery(con, "select * from project.seoul_demo")
seoul_move = dbGetQuery(con, "select * from project.seoul_move")
seoul_area2 = dbGetQuery(con, "select * from project.seoul_area2")
seoul_hospt_wk = dbGetQuery(con, "select * from project.seoul_hospt_wk")
seoul_hospt = dbGetQuery(con, "select * from project.seoul_hospt")
seoul_amb = dbGetQuery(con, "select * from project.seoul_amb")

##shinyapp start

ui <- basicPage(
  h2("covid seoul"),
  DT::dataTableOutput("mytable")
)

server <- function(input, output){
  output$mytable = DT::renderDataTable({
    covid_seoul
  })
}

ui2 <- basicPage(
  h2("covid cases"),
  DT::dataTableOutput("mytable")
)

server2 <- function(input, output){
  output$mytable = DT::renderDataTable({
    covid_cases
  })
}


ui3 <- basicPage(
  h2("seoul_demo"),
  DT::dataTableOutput("mytable")
)

server3 <- function(input, output){
  output$mytable = DT::renderDataTable({
    seoul_demo
  })
}


ui4 <- basicPage(
  h2("seoul_area2"),
  DT::dataTableOutput("mytable")
)

server4 <- function(input, output){
  output$mytable = DT::renderDataTable({
    seoul_area2
  })
}


ui5 <- basicPage(
  h2("seoul_move"),
  DT::dataTableOutput("mytable")
)

server5 <- function(input, output){
  output$mytable = DT::renderDataTable({
    seoul_move
  })
}


ui6 <- basicPage(
  h2("seoul_hospt_wk"),
  DT::dataTableOutput("mytable")
)

server6 <- function(input, output){
  output$mytable = DT::renderDataTable({
    seoul_hospt_wk
  })
}


ui7 <- basicPage(
  h2("seoul_hospt"),
  DT::dataTableOutput("mytable")
)

server7 <- function(input, output){
  output$mytable = DT::renderDataTable({
    seoul_hospt
  })
}


ui8 <- basicPage(
  h2("seoul_amb"),
  DT::dataTableOutput("mytable")
)

server8 <- function(input, output){
  output$mytable = DT::renderDataTable({
    seoul_amb
  })
}

shinyApp(ui, server)
shinyApp(ui2, server2)
shinyApp(ui3, server3)
shinyApp(ui4, server4)
shinyApp(ui5, server5)
shinyApp(ui6, server6)
shinyApp(ui7, server7)
shinyApp(ui8, server8)



