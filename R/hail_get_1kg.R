#' Download the Dataset Examples
#' 
#' This function creates an extdata folder and downloads the datasets necessary to 
#' run the examples: 1kg MatrixTable folder and annotations.txt.
#' 
#' @examples 
#' \dontrun{
#' hail_get_1kg()
#' }
#' @export
hail_get_1kg <- function(){
  extdata_exists <- system.file("extdata/1kg.mt", package = "sparkhail")
  if (extdata_exists != ""){
    message("1kg dataset is already downloaded.")
  } else {
    extdata_dir <- paste0(system.file(package = "sparkhail") ,"/extdata")
    dir.create(extdata_dir)
    extdata_url <- "https://raw.githubusercontent.com/r-spark/sparkhail/hail-all-spark-0.1.1/inst/extdata/1kg.zip"
    utils::download.file(extdata_url, 
                         destfile = paste0(extdata_dir, "/1kg.zip"),
                         method = "wget",
                         quiet = TRUE)
    
    utils::unzip(paste0(extdata_dir, "/1kg.zip"), exdir = extdata_dir)
    unlink(paste0(extdata_dir, "/1kg.zip"), recursive = TRUE)
  }
} 