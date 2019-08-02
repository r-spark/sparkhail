spark_dependencies <- function(spark_version, scala_version, ...) {
  hail_exists <- system.file("java/hail-all-spark.jar", package = "sparkhail")
  if (hail_exists == "") stop("Hail is uninstalled. Please use hail_install().")
  
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
