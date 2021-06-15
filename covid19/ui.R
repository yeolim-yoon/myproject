
if(!require(shiny)) install.packages('shiny'); library(shiny)
if(!require(DBI)) install.packages('DBI'); library(DBI)
if(!require(odbc)) install.packages('odbc'); library(odbc)
if(!require(DT)) install.packages('DT'); library(DT)
if(!require(shinydashboard)) install.packages('shinydashboard'); library(shinydashboard)
if(!require(shinyWidgets)) install.packages('shinyWidgets'); library(shinyWidgets)
if(!require(tidyverse)) install.packages('tidyverse'); library(tidyverse)
if(!require(readxl)) install.packages('readxl'); library(readxl)
if(!require(tidyverse)) install.packages('tidyverse'); library('tidyverse')
if(!require(leaflet)) install.packages('leaflet'); library('leaflet')

#ui, dashboardPage, [header, sidebar, body ]
ui = dashboardPage(
  header  = dashboardHeader(
    title = ("Covid-19")
    ), 
  sidebar = dashboardSidebar(
    sidebarMenu(
      menuItem("About", icon = icon("mortar-board"), tabName = "about"),
      menuItem("Covid Cases", icon = icon("line-chart"), startExpanded = TRUE,
               menuSubItem("Cases by Date", tabName ="covid_seoul", icon = icon("angle-right")),
               menuSubItem("Cases by Area", tabName ="cases_new_cases", icon = icon("angle-right")),
               menuSubItem("Cumulated Cases by Area", tabName ="cases_cum_by_area", icon = icon("angle-right")),
               menuSubItem("Cumulated Cases by Date", tabName ="cases_by_date", icon = icon("angle-right"))),
      menuItem("Infection Route", icon = icon("table"), startExpanded = TRUE,
               menuSubItem("Route by Date", tabName ="cases_seoul", icon = icon("angle-right")),
               menuSubItem("Cumulated Cases by Route", tabName ="route_sum",  icon = icon("angle-right")),
               menuSubItem("Area by Route", tabName ="route_by_area",  icon = icon("angle-right")),
               menuSubItem("Route by Area", tabName ="route_by_route",  icon = icon("angle-right"))),
      menuItem("Seoul Information", icon = icon("file-text-o"), startExpanded = TRUE, 
               menuSubItem("Demographics", tabName = "seoul_demo", icon = icon("angle-right")),
               menuSubItem("Move (Daytime population)", tabName = "seoul_move", icon = icon("angle-right")),
               menuSubItem("Gross Area", tabName = "seoul_area2", icon = icon("angle-right")),
               menuSubItem("Hospital Workers", tabName = "seoul_hospt_wk", icon = icon("angle-right")),
               menuSubItem("Hospital & Pharmacy", tabName = "seoul_hospt", icon = icon("angle-right")),
               menuSubItem("Ambulance", tabName = "seoul_amb", icon = icon("angle-right"))
               )
      )
  ),
  body    = dashboardBody(
    tabItems(
      tabItem(tabName = "about",
              box(width = NULL, status = "primary", solidHeader = TRUE, title="Covid-19 SEOUL Project", br(),
                  (HTML("<br /> ___________________________________________________________________________________________ 
                  <br /> <br />  
                  &nbsp; &nbsp; &nbsp; 안녕하세요, 본 프로젝트는 연세대학교 [Public Health Data Science Project] 수업 실습용 앱입니다. <br /><br />
                  &nbsp; &nbsp; &nbsp; 서울시 구별 코로나 확진자 및 관련 통계자료를 확인할 수 있습니다.  
                  <br /> <br /> <br /> &nbsp; &nbsp; &nbsp;
                  2020년 1월 24일부터 2021년 5월 31일까지의 데이터를 바탕으로 만들어졌으며,<br /><br />
                  &nbsp; &nbsp; &nbsp; <서울 열린 데이터광장(http://data.seoul.go.kr)>의 공공데이터를 바탕으로 합니다.<br /> <br /> 
                   ___________________________________________________________________________________________<br /><br />
                        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 
                        연세대학교 경영학과 윤여림 (yeolim.yoon@yonsei.ac.kr)"))
              )
      ),
      tabItem(tabName = "covid_seoul",
              box(width = NULL, status = "primary", solidHeader = TRUE, title="Cases by Date", br(), DT::dataTableOutput("table1")),
              leafletOutput("map")),
      tabItem(tabName = "cases_seoul",
              box(width = NULL, status = "primary", solidHeader = TRUE, title="Route by Date", br(), DT::dataTableOutput("table1_a"))),
      tabItem(tabName = "cases_new_cases",
              box(width = NULL, status = "primary", solidHeader = TRUE, title="Covid Cases by Area", br(), DT::dataTableOutput("table1_b")),
              leafletOutput("map_by_area")),
      tabItem(tabName = "cases_cum_by_area",
              box(width = NULL, status = "primary", solidHeader = TRUE, title="Covid Cumulated Cases by Area", br(), DT::dataTableOutput("table1_c")),
              box(width = NULL, status = "primary", solidHeader = TRUE, title="Cumulated Cases by Area Plot",  br(), plotOutput("cum_area_plot", height = 600), 
                  (HTML("&nbsp; &nbsp; (구 '기타' 제외시킨 그래프입니다.) &nbsp;  <br />")))),
      tabItem(tabName = "cases_by_date",
              box(width = NULL, status = "primary", solidHeader = TRUE, title="Covid Cumulated Cases by Date", br(), DT::dataTableOutput("table1_d")),      
              box(width = NULL, status = "primary", solidHeader = TRUE, title="Cumulated Cases by Date Plot",  br(), plotOutput("date_plot", height = 600))),
      tabItem(tabName = "route_sum",
              box(width = NULL, status = "primary", solidHeader = TRUE, title= "Cumulated Cases by Route", br(), DT::dataTableOutput("table2")),
              box(width = NULL, status = "primary", solidHeader = TRUE, title="Cumulated Cases by Route Plot",  br(), plotOutput("map_route", height = 600), 
                  (HTML("&nbsp; &nbsp; ('미상/미입력','확진자접촉' 제외시킨 그래프입니다.) &nbsp;  <br />")))),
      tabItem(tabName = "route_by_area",
              box(width = NULL, status = "primary", solidHeader = TRUE, title= "Area by Infection Route", br(), DT::dataTableOutput("table2_a")),
              box(width = NULL, status = "primary", solidHeader = TRUE, title="Area by Infection Route Plot",  br(), plotOutput("route2_plot2", height = 600), 
                  (HTML("&nbsp; &nbsp; ('미상/미입력','확진자접촉' 제외시킨 그래프입니다.) &nbsp;  <br />")))),
      tabItem(tabName = "route_by_route",
              box(width = NULL, status = "primary", solidHeader = TRUE, title= "Infection Route by Area", br(), DT::dataTableOutput("table2_b")),
              box(width = NULL, status = "primary", solidHeader = TRUE, title="Infection Route by Area Plot",  br(), plotOutput("route_plot", height = 900), 
                  (HTML("&nbsp; &nbsp; ('미상/미입력','확진자접촉' 제외시킨 그래프입니다.) &nbsp;  <br />")))),
      tabItem(tabName = "seoul_demo",
              box(width = NULL, status = "primary", solidHeader = TRUE, title="Demographics", br(), DT::dataTableOutput("table3")),
              box(width = NULL, status = "primary", solidHeader = TRUE, title="Demographics Plot",  br(), plotOutput("demo_plot", height = 600))),
      tabItem(tabName = "seoul_move",
              box(width = NULL, status = "primary", solidHeader = TRUE, title="Move (Daytime population)", br(), DT::dataTableOutput("table5")),
              box(width = NULL, status = "primary", solidHeader = TRUE, title="Move Plot",  br(), plotOutput("area_plot", height = 600))),
      tabItem(tabName = "seoul_area2",
              box(width = NULL, status = "primary", solidHeader = TRUE, title="Gross Area", br(), DT::dataTableOutput("table4"))),
      tabItem(tabName = "seoul_hospt_wk",
              box(width = NULL, status = "primary", solidHeader = TRUE, title="Hospital Workers", br(), DT::dataTableOutput("table6")),
              box(width = NULL, status = "primary", solidHeader = TRUE, title="Hospital Workers Plot",  br(), plotOutput("hospt_plot", height = 600))),
      tabItem(tabName = "seoul_hospt",
              box(width = NULL, status = "primary", solidHeader = TRUE, title="Hospitals", br(), DT::dataTableOutput("table7")),
              box(width = NULL, status = "primary", solidHeader = TRUE, title="Pharmacy",  br(), (HTML("&nbsp; &nbsp; 서울시 약국 분포 &nbsp;  <br />"))),
              leafletOutput("map_hosp")),
      tabItem(tabName = "seoul_amb",
              box(width = NULL, status = "primary", solidHeader = TRUE, title="Ambulance", br(), DT::dataTableOutput("table8")),
              box(width = NULL, status = "primary", solidHeader = TRUE, title="Ambulance Plot",  br(), plotOutput("amb_plot", height = 600), 
                  (HTML("&nbsp; &nbsp; ('타지역', '미상/미입력' 제외시킨 그래프입니다.) &nbsp;  <br />"))))
    )
  )
)

