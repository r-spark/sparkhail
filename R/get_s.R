#' @export
get_s <- function(mt){
  
  s <- mt %>%
    invoke("colKeys") %>% 
    lapply(function(x){
      invoke(x, "getString", 0L)
    }) %>% unlist() 
  
  s <- dplyr::tibble(s)
  sparklyr::sdf_copy_to(sparklyr::spark_connection(mt), s)
}

