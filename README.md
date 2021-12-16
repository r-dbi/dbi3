
# dbi3

<!-- badges: start -->
[![Lifecycle: experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![CRAN status](https://www.r-pkg.org/badges/version/dbi3)](https://CRAN.R-project.org/package=dbi3)
<!-- badges: end -->

The goal of this repository is to design a new database interface from scratch, based on the lessons learned from DBI and the previous R Consortium projects.
The interface provides compatibility to DBI in both directions: the new interface supports existing DBI backends (possibly with degraded performance), and backends implemented against the new interface automatically support DBI.
Backends for the new interface will be easier to implement, because they can use the full feature set provided by dbi3.

In the beginning, the issue tracker will be used to collect and categorize issues that did not fit the scope of {DBI} or related packages.
Eventually, the repository will contain a working package and a design document.

## Properties

- async-first
    - required for efficient web applications: Shiny and Plumber
    - simpler to implement a synchronous interface from an async interface than the other way round
- only pure functions/methods with callbacks
    - idiomatic to R
- agnostic to query language
    - concepts: context, connection, query objects, tables, query strings, parameters
- reference implementation: generic backend for DBI classic
