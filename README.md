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

Convert to spark Data Frame as follows

``` r
df <- hail_dataframe(mt)
df
```

    ## # Source: spark<?> [?? x 7]
    ##    locus     alleles    rsid     qual filter    info        entries     
    ##    <chr>     <list>     <chr>   <dbl> <list>    <list>      <list>      
    ##  1 1:904165  <list [2]> <NA>   52346. <lgl [1]> <list [18]> <list [284]>
    ##  2 1:909917  <list [2]> <NA>    1577. <lgl [1]> <list [18]> <list [284]>
    ##  3 1:986963  <list [2]> <NA>     398. <lgl [1]> <list [18]> <list [284]>
    ##  4 1:1563691 <list [2]> <NA>    1091. <lgl [1]> <list [18]> <list [284]>
    ##  5 1:1707740 <list [2]> <NA>   93518. <lgl [1]> <list [18]> <list [284]>
    ##  6 1:2252970 <list [2]> <NA>     736. <lgl [1]> <list [18]> <list [284]>
    ##  7 1:2284195 <list [2]> <NA>  142481. <lgl [1]> <list [18]> <list [284]>
    ##  8 1:2779043 <list [2]> <NA>  288792. <lgl [1]> <list [18]> <list [284]>
    ##  9 1:2944527 <list [2]> <NA>  124329. <lgl [1]> <list [18]> <list [284]>
    ## 10 1:3761547 <list [2]> <NA>    1615. <lgl [1]> <list [18]> <list [284]>
    ## # … with more rows

## Data Frame manipulation

Now that we convert a matrix table in a spark dataframe, we can
manipulate our data using `select`, `filter`, `group_by` and so on.

``` r
library(dplyr)

df %>% 
  sdf_separate_column("alleles") %>% 
  filter(alleles_1 %in% c("G", "T")) %>% 
  select(locus, alleles_1, alleles_2, qual, entries)
```

    ## # Source: spark<?> [?? x 5]
    ##    locus     alleles_1 alleles_2    qual entries     
    ##    <chr>     <chr>     <chr>       <dbl> <list>      
    ##  1 1:904165  G         A          52346. <list [284]>
    ##  2 1:909917  G         A           1577. <list [284]>
    ##  3 1:1563691 T         G           1091. <list [284]>
    ##  4 1:1707740 T         G          93518. <list [284]>
    ##  5 1:2284195 T         C         142481. <list [284]>
    ##  6 1:2779043 T         C         288792. <list [284]>
    ##  7 1:2944527 G         A         124329. <list [284]>
    ##  8 1:3803755 T         C         383549. <list [284]>
    ##  9 1:6053630 T         G         185080. <list [284]>
    ## 10 1:6279383 G         C           1269. <list [284]>
    ## # … with more rows

You can access nested data using the `sparklyr.nested` package.

``` r
library(sparklyr.nested)

df %>% 
  sdf_select(locus,alleles, DP = info.DP)
```

    ## Warning in sdf_select(., locus, alleles, DP = info.DP): Variable name
    ## conflict detected, using disambuigated names for all nested fields

    ## # Source: spark<?> [?? x 3]
    ##    locus     alleles       DP
    ##    <chr>     <list>     <int>
    ##  1 1:904165  <list [2]> 17827
    ##  2 1:909917  <list [2]> 14671
    ##  3 1:986963  <list [2]> 12398
    ##  4 1:1563691 <list [2]> 15357
    ##  5 1:1707740 <list [2]> 19902
    ##  6 1:2252970 <list [2]> 14900
    ##  7 1:2284195 <list [2]> 18176
    ##  8 1:2779043 <list [2]> 12878
    ##  9 1:2944527 <list [2]> 17698
    ## 10 1:3761547 <list [2]> 16845
    ## # … with more rows

## Cleanup

Then disconenct from Spark and Hail,

``` r
spark_disconnect(sc)
```

    ## NULL
