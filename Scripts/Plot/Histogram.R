library(ggplot2)
library(gridExtra)

data <- read.csv('C:/Users/data.csv', header= TRUE)

p1<-ggplot(data = data,aes(title1, ..title2..)) + geom_histogram(color='white',fill='deepskyblue', bins = 10) +
  labs(y = 'y-name', x = 'x-name') + theme_classic() + geom_density(size=1.5,linetype=2,colour='red')
p1
