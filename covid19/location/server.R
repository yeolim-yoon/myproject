 
library(shiny)
server <- function(input, output){
  output$table1 = DT::renderDataTable({
    covid_seoul
  })
  output$table1_a = DT::renderDataTable({
    covid_cases_seoul
  })
  output$table1_b = DT::renderDataTable({
    covid_cases_new_cases
  })
  output$table1_c = DT::renderDataTable({
    covid_cases_cum_by_area
  })
  output$table1_d = DT::renderDataTable({
    covid_cases_by_date
  })
  output$table2 = DT::renderDataTable({
    covid_route_sum
  })
  output$table2_a = DT::renderDataTable({
    covid_route_by_area
  })
  output$table2_b = DT::renderDataTable({
    covid_route_by_route
  })
  output$table3 = DT::renderDataTable({
    seoul_demo
  })
  output$table4 = DT::renderDataTable({
    seoul_area2
  })
  output$table5 = DT::renderDataTable({
    seoul_move
  })
  output$table6 = DT::renderDataTable({
    seoul_hospt_wk
  })
  output$table7 = DT::renderDataTable({
    seoul_hospt
  })
  output$table8 = DT::renderDataTable({
    seoul_amb
  })
}