##Authors: Wang wei and  Li Zhuohui
#Email: wangw369@nwafu.edu.cn

mphenotype_file=$1
phenotype_column=$2
outdir=$3
out_name=$4

#make bod
osca-0.46.1 --efile tpm_matrix.txt --gene-expression --no-fid --make-bod --out my

#update opi
osca-0.46.1 --befile myprofile --update-opi annotated.autochr.opi

mkdir -p ./${outdir}
#Transcriptome-wide association study
m=`expr $phenotype_column + 2`
awk 'OFS="\t" {print $1,$2,$'"$m"'}' ${mphenotype_file} >  ${outdir}/${mphenotype_file}.${phenotype_column}
osca-0.46.1 --linear --befile myprofile  --pheno ${outdir}/${mphenotype_file}.${phenotype_column} --qcovar my.qcovar --out ${outdir}/${out_name}

cat ${outdir}/${out_name}.linear | grep -w -v "nan" |grep -w -v "NA" > ${outdir}/${out_name}.linear.tmp
sed -i '1d' ${outdir}/${out_name}.linear.tmp
sed -i '1s/^/Chr	Probe	bp	Gene	Orientation	b	se	p	NMISS\n/' ${outdir}/${out_name}.linear.tmp
rm -f ${outdir}/${mphenotype_file}.${phenotype_column}
mv ${outdir}/${out_name}.linear.tmp   ${outdir}/${out_name}.linear
rm -f ${outdir}/*.log
