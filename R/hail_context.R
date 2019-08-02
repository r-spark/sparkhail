#' Create hail context
#' 
#' Import and initialize Hail using a spark connection.
#'
#' @param sc Spark connection.
#' 
#' @examples 
#' \dontrun{
#' library(sparklyr)
#'
#' sc <- spark_connect(master = "local", version = "2.4", config = hail_config())
#'
#' hail_context(sc)
#' }
#'
#' @export
hail_context <- function(sc) {
  sparklyr::invoke_static(sc, "is.hail.HailContext", "getOrCreate",
                          spark_context(sc), "Hail",
                          create_option_string(sc, "none"),
                          sc$master, "hail.log", FALSE, FALSE, 1, 50L, "/tmp", 3L )
  
}