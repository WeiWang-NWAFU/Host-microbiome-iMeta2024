library(qqman)

##Read TWAS results
twas <-read.csv(file="C:/Users/data.csv", header=T)

##plot
colorset<-c("#B395BD", "#EA8379", "#7DAEE0")

manhattan(twas, cex.lab = 1.5, cex.main = 2,cex = 1.2,
            chr = "CHR", bp = "BP", snp= "SNP", p = "P",
            suggestiveline = -log10(6.0e-05), genomewideline = -log10(3.0e-06) , annotateTop = FALSE,
            col = colorset)
  
