library('tidyverse')
library('lubridate')

conflictdata = read.csv('python_conflict_data.csv')
summary(conflictdata)

# gives number of conflicts in 1999 and 2009
conflicts1999 = conflictdata %>%  # gives 189
  filter(year == 1999)
conflicts2009 = conflictdata %>% # gives 1514
  filter(year == 2009)

#calculating the total number of deaths
conflicts1999$total_deaths <- conflicts1999$deaths_civilians + conflicts1999$deaths_a + conflicts1999$deaths_b
conflicts2009$total_deaths <- conflicts2009$deaths_civilians + conflicts2009$deaths_a + conflicts2009$deaths_b

summary(conflicts1999$total_deaths) #Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
                                    #0.000   0.000   2.000   8.582   8.000 200.000 
summary(conflicts2009$total_deaths) #Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
                                    #0.000   1.000   2.000   4.119   4.000 170.000 
summary(conflicts1999$deaths_civilians) #Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
                                        #0.000   0.000   0.000   3.085   0.000 200.000 
summary(conflicts2009$deaths_civilians) #Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
                                        #0.0000  0.0000  0.0000  0.7259  0.0000 50.0000 

#total_deaths only conflicts 1999
ggplot(data = conflicts1999) + 
  geom_polygon(data = map_data('world', 'Afghanistan'), mapping = aes(x=long, y=lat, group=group)) +
  geom_point(mapping = aes(x = longitude, y = latitude, colour = 'conflicts1999', size = total_deaths), alpha = 0.65) 
#total_deaths only conflicts 2009
ggplot(data = conflicts2009) + 
  geom_polygon(data = map_data('world', 'Afghanistan'), mapping = aes(x=long, y=lat, group=group)) +
  geom_point(mapping = aes(x = longitude, y = latitude, colour = 'conflicts2009', size = total_deaths), alpha = 0.65) 


#map  total deaths 1999 and 2009
ggplot(data = conflicts1999) + 
  geom_polygon(data = map_data('world', 'Afghanistan'), mapping = aes(x=long, y=lat, group=group)) +
  geom_point(mapping = aes(x = longitude, y = latitude, colour = 'conflicts1999', size = total_deaths), alpha = 0.55) +
  geom_point(data =  conflicts2009, alpha = 0.55, mapping = aes(x = longitude, y = latitude, colour = 'conflicts2009', size = total_deaths))


#map deaths civilians 1999 and 2009
library('ggplot2')
ggplot(data = conflicts1999) + 
  geom_polygon(data = map_data('world', 'Afghanistan'), mapping = aes(x=long, y=lat, group=group)) +
  geom_point(mapping = aes(x = longitude, y = latitude, colour = 'conflicts1999', size = deaths_civilians), alpha = 0.55) +
  geom_point(data =  conflicts2009, alpha = 0.55, mapping = aes(x = longitude, y = latitude, colour = 'conflicts2009', size = deaths_civilians))


##barcharts

#type of violence per years #
conflicts1999$type_of_violence[0]
conflicts1999$type_of_violence = as.factor(conflicts1999$type_of_violence)
conflicts2009$type_of_violence = as.factor(conflicts2009$type_of_violence)

ggplot(data = conflicts1999) + 
  geom_bar(mapping = aes(x = type_of_violence, fill = type_of_violence))
ggplot(data = conflicts2009) + 
  geom_bar(mapping = aes(x = type_of_violence, fill = type_of_violence))

#type of violence for 1999 and 2009, combined for better overview
conflicts99_09 = conflictdata %>%
  filter(year == 2009 | year == 1999)
conflicts99_09$type_of_violence = as.factor(conflicts99_09$type_of_violence)
ggplot(data = conflicts99_09) + 
  geom_bar(mapping = aes(x = year, fill = type_of_violence))

#draft boxplot code, not finished
# conflicts99_09$total_deaths <- conflicts99_09$deaths_civilians + conflicts99_09$deaths_a + conflicts99_09$deaths_b
# ggplot(data = conflicts99_09, mapping = aes(x = mean(total_deaths), y = year)) + 
#   geom_boxplot()


