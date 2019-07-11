#' @export
hail_context <- function(sc) {
  sparklyr::invoke_static(sc, "is.hail.HailContext", "getOrCreate",
                          spark_context(sc), "Hail",
                          create_option_string(sc, "none"),
                          sc$master, "hail.log", FALSE, FALSE, 1, 50L, "/tmp", 3L )
  
}