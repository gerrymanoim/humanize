
<!-- README.md is generated from README.Rmd. Please edit that file -->
humanize
========

[![Travis-CI Build Status](https://travis-ci.org/newtux/humanize.svg?branch=master)](https://travis-ci.org/newtux/humanize) [![CRAN\_Status\_Badge](http://www.r-pkg.org/badges/version/humanize)](https://cran.r-project.org/package=humanize)

Humanize is an almost direct port of the python [humanize package](https://github.com/jmoiron/humanize).

The goal of humanize is to provide some utlities in order to turn values (so far times, file sizes, and numbers) into human readable forms.

Installation
------------

You can install the latest CRAN version with:

``` r
install.packages("humanize")
```

You can install humanize from github with:

``` r
# install.packages("devtools")
devtools::install_github("newtux/humanize")
```

Examples
--------

### Times

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

### File Sizes

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

### Numbers

Ordinals:

``` r
count_as_ordinal(1)
#> [1] "1st"
count_as_ordinal(111)
#> [1] "111th"
```

Comma Seperation:

``` r
number_as_comma(1000)
#> [1] "1,000"
number_as_comma(10000)
#> [1] "10,000"
```

Words:

``` r
count_as_word(100)
#> [1] "100"
count_as_word(1000000)
#> [1] "1.0 million"
count_as_word(1200000000)
#> [1] "1.2 billion"
```

AP Format:

``` r
count_as_ap(3)
#> [1] "three"
count_as_ap(20)
#> [1] "20"
```

Todo
----

This is still a very early cut of the package.

-   Better support in times? For diff time?
-   Maybe add times relative to other times?
-   Export helper functions used in tests?
