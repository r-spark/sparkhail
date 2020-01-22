#' Create Hail Context
#' 
#' Import and initialize Hail using a spark connection.
#'
#' @param sc Spark connection.
#' 
#' @return hailContext
#' @examples 
#' library(sparklyr)
#'
#' sc <- spark_connect(master = "spark://HOST:PORT", config = hail_config())
#' connection_is_open(sc)
#' hail_context(sc)
#' spark_disconnect(sc)
#'
#' @export
hail_context <- function(sc) {
  sparklyr::invoke_static(sc, "is.hail.HailContext", "getOrCreate",
                          spark_context(sc), "Hail",
                          create_option_string(sc, "none"),
                          sc$master, "hail.log", FALSE, FALSE, 1, 50L, "/tmp", 3L )
  
}