#-------------------------------------------------------------------------------
#1. Read the Auto_Ass1.csv and replace all missing values in each column 
#   with the mean value of that column. 

# Check if there are any missing values.
auto <- read.csv("Auto_Ass1.csv", header=T, na.strings = c("", "?")) 
auto
has_na <- any(is.na(auto)) 
has_na 

# Fill the missing values with the mean value of each column.
sapply(auto, is.numeric)
auto_numeric <- auto[, sapply(auto, is.numeric)] 
auto_numeric 

for(i in 1:ncol(auto_numeric)){ # loop through each column of the numeric data frame
  auto_numeric[is.na(auto_numeric[,i]), i] = mean(auto_numeric[,i], na.rm=TRUE) 
}
auto_numeric
auto[,sapply(auto, is.numeric)] <- auto_numeric
View(Auto)


#-------------------------------------------------------------------------------
# 2. Select cars with model years between 1970 and 1975 and engine displacement
#    greater than or equal to 3, and calculate the average fuel efficiency.
library(magrittr)
library(dplyr)
auto %>% 
  filter(between(year, 70, 75) & displacement >= 3) %>% 
  summarize(avg_mpg=mean(mpg))


#-------------------------------------------------------------------------------
# 3. Compute the distribution of car brands(names) and the mean weight.
auto %>% 
  group_by(name) %>% 
  summarize(count=n(), avg_price=mean(weight)) %>% 
  arrange(desc(avg_price)) %>% 
  View



#-------------------------------------------------------------------------------
# 4. Display the names, years, and mpg of the top 10 cars with the highest horsepower.
auto %>% 
  arrange(desc(horsepower)) %>% 
  head(10) %>% 
  select(name, year, mpg)



#-------------------------------------------------------------------------------
# 5. Draw a distribution plot of displacement and label the median and mean.
library(ggplot2)
ggplot(auto, aes(displacement)) + 
  geom_histogram(bins=20, fill="blue", alpha=0.5) + 
  geom_vline(aes(xintercept=median(displacement)), color="red", linetype="dashed") + 
  geom_vline(aes(xintercept=mean(displacement)), color="green", linetype="dashed") + 
  labs(x="displacement", y="Count", title="displacement Distribution of Auto Data") + 
  theme_minimal()



