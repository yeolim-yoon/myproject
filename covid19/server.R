library(shiny)
library(ggplot2)
library(leaflet)
library(tidyverse)

server <- function(input, output){
  output$table1 = DT::renderDataTable({covid_seoul})
  output$table1_a = DT::renderDataTable({covid_cases_seoul})
  output$table1_b = DT::renderDataTable({covid_cases_new_cases})
  output$table1_c = DT::renderDataTable({covid_cases_cum_by_area})
  output$table1_d = DT::renderDataTable({covid_cases_by_date})
  output$table2 = DT::renderDataTable({covid_route_sum})
  output$table2_a = DT::renderDataTable({covid_route_by_area})
  output$table2_b = DT::renderDataTable({covid_route_by_route})
  output$table3 = DT::renderDataTable({seoul_demo})
  output$table4 = DT::renderDataTable({seoul_area2})
  output$table5 = DT::renderDataTable({seoul_move})
  output$table6 = DT::renderDataTable({seoul_hospt_wk})
  output$table7 = DT::renderDataTable({seoul_hospt})
  output$table8 = DT::renderDataTable({seoul_amb})
  
  output$date_plot <- renderPlot({  
    plot(covid_cases_by_date2$date1, covid_cases_by_date2$n_cum,  
         main="Covid Cases in Seoul_ by Date", xlab = "Date passed from the first case (D+)", ylab="Cumulated cases (Seoul)", type="p", pch=20,  col="pink")})
  output$cum_area_plot <- renderPlot({
    ggplot(data= data.frame("Area"= covid_cases_cum_by_area2$area2, "n_cum"=covid_cases_cum_by_area2$n_cum), 
           aes(x= covid_cases_cum_by_area2$area2, y = covid_cases_cum_by_area2$n_cum)) + 
          xlab("Area") + ylab("Cumulated Cases") +
          geom_point() +  theme_classic() + scale_x_continuous(breaks = 1:25, labels = regi_label) +
          annotate("text",x=c(20,21.5,4,18),y=c(2410,2600,600,670), 
                   label=c("Gangnam-gu (2,457)","Songpa-gu (2,591)","Jung-gu (670)","Geumcheon-gu (719)"), 
                   color=c("purple","purple","blue","blue"), size=3, fontface="bold")  })

  output$demo_plot <- renderPlot({  
    ggplot(data= data.frame("Area"= seoul_demo2$area2, "n_cum"=seoul_demo2$all), 
           aes(x= seoul_demo2$area2, y = seoul_demo2$all, fill=seoul_demo2$all)) + 
      xlab("Area") + ylab("N. of population") +
      geom_col(aes(x= seoul_demo2$area2, y = seoul_demo2$all), show.legend = FALSE ) +
      scale_x_continuous(breaks = 1:25, labels = regi_label)    })
    output$area_plot <- renderPlot({  
    ggplot(data= data.frame("Area"= seoul_move2$area2, "n_cum"=seoul_move2$daytime_population), 
           aes(x= seoul_move2$area2, y = seoul_move2$daytime_population, fill=seoul_move2$daytime_population )) + 
      xlab("Area") + ylab("Daytime population") +
        geom_col(aes(x= seoul_move2$area2, y = seoul_move2$daytime_population), show.legend = FALSE ) +
        scale_x_continuous(breaks = 1:25, labels = regi_label)    })
  output$hospt_plot <- renderPlot({  
    ggplot(data= data.frame("Area"= seoul_hospt_comb$area2, "n_cum"=seoul_hospt_comb$n_hospt), 
           aes(x= seoul_hospt_comb$area2, y = seoul_hospt_comb$n_hospt, fill = seoul_hospt_comb$n_hospt)) + 
      xlab("Area") + ylab("N. of hospitals") +
      geom_col(aes(x= seoul_hospt_comb$area2, y = seoul_hospt_comb$n_hospt), show.legend = FALSE ) +
      scale_x_continuous(breaks = 1:25, labels = regi_label)    })
  output$amb_plot <- renderPlot({ 
    ggplot(data= data.frame("Area"= seoul_amb2$area2, "n_cum"=seoul_amb2$n_sum), 
           aes(x= seoul_amb2$area2, y = seoul_amb2$n_sum, fill=seoul_amb2$n_sum)) + 
      xlab("Area") + ylab("N. of cases") +
      geom_col(aes(x= seoul_amb2$area2, y = seoul_amb2$n_sum), show.legend = FALSE ) +
      scale_x_continuous(breaks = 1:25, labels = regi_label)    })
  
  output$map_route <- renderPlot({ggplot(data = area_map2, mapping = aes(x = inf_route2, fill = inf_route2)) + 
      geom_bar(width = 1, show.legend = FALSE) +  theme(aspect.ratio = 1) + labs(x = NULL, y = NULL) + coord_polar()})
  output$route_plot <- renderPlot({ggplot(data = area_map2, mapping = aes(x = inf_route2, fill = inf_route2)) + 
      geom_bar(width = 0.7, show.legend = FALSE) +  theme(aspect.ratio = 1) + labs(x = NULL, y = NULL) })
  output$route2_plot2 <- renderPlot({ggplot(data = area_map2)  + xlab("Area") + ylab("Cumulated cases") +
      geom_bar(mapping = aes(x = area_eng2, fill = inf_route2), alpha = 0.6, position = "identity")+   labs(fill = "Infection Route")})
  output$route3_plot3 <- renderPlot({ggplot(data = area_map2, mapping = aes(x = area_eng2, fill = inf_route2)) + 
      geom_bar(width = 1, show.legend = TRUE) +  theme(aspect.ratio = 1) + labs(x = NULL, y = NULL) + coord_polar() })
  
  
  output$map <- renderLeaflet({leaflet(data=area) %>% setView(lng=126.977, lat=37.546, zoom=10.5) %>%
                                addTiles() %>% addProviderTiles("CartoDB.Positron") %>% 
                                addMarkers(lng = ~lng, lat=~lat, clusterOptions = markerClusterOptions(),
                                           popup = paste(area$area_eng, "<br>" ,"cases: ", area$cases)) %>%  addMiniMap()})
  output$map2 <- renderLeaflet({leaflet(data=area) %>% setView(lng=126.977, lat=37.546, zoom=10.5) %>%
                                addTiles() %>%  
                                addMarkers(lng = ~lng, lat=~lat,  
                                           popup = paste(area$area_eng)) %>%  addMiniMap()})
  output$map_hosp <- renderLeaflet({leaflet(data=area_map_약국) %>%  setView(lng=126.977, lat=37.546, zoom=11) %>%
                                      addTiles() %>% addProviderTiles("CartoDB.Positron") %>%  
                                      addCircles(lng = ~lng, lat=~lat) %>% addMiniMap() %>%
                                      addCircleMarkers(lng = ~lng, lat = ~lat, color = ~pal(clst), radius = 0.1)}) 
  output$map_by_area <- renderLeaflet({leaflet(data=area_map2) %>%
                                        setView(lng=126.977, lat=37.546, zoom=11) %>%  addTiles() %>%  addProviderTiles("CartoDB.Positron") %>%  
                                        addCircles(lng = ~lng, lat=~lat, popup = ~inf_route, color = ~pal2(inf_route)) %>%
                                        addMiniMap() %>% addMarkers(lng = ~lng, lat = ~lat, 
                                                   clusterOptions = markerClusterOptions(),  popup = paste(area_map2$area,"<br>" ,area_map2$inf_route)) })
} 

shiny::runApp()