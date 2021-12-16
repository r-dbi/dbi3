library("dbi3")

context <- dbi_classic(duckdb::duckdb())

conn <- dbi_connect(context)

dbi_capabilities(conn, "bind")
#> [1] TRUE

dbi_capabilities(conn, "bind_require_typed")
#> [1] TRUE

dbi_capabilities(conn, "bind_placeholder")
#> [1] "?"

qry <- dbi_query(conn, "SELECT ?", params_schema = list(integer()))
# qry <- dbi_query(conn, "SELECT ?", params_schema = list(arrow::decimal(19,4)))
# qry <- dbi_query(conn, "SELECT ?", params_schema = list(sql("DECIMAL(19, 4)")))
dbi_tbl(qry)
#> Error: not bound

dbi_tbl(qry, params = list(42))

bound_qry <- dbi_bind(qry, params = list(42))
dbi_tbl(bound_qry)

bound_once_qry <- dbi_query(conn, "SELECT ?", params = list(42))
dbi_tbl(bound_once_qry)
