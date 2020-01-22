#' Get Sample Ids 
#' 
#' Get the ids from s col key in a MatrixTable.
#' 
#' @param mt A MatrixTable object.
#'
#' @return A spark dataframe
#' @examples 
#' \dontrun{
#' library(sparklyr)
#'
#" sc <- spark_connect(master = "local", version = "2.4", config = hail_config())
#'
#' hl <- hail_context(sc)
#' mt <- hail_read_matrix(hl, system.file("extdata/1kg.mt", package = "sparkhail"))
#' 
#' hail_ids(mt)
#' }
#'
#' @export
hail_ids <- function(mt){
  
  s <- mt %>%
    invoke("colKeys") %>% 
    lapply(function(x){
      invoke(x, "getString", 0L)
    }) %>% unlist() 
  
  s <- dplyr::tibble(s)
  sparklyr::sdf_copy_to(sparklyr::spark_connection(mt), s)
}

