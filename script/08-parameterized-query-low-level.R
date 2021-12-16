library("dbi3")

context <- dbi_classic(duckdb::duckdb())

conn <- dbi_connect(context)

# ## DBI, or dbi3 without streaming
#
# - receive SQL
# - receive parameters
# - send SQL to database
# - result column names and types are available at the client
# - fetch results in a loop (up to `n` records)
# - return results to caller

# ## dbi3 with partitioned streaming
#
# - receive SQL, partitioning/chunking
#     - requirement for partitioning: SQL includes `ORDER BY partitioning`
# - receive parameters
#     - separate step, to allow execution of the same query multiple times
# - send SQL to database, receive callback function
#     - callback for column names and types (called once)
#     - callback for data (called multiple times)
# - fetch results in a loop
#     - callback when partition is complete

qry <- dbi_query(conn, "SELECT ? AS a", params_schema = list(integer()), partition = ...)
# qry <- dbi_query(conn, "SELECT ? AS a", chunk_size = ...)
# immediate return, nothing happens on the database

dbi_query_state(qry)
#> "new"

prepared_qry <- dbi_prepare(qry, params = list(42L))

dbi_query_state(prepared_qry)
#> "prepared"

callback <- function(data) {
  print(data$a)
}

promise <- dbi_send_query_callback(prepared_qry, callback)
# query is sent to the database (if possible: async, non-blocking)

promises::promise_all(promise)
#> [1] 42

# with advance notification of output schema:

promise <- dbi_send_query_callback(prepared_qry, callback, notify_schema = TRUE)
# query is sent to the database (if possible: async, non-blocking)

promises::promise_all(promise)
#> integer(0)
#> [1] 42

# Simpler interface, provided by dbi3:

result <- dbi_send_query(qry, params = list(42L))
# result <- dbi_send_query(prepared_qry)
# query is sent to the database

while (!dbi_has_completed(result)) {
  print(result$a)
  result <- dbi_fetch(result)
}
#> [1] 42
