context("test-data_frame")

test_that("hail_data_frame", {
  skip_on_cran()
  skip_if(hail_exists() == "")
  skip_if(system.file("extdata/1kg.mt", package = "sparkhail") == "")
  
  sc <- sparklyr::spark_connect(master = "local", config = hail_config())

  hl <- hail_context(sc)
  mt <- hail_read_matrix(hl, system.file("extdata/1kg.mt", package = "sparkhail"))
  
  df <- mt %>%  
    hail_dataframe() %>% 
    head() %>% 
    sparklyr::collect()
  
  expect_equal(df$locus[1], "1:904165") 
  expect_equal(df$alleles[[1]][[1]], "G") # nested column
})

test_that("hail_entries", {
  skip_on_cran()
  skip_if(hail_exists() == "")
  skip_if(system.file("extdata/1kg.mt", package = "sparkhail") == "")
  
  sc <- sparklyr::spark_connect(master = "local", config = hail_config())
  
  df <- hail_context(sc) %>% 
    hail_read_matrix(system.file("extdata/1kg.mt", package = "sparkhail")) %>% 
    hail_dataframe() %>% 
    hail_entries() %>% 
    head() %>% 
    sparklyr::collect()

  expect_equal(df$call[1], 4) 
  expect_equal(df$ad[[1]][[1]][[1]], 4) # nested column
})

