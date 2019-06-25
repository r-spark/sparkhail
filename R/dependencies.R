spark_dependencies <- function(spark_version, scala_version, ...) {
  sparklyr::spark_dependency(
    jars = c(
      system.file(
        sprintf("java/sparkhail-%s-%s.jar", spark_version, scala_version),
        package = "sparkhail"
      ),
      system.file(
        sprintf("java/hail-all-spark.jar"),
        package = "sparkhail"
      )
    ),
    packages = c(
    )
  )
}

#' @import sparklyr
.onLoad <- function(libname, pkgname) {
  sparklyr::register_extension(pkgname)
}
