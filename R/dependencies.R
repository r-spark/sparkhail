spark_dependencies <- function(spark_version, scala_version, ...) {
  hail_exists <- system.file("java/hail-all-spark.jar", package = "sparkhail")
  if (hail_exists == "") hail_install()
  
  sparklyr::spark_dependency(
    jars = c(
      system.file(
        sprintf("java/sparkhail-%s-%s.jar", spark_version, scala_version),
        package = "sparkhail"
      ),
      system.file(
        sprintf("java/hail-all-spark.jar"),
         package = "sparkhail"
      ),
      system.file(
        sprintf("java/json4s-jackson_2.11-3.2.10.jar"),
        package = "sparkhail"
      )
    ),
    packages = c("org.json4s:json4s-core_2.11:3.2.10",
                 "org.json4s:json4s-jackson_2.11:3.2.10",
                 "org.json4s:json4s-ast_2.11:3.2.10",
                 "org.json4s:json4s-native_2.11:3.2.10",
                 "org.json4s:json4s_2.11:3.2.11"),
    repositories = c(
      "https://mvnrepository.com/artifact/",
      "http://central.maven.org/maven2/"
    )
  )
}

#' @import sparklyr
.onLoad <- function(libname, pkgname) {
  sparklyr::register_extension(pkgname)
}
