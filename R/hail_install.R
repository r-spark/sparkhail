#' Install Hail and Datasets
#' 
#' Install hail dependencies and datasets to run the examples in documentation.
#' To remove hail use \code{hail_uninstall}. 
#'   
#' @param datasets_examples If TRUE, hail will be downloaded along with the datasets to
#' run the examples. Use FALSE if you just want to install hail.
#' 
#' @examples 
#' \dontrun{
#'  hail_install()
#'  hail_uninstall()
#' }
#' @name hail_install
NULL

#' @rdname hail_install
#' @export
hail_install <- function(datasets_examples = TRUE){
  hail_exists <- system.file("java/hail-all-spark.jar", package = "sparkhail")
  
  if (hail_exists != ""){
    message("Hail is already installed.")
  } else {
    hail_all_spark <- "https://raw.githubusercontent.com/r-spark/sparkhail/hail-all-spark-0.1.1/inst/java/hail-all-spark.jar"
    utils::download.file(hail_all_spark, 
                         destfile = paste0(system.file(package = "sparkhail"),
                                           "/java/hail-all-spark.jar"),
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