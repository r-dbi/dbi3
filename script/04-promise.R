library("dbi3")

context <- dbi_classic(duckdb::duckdb())

conn <- dbi_connect(context)

stmt1 <- dbi_statement(conn, "SELECT 42")

dbi_capabilities(conn, "dbi_promises")
#> [1] TRUE

promises::then(stmt1,
  function(tbl) {
    as.data.frame(tbl)$a
  }
)
#> [1] 42
