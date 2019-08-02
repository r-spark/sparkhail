#' Retrieve entries field
#'
#' This function retrieves the entries fields from a hail dataframe and explodes the
#' columns call, dp and gq.
#' 
#' @param df A hail dataframe.
#' 
#' @return A spark dataframe.
#'
#' @examples
#' \dontrun{
#' library(sparklyr)
#' 
#' sc <- spark_connect(master = "local", version = "2.4", config = hail_config())
#' 
#' hail_context(sc) %>% 
#'   hail_read_matrix(system.file("extdata/1kg.mt", package = "sparkhail")) %>% 
#'   hail_dataframe() %>% 
#'   hail_entries()
#' }
#'
#' @export
hail_entries <- function(df){
  df %>% 
    sparklyr.nested::sdf_select(call = entries.Call,
                                ad = entries.AD,
                                dp = entries.DP,
                                gq = entries.GQ,
                                pl = entries.PL) %>% 
    sparklyr.nested::sdf_explode("call") %>% 
    sparklyr.nested::sdf_explode("dp") %>% 
    sparklyr.nested::sdf_explode("gq") 
}