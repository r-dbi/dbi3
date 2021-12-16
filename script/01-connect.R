library("dbi3")

# system specific
context <- dbi_classic(duckdb::duckdb())
# context <- duckdb::duckdb()
# context <- postgres::postgres(host="asdf", user="asdf", debug=a)

conn1 <- dbi_connect(context)
conn2 <- dbi_connect(context)

# disconnect on gc()
gc()
