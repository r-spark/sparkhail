#' Describe a matrixTable object
#'
#' @param jobj 
#'
#'
#' @examples
#' 
#' @export
hail_describe <- function(jobj){
  cat(" Global Fields:", "\n",
      paste0("    ", mt_globals_fields(jobj), "\n"),
      "Column Fields:", "\n",
      paste0("    ", mt_col_fields(jobj), "\n"),
      "Row Fields:", "\n",
      paste0("    ", mt_row_fields(jobj)[[1]], "\n"),
      "    Info:", "\n",
      paste0("        ", mt_row_fields(jobj)[[2]], "\n"),
      "Entry Fields:", "\n",
      paste0("    ", mt_entry_fields(jobj), "\n"),
      "Column Key:", mt_col_key(jobj), "\n",
      "Row Key:", mt_row_key(jobj))
}


#' @importFrom sparklyr %>% invoke
#' @export
mt_globals_fields <- function(jobj){
  jobj %>% 
    invoke("globals") %>% 
    invoke("value") %>% 
    invoke("toString")
}

#' @importFrom sparklyr %>% invoke
#' @export
mt_str_rows <- function(jobj){
  str_row <- jobj %>% 
    invoke("rowKeyStruct") %>% 
    invoke("parsableString")
  
  parse_struct(str_row)
  
}

#' @importFrom sparklyr %>% invoke
#' @export
mt_row_fields <- function(jobj){
  row_fields <- jobj %>% 
    invoke("rowType") %>% 
    invoke("parsableString") %>% 
    strsplit(",info:")
  
  list(fields = parse_struct(row_fields[[1]][1]),
       info = parse_struct(row_fields[[1]][2]))
}

#' @importFrom sparklyr %>% invoke
#' @export
mt_col_fields <- function(jobj){
  col_fields <- jobj %>% 
    invoke("colType") %>% 
    invoke("parsableString")
  
  parse_struct(col_fields)
}

#' @importFrom sparklyr %>% invoke
#' @export
mt_entry_fields <- function(jobj){
  entry_fields <- jobj %>% 
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

#' @importFrom sparklyr %>% invoke
#' @export 
mt_row_key <- function(jobj){
  row_key <- jobj %>% 
    invoke("rowKey") %>% 
    invoke("toString")
  
  parse_arrayseq(row_key)
}

#' @importFrom sparklyr %>% invoke
#' @export 
mt_col_key <- function(jobj){
  jobj %>% 
    invoke("colKey") %>% 
    unlist()
}
