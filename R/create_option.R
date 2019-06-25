#' @export
create_option_string<- function(sc, value){
  if (value == "none") {
    sparklyr::invoke_static(sc, "sparkhail.CreateOption", "stringNone")
  }
}

#' @export
create_option_int <- function(sc, value){
  sparklyr::invoke_static(sc, "sparkhail.CreateOption", "int", as.integer(value))
}