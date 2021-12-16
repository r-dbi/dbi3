library("dbi3")

context <- dbi_classic(duckdb::duckdb())

conn <- dbi_connect(context)

# ## DBI, or dbi3 without streaming
#
# - receive SQL
# - send SQL to database
# - fetch results in a loop (up to `n` records)
# - return results to caller

# ## dbi3 with partitioned streaming
#
# - receive SQL, partitioning
#     - requirement: results are sorted by partitioning
# - send SQL to database, receive callback function
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
# immediate return, nothing happens on the database

callback <- function(data) {
  print(data$a)
}

promise <- dbi_send_query(qry, callback)
# query is sent to the database (if possible: async, non-blocking)

promises::promise_all(promise)
#> [1] 42
