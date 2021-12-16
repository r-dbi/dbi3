library("dbi3")

context <- dbi_classic(duckdb::duckdb())

conn <- dbi_connect(context)

stmt1 <- dbi_statement(conn, "SELECT 42")
dbi_tbl(stmt1)
as.data.frame(dbi_tbl(stmt1))
tibble::as_tibble(dbi_tbl(stmt1))
dplyr::collect(dbi_tbl(stmt1))
