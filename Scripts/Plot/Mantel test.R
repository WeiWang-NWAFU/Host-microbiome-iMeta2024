library(vegan)
library(ggplot2)
library(reshape2)
library(dplyr)
library(ade4)

#Read A-matrix
df <- read.csv('C:/Users/A-matrix.csv', header= TRUE)
df1 = df[,2:ncol(df)]


#Read B-matrix
tpm <- read.csv('C:/Users/B-matrix.csv', header= TRUE)
gene = tpm[,2:ncol(tpm)]

###mantle test
cor <- mantel(df1, gene, method = 'spearman', permutations = 999, na.rm = TRUE)
cor

###Matrix convert to linearity
mtrx2cols = function(m1,m2,val1,val2){
  lt = lower.tri(m1) 
  res = data.frame(row = row(m1,as.factor = T)[lt], 
                   col = col(m1,as.factor = T)[lt],  
                   val1 = m1[lt], val2= m2[lt]) 
  names(res)[3:4] = c(val1,val2) 
  return(res)
}

res = mtrx2cols(df1, gene, 'bray','kinship')
res

a <-res$kinship 
b <- res$bray
mat = data.frame(a,b)


#plot
mm <- ggplot(mat, aes(x = a, y = b )) + 
  geom_point(size = 3, alpha = 0.5, colour= "gray40") +
  geom_smooth(method = "lm", colour = "red", alpha = 0.5)+
  labs(x = "Host-genetic kinship", y = "Microbiome similarity") + 
  theme( axis.text.x = element_text(face = "bold",colour = "black", size = 12), 
         axis.text.y = element_text(face = "bold", size = 11, colour = "black"), 
         axis.title= element_text(face = "bold", size = 14, colour = "black"), 
         panel.background = element_blank(), 
         panel.border = element_rect(fill = NA, colour = "black"))

mm


