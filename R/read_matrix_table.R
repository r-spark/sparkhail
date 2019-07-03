#' @export
read_matrix_table <- function(hl, path){
  
  mt <- sparklyr::invoke_static(sparklyr::spark_connection(hl), "is.hail.variant.MatrixTable", "read",
                         hl, path, FALSE, FALSE)
  
  class(mt) <- c(class(mt), "hail_matrix_table")
  mt
}