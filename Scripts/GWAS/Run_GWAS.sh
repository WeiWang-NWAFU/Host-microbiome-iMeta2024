#Author:wangwei
#Email:wangw369@nwafu.edu.cn
#Data:2022.08

mphenotype_file=$1
phenotype_column=$2
outdir=$3
out_name=$4

#
phenotype_column=`expr $2 + 2`

#make-GRM
mkdir -p ./${outdir}
$PWD/gemma-0.98.5-linux-static-AMD64 \
     -bfile  plink.bfile \
     -outdir ./${outdir} \
     -gk 2 \
     -p ${mphenotype_file} \
     -n ${phenotype_column} \
     -o ${out_name}

#LMM model
$PWD/gemma-0.98.5-linux-static-AMD64 \
     -bfile plink.bfile \
     -k ./${outdir}/${out_name}.sXX.txt \
     -outdir ./${outdir} \
     -p ${mphenotype_file} \
     -n ${phenotype_column} \
     -lmm 1 \
     -c  $PWD/Covariates.txt \
     -o ${out_name}.GWAS
