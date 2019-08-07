Sys.setenv("R_TESTS" = "")
library(testthat)
library(sparkhail)
library(sparklyr)

# for travis and devtools
if (identical(Sys.getenv("NOT_CRAN"), "true")) {
  spark_ver <- Sys.getenv("SPARK_VERSION")
  if(spark_ver != ""){
    sparklyr::spark_install(version = spark_ver)
  }
}

test_check("sparkhail")