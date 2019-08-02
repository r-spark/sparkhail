#' Read Hail Configuration
#'
#' Set configuration for Hail using \code{spark_config()}.  
#' 
#' @param config A spark configuration.
#'
#' @export
hail_config <- function(config = sparklyr::spark_config()) {
  config$spark.serializer <- "org.apache.spark.serializer.KryoSerializer"
  config$spark.kryo.registrator <- "is.hail.kryo.HailKryoRegistrator"
  
  config
}