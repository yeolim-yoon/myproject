#ui
function(request) {
  sidebar <- dashboardSidebar(
    hr(),
    sidebarMenu(id="tabs",
                menuItem("Covid Cases", tabName="covid_seoul", icon=icon("line-chart")),
                menuItem("Infection Route", tabName = "covid_cases", icon=icon("table"), selected=TRUE),
                menuItem("Seoul",  icon = icon("file-text-o"),
                         menuSubItem("Demographics", tabName = "seoul_demo", icon = icon("angle-right")),
                         menuSubItem("Move", tabName = "seoul_move", icon = icon("angle-right")),
                         menuSubItem("Area", tabName = "seoul_area2", icon = icon("angle-right")),
                         menuSubItem("Hospital workers", tabName = "seoul_hospt_wk", icon = icon("angle-right")),
                         menuSubItem("Hospitals", tabName = "seoul_hospt", icon = icon("angle-right")),
                         menuSubItem("Ambulance", tabName = "seoul_amb", icon = icon("angle-right"))
                ),
                menuItem("About", tabName = "about", icon = icon("mortar-board"))
    )
  )
  
  body <- dashboardBody(
    tabItems(
      tabItem(tabName = "covid_seoul",
              box(width = NULL, status = "primary", solidHeader = TRUE, title="Covid Cases",
                  br(),
                  tableOutput("table1")
              )
      ),
      tabItem(tabName = "covid_cases",
              box(width = NULL, status = "primary", solidHeader = TRUE, title= "Infection Route",
                  br(),
                  tableOutput("table2")
              )
      ),
      tabItem(tabName = "seoul_demo",
              box( width = NULL, status = "primary", solidHeader = TRUE, title="Demographics",
                   br(),
                   tableOutput("table3")
              )
      ),
      tabItem(tabName = "seoul_move",
              box( width = NULL, status = "primary", solidHeader = TRUE, title="Move",
                   br(),
                   tableOutput("table4")
              )
      ),
      tabItem(tabName = "seoul_area2",
              box( width = NULL, status = "primary", solidHeader = TRUE, title="Area",
                   br(),
                   tableOutput("table5")
              )
              
      ),
      tabItem(tabName = "seoul_hospt_wk",
              box( width = NULL, status = "primary", solidHeader = TRUE, title="Move",
                   br(),
                   tableOutput("table6")
              )
              
      ),
      tabItem(tabName = "seoul_hospt",
              box( width = NULL, status = "primary", solidHeader = TRUE, title="Move",
                   br(),
                   tableOutput("table7")
              )
              
      ),
      tabItem(tabName = "seoul_amb",
              box( width = NULL, status = "primary", solidHeader = TRUE, title="Move",
                   br(),
                   tableOutput("table8")
              )
              
      ),
      tabItem(tabName = "about",
              fluidPage(
                tags$iframe(src = './about.html', 
                            width = '100%', height = '800px',
                            frameborder = 0, scrolling = 'auto'
                )
              )
              
      )
      
    )
  )
  
  dashboardPage(
    dashboardHeader(title = "Covid-19 SEOUL"),
    sidebar,
    body
  )
  
  
}