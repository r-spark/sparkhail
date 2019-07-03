# # library(sparklyr)
# # conf <- spark_config()
# # conf$`spark.serializer` = "org.apache.spark.serializer.KryoSerializer"
# # conf$`spark.kryo.registrator` = "is.hail.kryo.HailKryoRegistrator"
# # sc <- spark_connect(master = "local", config = conf)
# # conf$`spark.driver.allowMultipleContexts` <- TRUE
# 
# #
# # #
# # # # #
# # hl <- sparklyr::invoke_static(sc, "is.hail.HailContext", "createSparkConf",
# #  sc$app_name, invoke_static(sc, "sparkhail.CreateOption", "none"), sc$master, 1L)
# # #
# # #
# # # sparklyr::invoke_static(sc, "is.hail.HailContext", "createSparkConf",
# # #                         sc$app_name, invoke_static(sc, "hailr.test.CreateOption", "none"), 8L, 1L)
# # #
# # #
# # # hl2 <- sparklyr::invoke_static(sc, "is.hail.HailContext", "theContext")
# # # # #
# # # #
# # # # sparklyr::invoke(hl, "is.hail.HailContext", "checkSparkConfiguration", hl)
# # # #
# # # # sparklyr::invoke_new(sc, "is.hail.HailContext", "HailContext")
# # # #
# # # #
# # # #                         sc$app_name, invoke_static(sc, "hailr.test.CreateOption", "none"),
# # # #                         sc$master, 1L)
# # # #
# # #
# # # # invoke_stat
# # #
# # hl2 <- sparklyr::invoke_static(sc, "is.hail.HailContext", "getOrCreate",
# # spark_context(sc), "Hail",invoke_static(sc, "sparkhail.CreateOption", "stringNone"),
# #  sc$master, "hail.log", FALSE, FALSE, 1, 50L, "/tmp", 3L )
# #
# # mt <- invoke_static(sc, "is.hail.variant.MatrixTable", "read",
# #               hl2, "data/1kg.mt", FALSE, FALSE)
# #
# # invoke_static(sc, "is.hail.TestUtils", "interceptFatal",
# #   hl2, "sdfsdf", FALSE, FALSE,
# #               invoke_static(sc, "hailr.test.CreateOption", "none"))
# #
# # def importVCF(hc: HailContext, file: String, force: Boolean = false,
# #               forceBGZ: Boolean = false,
# #               headerFile: Option[String] = None,
# #               nPartitions: Option[Int] = None,
# #               dropSamples: Boolean = false,
# #               callFields: Set[String] = Set.empty[String],
# #               rg: Option[ReferenceGenome] = Some(ReferenceGenome.GRCh37),
# #               contigRecoding: Option[Map[String, String]] = None,
# #               arrayElementsRequired: Boolean = true,
# #               skipInvalidLoci: Boolean = false,
# #               partitionsJSON: String = null): MatrixTable
# #
# #
# # #
# # # sc1 <- sparklyr::invoke_static(sc, "is.hail.HailContext", "configureAndCreateSparkContext",
# # #                               spark_context(sc))
# # # hl <- invoke_static(sc, "is.hail.HailContext", "backend")
# # #
# # # sparklyr::invoke_static(sc, "is.hail.HailContext", "configureAndCreateSparkContext",
# # #                         sc$app_name, invoke_static(sc, "hailr.test.CreateOption", "none"), sc$master, 1L)
# # #
# # # sparklyr::invoke_static(sc, "is.hail.HailContext", "checkSparkConfiguration",
# # #                         spark_context(sc))
# # #
# # #
# # # # hl2 <- sparklyr::invoke_static(sc, "is.hail.HailContext", "apply",
# # # #                                NULL, "Hail",invoke_static(sc, "hailr.test.CreateOption", "none"),
# # # #                                sc$master, "hail.log", FALSE, FALSE, 1L, 50, "/tmp", 3 )
# # # #
# # # #
# # # # sqlContext = invoke_new(sc, "org.apache.spark.sql.SQLContext", spark_context(sc))
# # # #
# # # # invoke_new(sc, "is.hail.HailContext", spark_context(sc), sqlContext, "hail.log", "/tmp", 50, 3)
# # # #
# # # #
# # # # scon <- invoke_static(sc, "is.hail.HailContext", "configureAndCreateSparkContext",
# # # #                       sc$app_name, invoke_static(sc, "hailr.test.CreateOption", "none"), sc$master, 1L)
# # # #
# # # # def getOrCreate(sc: SparkContext = null,
# # # #                 appName: String = "Hail",
# # # #                 master: Option[String] = None,
# # # #                 local: String = "local[*]",
# # # #                 logFile: String = "hail.log",
# # # #                 quiet: Boolean = false,
# # # #                 append: Boolean = false,
# # # #                 minBlockSize: Long = 1L,
# # # #                 branchingFactor: Int = 50,
# # # #                 tmpDir: String = "/tmp",
# # # #                 optimizerIterations: Int = 3)
# # # #
# # # #
# # # # spark_2.2 <- spark_compilation_spec(
# # # #   spark_version = "2.2.0",
# # # #   scalac_path = sparklyr::find_scalac("2.11"),
# # # #   jar_name = sprintf("hailr.test-2.2-2.11.jar"),
# # # #   jar_path = NULL,
# # # #   scala_filter = NULL
# # # # )
# # # #
# # # #
# # # # hl2 <- sparklyr::invoke_static(sc, "is.hail", "HailContext")
# # # #getMethods.map(_.getName)
# # # #
# 
# 
# ##### METHODS
# invoke(mt, "getClass") %>%
#   invoke("getMethods")
# 
# invoke(mt, "rowType") %>%
#   invoke("getClass") %>%
#   invoke("getMethods")
# 
# 
# 
# #    %>%
# mt %>%
#     invoke("getClass") %>%
#     invoke("getMethods")
# 
# invoke("rowKeyStruct") %>%
# invoke("value")  %>%
#     invoke("toTableValue") %>%
#     invoke("rdd") %>%
#     invoke("take", 4L)
# 
# mt %>%
#   invoke("colType")
# # invoke("rdd") %>%
# 
# 
# 
# invoke("rdd") %>% invoke("collect")
# %>%
#   invoke("toDF")
# 
# if (memory) rdd <- invoke(rdd, "cache")
# 
# schema <- spark_schema_from_rdd(sc, rdd, columns)
# 
# transformed <- invoke(hive_context(sc), "createDataFrame", rdd, schema)
# 
# 
# sc <- spark_connection(hl)
# rdd <- invoke(mt, "value")  %>%
#   invoke("toTableValue") %>%
#   invoke("rdd")
# 
# 
# sparklyr:::spark_schema_from_rdd(spark_session(sc), rdd, "alleles" )
# 
# ttt <- function(){
#   part1 <- paste0("Globals Fields:")
#   part2 <- paste0("    ", mt_globals_fields(mt))
# }
# 
