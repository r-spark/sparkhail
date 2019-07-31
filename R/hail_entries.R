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