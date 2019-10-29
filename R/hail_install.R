#' Install Hail and Datasets
#' 
#' Install hail dependencies and datasets to run the examples in documentation.
#' To remove hail use \code{hail_uninstall}. 
#'   
#' @param datasets_examples If TRUE, hail will be downloaded along with the datasets to
#' run the examples. Use FALSE if you just want to install hail.
#' @param hail_path A string with the path of the jar. Sparklyr extensions normally
#' install the jars in the java folder, but you can select a different one.
#' 
#' @name hail_install
NULL

#' @rdname hail_install
#' @export
hail_install <- function(datasets_examples = TRUE, hail_path = "java_folder"){
  
  if (hail_path == "java_folder"){
    hail_path <- paste0(system.file(package = "sparkhail"),
                        "/java/hail-all-spark.jar")    
  }

  hail_exists <- system.file("java/hail-all-spark.jar", package = "sparkhail")
  
  if (hail_exists != ""){
    message("Hail is already installed.")
  } else {
    hail_all_spark <- "https://raw.githubusercontent.com/r-spark/sparkhail/hail-all-spark-0.1.1/inst/java/hail-all-spark.jar"
    utils::download.file(hail_all_spark, 
                         destfile = hail_path,
                         method = "wget",
                         quiet = TRUE)
  }
  
  if(datasets_examples) hail_get_1kg()
} 

#' @rdname hail_install
#' @export
hail_uninstall <- function(){
  hail_exists <- system.file("java/hail-all-spark.jar", package = "sparkhail")
  if (hail_exists == ""){
    message("Hail is already removed.")
  } else {
    file.remove(hail_exists)
  }
}