# get_methods <- function(jobj){
#   invoke(jobj, "getClass") %>% 
#     invoke("getMethods") 
#   
#   a2 <- lapply(a, function(e) {
#     invoke(e, "toString") 
#   })
#   
# }

mt_cols <- function(jobj){
  sparklyr::invoke(jobj, "countCols")
}

mt_rows <- function(jobj){
  sparklyr::invoke(jobj, "countRows")
}
