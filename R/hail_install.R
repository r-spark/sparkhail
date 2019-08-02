#' @export
hail_install <- function(){
  hail_exists <- system.file("java/hail-all-spark.jar", package = "sparkhail")
  if (hail_exists != ""){
    message("Hail is already installed.")
  } else {
    hail_all_spark <- "https://raw.githubusercontent.com/samuelmacedo83/sparkhail/master/inst/java/hail-all-spark.jar"
    utils::download.file(hail_all_spark, 
                         destfile = paste0(system.file(package = "sparkhail"),
                                           "/java/hail-all-spark.jar"),
                         method = "wget",
                         quiet = TRUE)
  }
} 
  
#' @export
hail_uninstall <- function(){
  hail_exists <- system.file("java/hail-all-spark.jar", package = "sparkhail")
  if (hail_exists == ""){
    message("Hail is already removed.")
  } else {
    file.remove(hail_exists)
  }
}