#' Download the Dataset Examples
#' 
#' This function creates an extdata folder and downloads the datasets necessary to 
#' run the examples: 1kg MatrixTable folder and annotations.txt.
#' @param path The folder that the user wants to download the data. The path is NULL
#' the data will be downloaded in a temp folder. 
#' 
#' @export
hail_get_1kg <- function(path = NULL){
  if(is.null(path)) {
    path <- tempdir()
  }
  
  extdata_url <- "https://raw.githubusercontent.com/r-spark/sparkhail/hail-all-spark-0.1.1/inst/extdata/1kg.zip"
  utils::download.file(extdata_url, 
                       destfile = paste0(path, "/1kg.zip"),
                       method = "wget",
                       quiet = TRUE)
    
  utils::unzip(paste0(path, "/1kg.zip"), exdir = path)
  unlink(paste0(path, "/1kg.zip"), recursive = TRUE)
}
