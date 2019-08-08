hail_exists <- function(){
  system.file("java/hail-all-spark.jar", package = "sparkhail")
}

mt_cols <- function(jobj){
  sparklyr::invoke(jobj, "countCols")
}

mt_rows <- function(jobj){
  sparklyr::invoke(jobj, "countRows")
}
