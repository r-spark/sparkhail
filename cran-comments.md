## Test environments
* local OS X install, R 3.6.1
* ubuntu Xenial 16.04  (on travis-ci), R 3.6.1
* win-builder (devel and release)

## Softwares used

* R 3.6.1
* spark 2.4.\*
* hail 0.2

## R CMD check results
There were no ERRORs or WARNINGs. 

## Notes on rhub

 * The examples in documentation use dontrun because I use spark and hail, but there is
 a runnable example in spark_context.R
 * The LICENSE is needed because the use of apache spark
 * The function hail_get_1kg was improved. Now the user can choose the path and the data is not saved in home directory.
 * The function spark_hail was improved. Now the user can choose the path of the jars.
 

*Possibly mis-spelled words in DESCRIPTION:
  hail (https://hail.is/)
  python (https://www.python.org/)
  GWAS (genome-wide association study)
  scala (https://www.scala-lang.org/)
  spark (https://spark.apache.org/)
  sparklyr (https://spark.rstudio.com/)
  tidyverse (https://www.tidyverse.org/)