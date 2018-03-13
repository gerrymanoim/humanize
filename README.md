
<!-- README.md is generated from README.Rmd. Please edit that file -->
humanize
========

[![Travis-CI Build Status](https://travis-ci.org/newtux/humanize.svg?branch=master)](https://travis-ci.org/newtux/humanize)

Humanize is an almost direct port of the python [humanize package](https://github.com/jmoiron/humanize).

The goal of humanize is to provide some utlities in order to turn values (so far times and file sizes) into human readable forms

Installation
------------

You can install humanize from github with:

``` r
# install.packages("devtools")
devtools::install_github("newtux/humanize")
```

Examples
--------

Convert times:

``` r
library(humanize)

natural_time(Sys.time())
#> [1] "now"
natural_time(Sys.time() - 1)
#> [1] "a second ago"
natural_time(Sys.time() - 100)
#> [1] "a minute ago"
natural_time(Sys.time() - 1000*10)
#> [1] "2 hours ago"
```

Works across days:

``` r
natural_time(Sys.time() - lubridate::ddays(1))
#> [1] "a day ago"
natural_time(Sys.time() - lubridate::ddays(70))
#> [1] "2 months ago"
```

And forward in time:

``` r
natural_time(Sys.time() + lubridate::ddays(1))
#> [1] "23 hours from now"
```

Convert file sizes:

``` r
natural_size(300)
#> 300 Bytes
natural_size(3000)
#> 3.0 kB
natural_size(3000000)
#> 3.0 MB
natural_size(3000000000)
#> 3.0 GB
natural_size(3000000000000)
#> 3.0 TB
natural_size(10**26 * 30)
#> 3000.0 YB
```

Todo
----

This is still a very early cut of the package.

-   Better support in times? For diff time?
-   Maybe add times relative to other times?
-   Export helper functions used in tests?
-   Port over the numbers code
