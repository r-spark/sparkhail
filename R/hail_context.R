#' @export
hail_context <- function(spark_version = "2.4.0"){
  conf <- sparklyr::spark_config()
  conf$`spark.serializer` = "org.apache.spark.serializer.KryoSerializer"
  conf$`spark.kryo.registrator` = "is.hail.kryo.HailKryoRegistrator"
  sc <- sparklyr::spark_connect(master = "local", config = conf, version = spark_version)
  
  sparklyr::invoke_static(sc, "is.hail.HailContext", "getOrCreate",
                          spark_context(sc), "Hail",
                          create_option_string(sc, "none"),
                          sc$master, "hail.log", FALSE, FALSE, 1, 50L, "/tmp", 3L )
  
}