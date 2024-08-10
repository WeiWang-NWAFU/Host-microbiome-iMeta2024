#Object: Manhattan & QQ Plot for genome-wide association study
#Authors: Wangwei and Li Zhuohui
#Usage: Rscript Manhattan_QQ_plot.R  pvalue.txt.list output_name

library(qqman)
args <- commandArgs(trailingOnly = TRUE)
colorset<-c("#4C72B0", "#DD8452")
assoc_file_list <- read.table(args[1], header = F)
row <- nrow(assoc_file_list)
n <- row*2
png(paste0(args[2], ".png"), width = 1800, height=450*row)
layout(matrix(1:n, row, 2, byrow = TRUE),widths=c(3,1), heights=c(1,1))
par(mar = (c(4,4,4,4)+ 2), mgp=c(2.5,1,0))
par(bty="l", lwd=1.5) 
print(assoc_file_list)
print("Begin to plot:")
for (assoc_file in readLines(args[1])) {
    plot_main = gsub('.GWAS.assoc', '', assoc_file)
    print(plot_main)
    data <- read.table(assoc_file, header = T)
    manhattan(data, main = plot_main, x.axis = 1.5, cex.lab = 1.5, cex.main = 2,
              chr = "CHR", bp = "POS", snp= "SNP", p = "P", 
              suggestiveline = -log10(p), genomewideline = -log10(p) , annotateTop = FALSE,
              col = colorset)

    p_value = data$P
    z = qnorm(p_value/ 2)
    Lambda = round(median(z^2, na.rm = TRUE) / 0.454, 3)
    qq(data$P, main = bquote(lambda ~ '=' ~ .(Lambda)), x.axis = 1.5, cex.lab = 1.5, cex.main = 2)
}
dev.off()

