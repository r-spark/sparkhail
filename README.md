A sparklyr extension for Hail
================

## Installation

``` r
install.packages("devtools")
devtools::install_github("samuelmacedo83/sparkhail")
```

## Read a matrix table

``` r
library(sparkhail)
library(sparklyr)

sc <- spark_connect(master = "local", version = "2.4", config = hail_config())

hl <- hail_context(sc)
mt <- hail_read_matrix(hl, system.file("data/1kg.mt", package = "sparkhail"))
```

## Describe

You can take the information about the matrix table separately using
`mt_globals_fields()`, `mt_col_fields()`, `mt_row_fields()`,
`mt_entry_fields()`, `mt_col_key()` and `mt_row_key()`. Or you can use
`describe()`.

``` r
hail_describe(mt)
```

    ##  Global Fields: 
    ##      []
    ##  Column Fields: 
    ##      s:String
    ##  Row Fields: 
    ##      locus:Locus(GRCh37)
    ##      alleles:Array[String]
    ##      rsid:String
    ##      qual:Float64
    ##      filters:Set[String]
    ##      Info: 
    ##          AC:Array[Int32]
    ##          AF:Array[Float64]
    ##          AN:Int32
    ##          BaseQRankSum:Float64
    ##          ClippingRankSum:Float64
    ##          DP:Int32
    ##          DS:Boolean
    ##          FS:Float64
    ##          HaplotypeScore:Float64
    ##          InbreedingCoeff:Float64
    ##          MLEAC:Array[Int32]
    ##          MLEAF:Array[Float64]
    ##          MQ:Float64
    ##          MQ0:Int32
    ##          MQRankSum:Float64
    ##          QD:Float64
    ##          ReadPosRankSum:Float64
    ##          set:String
    ##  Entry Fields: 
    ##      GT:Call
    ##      AD:Array[+Int32]
    ##      DP:Int32
    ##      GQ:Int32
    ##      PL:Array[+Int32]
    ##  Column Key: s 
    ##  Row Key: locus  alleles

## Data Frame

Convert to Data Frame as
follows,

``` r
rdd <- mt %>% invoke("rvd") %>% invoke("toRows") %>% invoke_static(sc, "sparkhail.HailConverter", "mtToRdd", .)

fields <- lapply(1:6, function(x) invoke_static(sc, 
                                                "sparklyr.SQLUtils", 
                                                "createStructField", 
                                                paste0("F", x), 
                                                "character", 
                                                TRUE))

schema <- invoke_static(sc, "sparklyr.SQLUtils", "createStructType", fields)

invoke(hive_context(sc), "createDataFrame", rdd, schema) %>% sparklyr::sdf_register()
```

    ## # Source: spark<?> [?? x 6]
    ##    F1        F2       F3       F4       F5       F6      
    ##    <chr>     <chr>    <chr>    <chr>    <chr>    <chr>   
    ##  1 1:904165  x.get(1) x.get(2) x.get(3) x.get(4) x.get(5)
    ##  2 1:909917  x.get(1) x.get(2) x.get(3) x.get(4) x.get(5)
    ##  3 1:986963  x.get(1) x.get(2) x.get(3) x.get(4) x.get(5)
    ##  4 1:1563691 x.get(1) x.get(2) x.get(3) x.get(4) x.get(5)
    ##  5 1:1707740 x.get(1) x.get(2) x.get(3) x.get(4) x.get(5)
    ##  6 1:2252970 x.get(1) x.get(2) x.get(3) x.get(4) x.get(5)
    ##  7 1:2284195 x.get(1) x.get(2) x.get(3) x.get(4) x.get(5)
    ##  8 1:2779043 x.get(1) x.get(2) x.get(3) x.get(4) x.get(5)
    ##  9 1:2944527 x.get(1) x.get(2) x.get(3) x.get(4) x.get(5)
    ## 10 1:3761547 x.get(1) x.get(2) x.get(3) x.get(4) x.get(5)
    ## # … with more rows

## Cleanup

Then disconenct from Spark and Hail,

``` r
spark_disconnect(sc)
```

    ## NULL
