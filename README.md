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
hl <- hail_context()
mt <- read_matrix_table(hl, "inst/data/1kg.mt")
```

## Describe

You can take the information about the matrix table separately using
`mt_globals_fields()`, `mt_col_fields()`, `mt_row_fields()`,
`mt_entry_fields()`, `mt_col_key()` and `mt_row_key()`. Or you can use
`describe()`.

``` r
describe(mt)
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