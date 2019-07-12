#' @export
get_methods <- function(jobj){
  invoke(jobj, "getClass") %>% 
    invoke("getMethods") 
  
  a2 <- lapply(a, function(e) {
    invoke(e, "toString") 
  })
  
}

#' @importFrom sparklyr %>% invoke
#' @export
mt_cols <- function(jobj){
  invoke(jobj, "countCols")
}

#' @importFrom sparklyr %>% invoke
#' @export
mt_rows <- function(jobj){
  invoke(jobj, "countRows")
}
