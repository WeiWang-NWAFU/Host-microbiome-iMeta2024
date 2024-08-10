library(ggplot2)
library(devtools)
library(pheatmap)

df <-read.csv("C:/Users/data.csv", header = T, row.names = 1)
corr<-cor(df, method = 'spearman')
corr[1:3,1:3]
write.csv(corr, "C:/Users/results.csv")

p <- pheatmap(corr,
              border="white", 
              cluster_cols = T, 
              cluster_rows = T,
              show_rownames = F, 
              show_colnames = F)