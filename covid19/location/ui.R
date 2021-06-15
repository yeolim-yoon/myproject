#ui, dashboardPage, [header, sidebar, body ]
ui = dashboardPage(
  header  = dashboardHeader(
    title = ("Covid-19")
    ), 
  sidebar = dashboardSidebar(
    sidebarMenu(
      menuItem("About", icon = icon("mortar-board"), tabName = "about"),
      menuItem("Covid Cases", icon = icon("line-chart"), startExpanded = TRUE,
               menuSubItem("Cases", tabName ="covid_seoul", icon = icon("angle-right")),
               menuSubItem("Cases_seoul", tabName ="cases_seoul", icon = icon("angle-right")),
               menuSubItem("Cases_new_cases", tabName ="cases_new_cases", icon = icon("angle-right")),
               menuSubItem("Cases_cum_by_area", tabName ="cases_cum_by_area", icon = icon("angle-right")),
               menuSubItem("Cases_by_date", tabName ="cases_by_date", icon = icon("angle-right"))),
      menuItem("Infection Route", icon = icon("table"), startExpanded = TRUE,
               menuSubItem("Route_sum", tabName ="route_sum",  icon = icon("angle-right")),
               menuSubItem("Route_by_area", tabName ="route_by_area",  icon = icon("angle-right")),
               menuSubItem("Route_by_route", tabName ="route_by_route",  icon = icon("angle-right"))),
      menuItem("Seoul Information", icon = icon("file-text-o"), startExpanded = TRUE, 
               menuSubItem("Demographics", tabName = "seoul_demo", icon = icon("angle-right")),
               menuSubItem("Move", tabName = "seoul_move", icon = icon("angle-right")),
               menuSubItem("Area", tabName = "seoul_area2", icon = icon("angle-right")),
               menuSubItem("Hospital workers", tabName = "seoul_hospt_wk", icon = icon("angle-right")),
               menuSubItem("Hospitals", tabName = "seoul_hospt", icon = icon("angle-right")),
               menuSubItem("Ambulance", tabName = "seoul_amb", icon = icon("angle-right"))
               )
      )
  ),
  body    = dashboardBody(
    tabItems(
      tabItem(tabName = "about",
              box(width = NULL, status = "primary", solidHeader = TRUE, title="Covid-19 SEOUL Project",
                  br(),
                  ("본 프로젝트는 연세대학교 <Public Health Data Science Project> 수업에서 실습용으로 만든 앱입니다.")
              ),
              box(width = NULL, status = "primary", 
                  br(),
                  ("서울 열린 데이터광장(http://data.seoul.go.kr)으로부터 가져온 공공데이터를 바탕으로 합니다.")
              ),
              box(width = NULL, status = "primary", 
                  br(),
                  ("서울에서 첫 코로나 확진자가 발생한 2020년 1월 24일부터 2021년 5월 31일까지의 데이터를 바탕으로 만들어졌습니다.")
              ),
              box(width = NULL, status = "primary", 
                  br(),
                  ("연세대학교 경영학과 윤여림 (yeolim.yoon@yonsei.ac.kr)")
              )
      ),
      tabItem(tabName = "covid_seoul",
              box(width = NULL, status = "primary", solidHeader = TRUE, title="Covid Cases",
                  br(),
                  DT::dataTableOutput("table1")
              )
      ),
      tabItem(tabName = "cases_seoul",
              box(width = NULL, status = "primary", solidHeader = TRUE, title="Covid Cases_Seoul",
                  br(),
                  DT::dataTableOutput("table1_a")
              )
      ),
      tabItem(tabName = "cases_new_cases",
              box(width = NULL, status = "primary", solidHeader = TRUE, title="Covid Cases_New Cases",
                  br(),
                  DT::dataTableOutput("table1_b")
              )
      ),
      tabItem(tabName = "cases_cum_by_area",
              box(width = NULL, status = "primary", solidHeader = TRUE, title="Covid Cases_Cum_by_Area",
                  br(),
                  DT::dataTableOutput("table1_c")
              )
      ),
      tabItem(tabName = "cases_by_date",
              box(width = NULL, status = "primary", solidHeader = TRUE, title="Covid Cases_by_Date",
                  br(),
                  DT::dataTableOutput("table1_d")
              )
      ),
      tabItem(tabName = "route_sum",
              box(width = NULL, status = "primary", solidHeader = TRUE, title= "Infection Route",
                  br(),
                  DT::dataTableOutput("table2")
              )
      ),
      tabItem(tabName = "route_by_area",
              box(width = NULL, status = "primary", solidHeader = TRUE, title= "Infection Route_by_Area",
                  br(),
                  DT::dataTableOutput("table2_a")
              )
      ),
      tabItem(tabName = "route_by_route",
              box(width = NULL, status = "primary", solidHeader = TRUE, title= "Infection Route_by_Route",
                  br(),
                  DT::dataTableOutput("table2_b")
              )
      ),
      tabItem(tabName = "seoul_demo",
              box( width = NULL, status = "primary", solidHeader = TRUE, title="Demographics",
                   br(),
                   DT::dataTableOutput("table3")
              )
      ),
      tabItem(tabName = "seoul_move",
              box( width = NULL, status = "primary", solidHeader = TRUE, title="Move",
                   br(),
                   DT::dataTableOutput("table4")
              )
      ),
      tabItem(tabName = "seoul_area2",
              box( width = NULL, status = "primary", solidHeader = TRUE, title="Area",
                   br(),
                   DT::dataTableOutput("table5")
              )
              
      ),
      tabItem(tabName = "seoul_hospt_wk",
              box( width = NULL, status = "primary", solidHeader = TRUE, title="Hospital Workers",
                   br(),
                   DT::dataTableOutput("table6")
              )
              
      ),
      tabItem(tabName = "seoul_hospt",
              box( width = NULL, status = "primary", solidHeader = TRUE, title="Hospitals",
                   br(),
                   DT::dataTableOutput("table7")
              )
              
      ),
      tabItem(tabName = "seoul_amb",
              box( width = NULL, status = "primary", solidHeader = TRUE, title="Ambulance",
                   br(),
                   DT::dataTableOutput("table8")
              )
      )  
    )
  )
)

