library("dbi3")

context <- dbi_classic(duckdb::duckdb())

conn <- dbi_connect(context)

stmt1 <- dbi_statement(conn, "SELECT 42")

dbi_capabilities(conn, "dbi_tbl_format")
#> [1] "arrow"      "data.frame" "tibble"     "tbl_sql"

dbi_capabilities(conn, "dbi_tbl_format", "arrow")
#> [1] TRUE

# Arrow dataset
dbi_tbl(stmt1, format = "arrow")

# data.frame
dbi_tbl(stmt1, format = "data.frame")

# tibble
dbi_tbl(stmt1, format = "tibble")

# tbl_sql
dbi_tbl(stmt1, format = "tbl_sql")
