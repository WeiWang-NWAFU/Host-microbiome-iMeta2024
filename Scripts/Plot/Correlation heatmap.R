library(psych)
library(pheatmap)
library(reshape2)

#Read A-matrix
junqun <-read.csv("C:/Users/A-matrix.csv", sep = ",", header = T)
phy = junqun[,2:ncol(junqun)]
phy[1:5,1:5]

#Read B-matrix
func <-read.csv("C:/Users/B-matrix.csv", sep = ",", header=T)
met = func[,2:ncol(func)]
met[1:5,1:5]


#Calculate correlation
cor <-corr.test(phy, met, method = "spearman", adjust="BH")
head(cor)

cmt <-cor$r
pmt <- cor$p
head(cmt)
head(pmt)

cmt.out<-cbind(rownames(cmt),cmt)
pmt.out<-cbind(rownames(pmt),pmt)

df <-melt(cmt,value.name="cor")
df$pvalue <-as.vector(pmt)
head(df)
write.table(df,file="C:/Users/result.cor-p.txt",sep="\t",row.names=F)

#p-value
if (!is.null(pmt)){
  ssmt <- pmt< 0.01
  pmt[ssmt] <-'**'
  smt <- pmt >0.01& pmt <0.05
  pmt[smt] <- '*'
  pmt[!ssmt&!smt]<- ''
} else {
  pmt <- F
}


#Plot
mycol<-colorRampPalette(c ("limegreen","white","magenta"))(50)

pheatmap(cmt, scale= "none", cluster_row = T, cluster_col = T, border=NA,
         display_numbers = pmt, fontsize_number = 6, number_color = "white",
         cellwidth = 30, cellheight =10,color=mycol, angle_col = 45) 

