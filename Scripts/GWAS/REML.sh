pheno=$1
i=$2

gcta --reml --reml-alg 0 --grm grm  --qcovar covariates.txt --pheno ${pheno} --mpheno ${i}  --out dir/re_${i}

