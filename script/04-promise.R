library("dbi3")

context <- dbi_classic(duckdb::duckdb())

conn <- dbi_connect(context)

qry <- dbi_query(conn, "SELECT 42")

dbi_capabilities(conn, "promises")
#> [1] TRUE

promise <- promises::then(qry,
  function(tbl) {
    print(as.data.frame(tbl)$a)
  }
)

promises::promise_all(promise)
#> [1] 42
