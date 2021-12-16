library("dbi3")

context <- dbi_classic(duckdb::duckdb())

conn <- dbi_connect(context)

# ## DBI, or dbi3 without streaming
#
# - receive SQL
# - send SQL to database
# - result column names and types are available at the client
# - fetch results in a loop (up to `n` records)
# - return results to caller

# ## dbi3 with partitioned streaming
#
# - receive SQL, partitioning/chunking
#     - requirement for partitioning: SQL includes `ORDER BY partitioning`
# - send SQL to database, receive callback function
#     - callback for column names and types (called once)
#     - callback for data (called multiple times)
# - fetch results in a loop
#     - callback when partition is complete

# ## dbi3 with streaming
#
# - receive SQL
# - send SQL to database
# - return streamable object
#     - arrow?
#     - how to consume?
#     - how to implement?
# - client retrieves results

qry <- dbi_query(conn, "SELECT 42 AS a", partition = ...)
# qry <- dbi_query(conn, "SELECT 42 AS a", chunk_size = ...)
# immediate return, nothing happens on the database

callback <- function(data) {
  print(data$a)
}

promise <- dbi_send_query_callback(qry, callback)
# query is sent to the database (if possible: async, non-blocking)

promises::promise_all(promise)
#> [1] 42

# with advance notification of output schema:

promise <- dbi_send_query_callback(qry, callback, notify_schema = TRUE)
# query is sent to the database (if possible: async, non-blocking)

promises::promise_all(promise)
#> integer(0)
#> [1] 42

# Simpler interface, provided by dbi3:

result <- dbi_send_query(qry)
# query is sent to the database

while (!dbi_has_completed(result)) {
  print(result$a)
  result <- dbi_fetch(result)
}
#> [1] 42
