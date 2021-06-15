#data import
library(readxl)
covid_cases_by_date <- read_excel("covid19/covid_cases_by_date.xlsx")
covid_cases_cum_by_area <- read_excel("covid19/covid_cases_cum_by_area.xlsx")
covid_cases_new_cases <- read_excel("covid19/covid_cases_new_cases.xlsx")
covid_cases_seoul <- read_excel("covid19/covid_cases_seoul.xlsx")
covid_route_by_area <- read_excel("covid19/covid_route_by_area.xlsx")
covid_route_by_route <- read_excel("covid19/covid_route_by_route.xlsx")
covid_route_sum <- read_excel("covid19/covid_route_sum.xlsx")
covid_seoul <- read_excel("covid19/covid_seoul.xlsx")
seoul_amb <- read_excel("covid19/seoul_amb.xlsx")
seoul_area2 <- read_excel("covid19/seoul_area2.xlsx")
seoul_demo <- read_excel("covid19/seoul_demo.xlsx")
seoul_hospt_wk <- read_excel("covid19/seoul_hospt_wk.xlsx")
seoul_hospt <- read_excel("covid19/seoul_hospt.xlsx")
seoul_move <- read_excel("covid19/seoul_move.xlsx")

area <- read_excel("covid19/area.xlsx")
area_map <- read_excel("covid19/area_map.xlsx")
area_map2 <- read_excel("covid19/area_map2.xlsx")
area_map_약국 <- read_excel("covid19/area_map_약국.xlsx")

#for visualization 

seoul_move2 <- seoul_move
seoul_move2$area2 <- 1:25
seoul_move2$daytime_population <- seoul_move2$주간인구지수

covid_cases_by_date2 <- covid_cases_by_date
covid_cases_by_date2$n_cum <- covid_cases_by_date2$`누적 확진자`
covid_cases_by_date2 <- covid_cases_by_date2[,-c(3)] 
covid_cases_by_date2 <-  covid_cases_by_date2[order(covid_cases_by_date2$n_cum),]
covid_cases_by_date2$date1 <- 1:476
#date / 누적확진자

covid_cases_cum_by_area2 <- covid_cases_cum_by_area
covid_cases_cum_by_area2$area2 <- 1:26
covid_cases_cum_by_area2$n_cum <- covid_cases_cum_by_area2$`누적 확진자`
covid_cases_cum_by_area2 <- covid_cases_cum_by_area2[,-c(2)] 
covid_cases_cum_by_area2 <- covid_cases_cum_by_area2[-c(26),] 
#구 / 누적확진자

covid_route_sum2 <- covid_route_sum
covid_route_sum2$n_sum <- covid_route_sum2$`총합`
covid_route_sum2$inf_route <- covid_route_sum2$'infection route'
covid_route_sum2 <- covid_route_sum2[,-c(1,2)] 
covid_route_sum2$inf_rte <- 1:12
#infection route / 총합

seoul_amb2 <- subset(seoul_amb, select= c(area, 전체))
seoul_amb2$n_sum <- seoul_amb2$`전체`
seoul_amb2 <- seoul_amb2[-c(1),] 
seoul_amb2 <- seoul_amb2[,-c(2)] 
seoul_amb2$area2 <- 1:27
seoul_amb2 <- seoul_amb2[-c(26,27),]
#area / 전체, 합계제외

seoul_demo2 <- seoul_demo
seoul_demo2$all <- seoul_demo2$`전체_인구`
seoul_demo2$over65 <- seoul_demo2$`over 65_인구`
seoul_demo2 <- seoul_demo2[,-c(2:9)] 
seoul_demo2$area2 <- 1:25
#area / 전체_인구수 over65_인구수

seoul_hospt_comb<-seoul_hospt_wk
seoul_hospt_comb$n_hospt <- seoul_hospt$'계(총합)'
seoul_hospt_comb$n_hospt_wk <- seoul_hospt_wk$'총'
seoul_hospt_comb = subset(seoul_hospt_comb, select = c(area, n_hospt, n_hospt_wk))
seoul_hospt_comb$area2 <- 1:25
#area, n_hospt, n_hospt_wk


###################################지도

dif_color = colorFactor('Set1', area$cases)
pal2 = colorFactor('Paired', area_map2$inf_route)



leaflet(data=area_map2) %>%
  setView(lng=126.977, lat=37.546, zoom=11) %>%
  addTiles() %>%
  addProviderTiles("CartoDB.Positron") %>% 
  addCircles(lng = ~lng, lat=~lat, popup = ~inf_route, color = ~pal(inf_route)) %>%
  addMiniMap() %>%
  addMarkers(lng = ~lng,  
             lat = ~lat, 
             clusterOptions = markerClusterOptions(), 
             popup = paste(area_map2$area,"<br>" ,area_map2$inf_route)) 


plot(area_map_약국$lat, area_map_약국$lng)
library(dplyr)
cultures <- area_map_약국[area_map_약국$lng < 127.6 & area_map_약국$lat < 37.8, ]
clstdata <- dplyr::select(area_map_약국, lng, lat)
clstdata <- apply(clstdata, 2, scale)                
clstdata <- as.data.frame(clstdata)
kmeans_result <- kmeans(clstdata, centers = 9, iter.max = 1000)
clstdata$clst <- as.factor(kmeans_result$cluster)
qplot(lng, lat, color = clst, data = clstdata)    

area_map_약국$clst <- as.factor(kmeans_result$cluster) #클러스터 결과물 변수로 저장  

pal <- colorFactor('Dark2', area_map_약국$clst)
leaflet(data=area_map_약국) %>%
  setView(lng=126.977, lat=37.546, zoom=11) %>%
  addTiles() %>%
  addProviderTiles("CartoDB.Positron") %>% 
  addCircles(lng = ~lng, lat=~lat) %>%
  addMiniMap() %>%
  addCircleMarkers(lng = ~lng, lat = ~lat, color = ~pal(clst), radius = 0.1) 

###################################covid_route_by_area



ggplot(data = covid_route_sum2, mapping = aes(x = inf_route, fill = n_sum)) + 
  geom_bar(width = 1, show.legend = FALSE) + 
  theme(aspect.ratio = 1) + labs(x = NULL, y = NULL) +
  coord_polar()

ggplot(data = area_map2, mapping = aes(x = inf_route2, fill = inf_route2)) + 
  geom_bar(width = 1, show.legend = FALSE) + 
  theme(aspect.ratio = 1) + labs(x = NULL, y = NULL) +
  coord_polar() 


