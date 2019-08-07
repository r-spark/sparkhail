#' Describe a MatrixTable 
#' 
#' \code{hail_describe} prints a hail MatrixTable structure. You can access parts of
#' the structure using \code{mt_globals_fields}, \code{mt_str_rows}, \code{mt_col_fields}, 
#' \code{mt_entry_fields}, \code{mt_row_key}, \code{mt_col_key}.
#' 
#' @param mt A MatrixTable object.
#'
#' @examples
#' \dontrun{
#' library(sparklyr)
#' 
#' sc <- spark_connect(master = "local", version = "2.4", config = hail_config())
#' 
#' hl <- hail_context(sc)
#' mt <- hail_read_matrix(hl, system.file("extdata/1kg.mt", package = "sparkhail"))
#' 
#' hail_describe(mt)
#' 
#' }
#' 
#' @name hail_describe
NULL

#' @rdname hail_describe
#' @export
hail_describe <- function(mt){
  cat(" Global Fields:", "\n",
      paste0("    ", mt_globals_fields(mt), "\n"),
      "Column Fields:", "\n",
      paste0("    ", mt_col_fields(mt), "\n"),
      "Row Fields:", "\n",
      paste0("    ", mt_row_fields(mt)[[1]], "\n"),
      "    Info:", "\n",
      paste0("        ", mt_row_fields(mt)[[2]], "\n"),
      "Entry Fields:", "\n",
      paste0("    ", mt_entry_fields(mt), "\n"),
      "Column Key:", mt_col_key(mt), "\n",
      "Row Key:", mt_row_key(mt))
}

#' @rdname hail_describe
#' @importFrom sparklyr %>% invoke
#' @export
mt_globals_fields <- function(mt){
  mt %>% 
    invoke("globals") %>% 
    invoke("value") %>% 
    invoke("toString")
}

#' @rdname hail_describe
#' @importFrom sparklyr %>% invoke
#' @export
mt_str_rows <- function(mt){
  str_row <- mt %>% 
    invoke("rowKeyStruct") %>% 
    invoke("parsableString")
  
  parse_struct(str_row)
  
}

#' @rdname hail_describe
#' @importFrom sparklyr %>% invoke
#' @export
mt_row_fields <- function(mt){
  row_fields <- mt %>% 
    invoke("rowType") %>% 
    invoke("parsableString") %>% 
    strsplit(",info:")
  
  list(fields = parse_struct(row_fields[[1]][1]),
       info = parse_struct(row_fields[[1]][2]))
}

#' @rdname hail_describe
#' @importFrom sparklyr %>% invoke
#' @export
mt_col_fields <- function(mt){
  col_fields <- mt %>% 
    invoke("colType") %>% 
    invoke("parsableString")
  
  parse_struct(col_fields)
}

#' @rdname hail_describe
#' @importFrom sparklyr %>% invoke
#' @export
mt_entry_fields <- function(mt){
  entry_fields <- mt %>% 
    invoke("entryType") %>% 
    invoke("parsableString")
  
  parse_struct(entry_fields)
}

parse_struct <- function(str){
  str <- sub("Struct{", "", str, fixed = TRUE)
  
  gsub("}", "", str, fixed = TRUE) %>% 
    strsplit( ",") %>% 
    unlist()
}

parse_arrayseq <- function(str){
  str <- sub("ArraySeq(", "", str, fixed = TRUE)
  
  sub(")", "", str, fixed = TRUE) %>% 
    strsplit( ",") %>% 
    unlist()
}

#' @rdname hail_describe
#' @importFrom sparklyr %>% invoke
#' @export 
mt_row_key <- function(mt){
  row_key <- mt %>% 
    invoke("rowKey") %>% 
    invoke("toString")
  
  parse_arrayseq(row_key)
}

#' @rdname hail_describe
#' @importFrom sparklyr %>% invoke
#' @export 
mt_col_key <- function(mt){
  mt %>% 
    invoke("colKey") %>% 
    unlist()
}
