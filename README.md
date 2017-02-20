
<!-- README.md is generated from README.Rmd. Please edit that file -->
[![Travis-CI Build Status](https://travis-ci.org/mdsumner/sctrip.svg?branch=master)](https://travis-ci.org/mdsumner/sctrip) [![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/mdsumner/sctrip?branch=master&svg=true)](https://ci.appveyor.com/project/mdsumner/sctrip)

sctrip
======

The goal of sctrip is to reboot the trip package on a firmer basis.

It's not very functional yet, but the goal is to create normal-form PATH objects that fit within a very general framework for structured data. PATHs aren't that useful in normal-form, but converting from external path-forms to PRIMITIVE forms and back is **very useful**. More soon.

Installation
------------

You can install sctrip from github with:

``` r
# install.packages("devtools")
devtools::install_github("mdsumner/sctrip")
```

Example
-------

This is a basic example which shows you how to solve a common problem:

``` r
library(sctrip)
#> Loading required package: sc
apath <- sc_path(aurora, LONGITUDE_DEGEAST, LATITUDE_DEGNORTH, DATE_TIME_UTC)
#> [1] "LONGITUDE_DEGEAST" "LATITUDE_DEGNORTH" "DATE_TIME_UTC"
```

The PATH object can be converted to PRIMITIVE form:

``` r
sc::PRIMITIVE(apath)
#> $vertex
#> # A tibble: 44 × 4
#>    LONGITUDE_DEGEAST LATITUDE_DEGNORTH DATE_TIME_UTC  vertex_
#>                <dbl>             <dbl>        <dttm>    <chr>
#> 1           147.3809         -42.97238    2013-01-09 a722b197
#> 2           147.3793         -42.97435    2013-01-10 26833255
#> 3           147.3787         -42.97458    2013-01-11 811bf5f5
#> 4           147.3716         -42.98615    2013-01-12 a6e4d2bc
#> 5           143.2391         -43.78417    2013-01-13 76ba3903
#> 6           141.6630         -43.79907    2013-01-14 b53571e7
#> 7           134.1367         -44.94408    2013-01-15 e121c823
#> 8           130.5645         -47.92685    2013-01-16 cd5f8485
#> 9           125.0200         -51.82263    2013-01-17 cc522655
#> 10          120.3218         -54.50187    2013-01-18 56f44a0f
#> # ... with 34 more rows
#> 
#> $path_link_vertex
#> # A tibble: 44 × 2
#>     vertex_    path_
#> *     <chr>    <chr>
#> 1  a722b197 96ef1d86
#> 2  26833255 96ef1d86
#> 3  811bf5f5 96ef1d86
#> 4  a6e4d2bc 96ef1d86
#> 5  76ba3903 96ef1d86
#> 6  b53571e7 96ef1d86
#> 7  e121c823 96ef1d86
#> 8  cd5f8485 96ef1d86
#> 9  cc522655 96ef1d86
#> 10 56f44a0f 96ef1d86
#> # ... with 34 more rows
#> 
#> $path
#> # A tibble: 1 × 2
#>      path_  object_
#>      <chr>    <chr>
#> 1 96ef1d86 6206cf1e
#> 
#> $object
#> # A tibble: 1 × 1
#>    object_
#>      <chr>
#> 1 6206cf1e
#> 
#> $segment
#> # A tibble: 43 × 4
#>    .vertex0 .vertex1    path_ segment_
#>       <chr>    <chr>    <chr>    <chr>
#> 1  a722b197 26833255 96ef1d86 fa598aaa
#> 2  26833255 811bf5f5 96ef1d86 cafaa9ec
#> 3  811bf5f5 a6e4d2bc 96ef1d86 32e70d90
#> 4  a6e4d2bc 76ba3903 96ef1d86 fcbea8b6
#> 5  76ba3903 b53571e7 96ef1d86 7ee3017a
#> 6  b53571e7 e121c823 96ef1d86 85e48c58
#> 7  e121c823 cd5f8485 96ef1d86 0a33414b
#> 8  cd5f8485 cc522655 96ef1d86 61162cf2
#> 9  cc522655 56f44a0f 96ef1d86 74ee6786
#> 10 56f44a0f 5356087d 96ef1d86 2b7fb16e
#> # ... with 33 more rows
#> 
#> attr(,"class")
#> [1] "PATH" "sc"
```

We can do that no matter what choice we made when nominating the vertex columns.

``` r
sc::PRIMITIVE(sc_path(aurora, DATE_TIME_UTC, LATITUDE_DEGNORTH))
#> [1] "DATE_TIME_UTC"     "LATITUDE_DEGNORTH"
#> $vertex
#> # A tibble: 44 × 3
#>    DATE_TIME_UTC LATITUDE_DEGNORTH  vertex_
#>           <dttm>             <dbl>    <chr>
#> 1     2013-01-09         -42.97238 3243457b
#> 2     2013-01-10         -42.97435 c587dbdf
#> 3     2013-01-11         -42.97458 493da75d
#> 4     2013-01-12         -42.98615 d3a55d5c
#> 5     2013-01-13         -43.78417 6e8fcf0f
#> 6     2013-01-14         -43.79907 35eb98aa
#> 7     2013-01-15         -44.94408 193849aa
#> 8     2013-01-16         -47.92685 c3bd4271
#> 9     2013-01-17         -51.82263 be5cf83a
#> 10    2013-01-18         -54.50187 10cb007e
#> # ... with 34 more rows
#> 
#> $path_link_vertex
#> # A tibble: 44 × 3
#>    LONGITUDE_DEGEAST  vertex_    path_
#> *              <dbl>    <chr>    <chr>
#> 1           147.3809 3243457b 6efe4cb5
#> 2           147.3793 c587dbdf 6efe4cb5
#> 3           147.3787 493da75d 6efe4cb5
#> 4           147.3716 d3a55d5c 6efe4cb5
#> 5           143.2391 6e8fcf0f 6efe4cb5
#> 6           141.6630 35eb98aa 6efe4cb5
#> 7           134.1367 193849aa 6efe4cb5
#> 8           130.5645 c3bd4271 6efe4cb5
#> 9           125.0200 be5cf83a 6efe4cb5
#> 10          120.3218 10cb007e 6efe4cb5
#> # ... with 34 more rows
#> 
#> $path
#> # A tibble: 1 × 2
#>      path_  object_
#>      <chr>    <chr>
#> 1 6efe4cb5 a3177245
#> 
#> $object
#> # A tibble: 1 × 1
#>    object_
#>      <chr>
#> 1 a3177245
#> 
#> $segment
#> # A tibble: 43 × 4
#>    .vertex0 .vertex1    path_ segment_
#>       <chr>    <chr>    <chr>    <chr>
#> 1  3243457b c587dbdf 6efe4cb5 f01c40e4
#> 2  c587dbdf 493da75d 6efe4cb5 16e9c096
#> 3  493da75d d3a55d5c 6efe4cb5 87c05b1e
#> 4  d3a55d5c 6e8fcf0f 6efe4cb5 744cc4f6
#> 5  6e8fcf0f 35eb98aa 6efe4cb5 47a9ba5d
#> 6  35eb98aa 193849aa 6efe4cb5 017172c8
#> 7  193849aa c3bd4271 6efe4cb5 16fe887b
#> 8  c3bd4271 be5cf83a 6efe4cb5 d0858434
#> 9  be5cf83a 10cb007e 6efe4cb5 f81aef62
#> 10 10cb007e 9521065d 6efe4cb5 ec4c0c68
#> # ... with 33 more rows
#> 
#> attr(,"class")
#> [1] "PATH" "sc"
```
