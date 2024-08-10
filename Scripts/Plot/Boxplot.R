library(ggplot2)
library(RColorBrewer)

box <- read.csv("C:/Users/data.csv", header= TRUE)
#boxplot(Relative_abundance ~ geno, data = box) + scale_fill_manual(values=c("#999999", "#E69F00", "#56B4E9"))

head(box)
p = ggplot(box, aes(x=genotype, y=Relative_abundance, fill=genotype)) + stat_boxplot(geom = "errorbar",width=0.15) + geom_boxplot(width = 0.5)
p

ggplot(box, aes(x=geno, y=Relative_abundance)) +   
  stat_boxplot(geom = "errorbar",width=0.15)+  geom_boxplot()+labs(y = "Length")+  
  scale_fill_manual(values=c("#999999", "#E69F00", "#56B4E9")) +   
  theme(legend.position="none")+  
  theme_minimal()
geom_dotplot(binaxis='y', stackdir='center', dotsize=0.05, binwidth = 1)