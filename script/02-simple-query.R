library("dbi3")

context <- dbi_classic(duckdb::duckdb())

conn <- dbi_connect(context)

qry <- dbi_query(conn, "SELECT 42")
dbi_tbl(qry)
as.data.frame(dbi_tbl(qry))
tibble::as_tibble(dbi_tbl(qry))
dplyr::collect(dbi_tbl(qry))
