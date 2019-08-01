#' @export
hail_dataframe <- function(x){
  UseMethod("hail_dataframe")
}

#' @importFrom sparklyr invoke invoke_static
#' @export
hail_dataframe.hail_matrix_table <- function(mt){
  sc <- sparklyr::spark_connection(mt)
  rdd <- mt %>%
    invoke("rvd") %>%
    invoke("toRows") %>%
    invoke_static(sc, "sparkhail.HailConverter", "mtToRdd", .)

  fields <- vcf_fields(sc)

  schema <- invoke_static(sc, "sparklyr.SQLUtils", "createStructType", fields)
  
  invoke(sparklyr::hive_context(sc), "createDataFrame", rdd, schema) %>%
    sparklyr::sdf_register()
  
}

vcf_fields <- function(sc){
  features <- list(c("locus", "character"),
                   c("alleles", "array<character>"),
                   c("rsid", "character"),
                   c("qual", "numeric"),
                   c("filter", "array<character>"),
                   c("info", paste0("struct<AC:array<integer>,AF:array<numeric>,",
                                   "AN:integer,BaseQRankSum:numeric,",
                                   "ClippingRankSum:numeric,DP:integer,", 
                                   "DS:logical,FS:numeric,",
                                   "HaplotypeScore:numeric,InbreedingCoeff:numeric,",
                                   "MLEAC:array<integer>,MLEAF:array<numeric>,",
                                   "MQ:numeric,MQ0:integer,",
                                   "MQRankSum:numeric,QD:numeric,",
                                   "ReadPosRankSum:numeric,set:character>")))

  fields <- lapply(features, 
                   function(x)  sparklyr::invoke_static(sc,
                                  "sparklyr.SQLUtils",
                                  "createStructField",
                                  x[1], x[2], TRUE))
  
  # sparklyr.SQLUtils does not have array<struct> format
  fields <- entries_field(sc, fields)
  fields
}

entries_field <- function(sc, fields){
  fields[[7]] <- sparklyr::invoke_static(sc,
                                         "sparkhail.HailConverter", 
                                         "entriesStruct")
  fields
}
