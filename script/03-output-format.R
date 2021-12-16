library("dbi3")

context <- dbi_classic(duckdb::duckdb())

conn <- dbi_connect(context)

qry <- dbi_query(conn, "SELECT 42")

dbi_capabilities(conn, "tbl_format")
#> [1] "arrow"      "data.frame" "tibble"     "tbl_sql"    "parquet"

dbi_capabilities(conn, "tbl_format", "arrow")
#> [1] TRUE

# Arrow dataset
dbi_tbl(qry, format = "arrow")

# data.frame
dbi_tbl(qry, format = "data.frame")

# tibble
dbi_tbl(qry, format = "tibble")

# tbl_sql
dbi_tbl(qry, format = "tbl_sql")

# tbl_sql
dbi_tbl(qry, format = "parquet", path = "out.parquet", partitioning = ...)
