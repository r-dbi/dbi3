library("dbi3")

context <- dbi_classic(duckdb::duckdb())

conn <- dbi_connect(context, process = "remote")

qry <- dbi_query(conn, "SELECT 42")

dbi_capabilities(conn, "promises")
#> [1] TRUE

promises::then(qry,
  function(tbl) {
    print(as.data.frame(tbl)$a)
  }
)
#> [1] 42
