context("test-1-hail_install")

test_that("hail_install", {
  skip_on_cran()
  
  # spark is needed to install hail
  expect_gt(nrow(sparklyr::spark_installed_versions()), 0)
  
  sparklyr::spark_disconnect_all()
  sc <- sparklyr::spark_connect(master = "local", config = hail_config())

  expect_false(hail_exists() == "")
})
