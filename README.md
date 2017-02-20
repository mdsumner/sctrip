
<!-- README.md is generated from README.Rmd. Please edit that file -->
[![Travis-CI Build Status](https://travis-ci.org/mdsumner/sctrip.svg?branch=master)](https://travis-ci.org/mdsumner/sctrip) [![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/mdsumner/sctrip?branch=master&svg=true)](https://ci.appveyor.com/project/mdsumner/sctrip)

sctrip
======

The goal of sctrip is to ... reboot the trip package on a firmer basis.

It's not very functional yet, but the goal is to create normal-form PATH objects that fit within a very general framework for structured data. PATHs aren't that useful, but converting from external path-forms to PRIMITIVE forms and back is very useful. More soon.

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
#> 1           147.3809         -42.97238    2013-01-09 8e5c57a8
#> 2           147.3793         -42.97435    2013-01-10 99a77b28
#> 3           147.3787         -42.97458    2013-01-11 0538f3f2
#> 4           147.3716         -42.98615    2013-01-12 d4d6c479
#> 5           143.2391         -43.78417    2013-01-13 8d070be4
#> 6           141.6630         -43.79907    2013-01-14 e933542b
#> 7           134.1367         -44.94408    2013-01-15 e5685ab5
#> 8           130.5645         -47.92685    2013-01-16 f6367a5c
#> 9           125.0200         -51.82263    2013-01-17 4d7605b9
#> 10          120.3218         -54.50187    2013-01-18 4300f66d
#> # ... with 34 more rows
#> 
#> $path_link_vertex
#> # A tibble: 44 × 2
#>     vertex_    path_
#> *     <chr>    <chr>
#> 1  8e5c57a8 911db79a
#> 2  99a77b28 911db79a
#> 3  0538f3f2 911db79a
#> 4  d4d6c479 911db79a
#> 5  8d070be4 911db79a
#> 6  e933542b 911db79a
#> 7  e5685ab5 911db79a
#> 8  f6367a5c 911db79a
#> 9  4d7605b9 911db79a
#> 10 4300f66d 911db79a
#> # ... with 34 more rows
#> 
#> $path
#> # A tibble: 1 × 2
#>      path_  object_
#>      <chr>    <chr>
#> 1 911db79a 58cac49a
#> 
#> $object
#> # A tibble: 1 × 1
#>    object_
#>      <chr>
#> 1 58cac49a
#> 
#> $segment
#> # A tibble: 43 × 4
#>    .vertex0 .vertex1    path_ segment_
#>       <chr>    <chr>    <chr>    <chr>
#> 1  8e5c57a8 99a77b28 911db79a 20a816a6
#> 2  99a77b28 0538f3f2 911db79a faadb3a7
#> 3  0538f3f2 d4d6c479 911db79a a909e1f1
#> 4  d4d6c479 8d070be4 911db79a 75a82c6d
#> 5  8d070be4 e933542b 911db79a 837d8af3
#> 6  e933542b e5685ab5 911db79a 013c8aef
#> 7  e5685ab5 f6367a5c 911db79a 4dabceea
#> 8  f6367a5c 4d7605b9 911db79a adcea4b2
#> 9  4d7605b9 4300f66d 911db79a 065e9815
#> 10 4300f66d bb72d01f 911db79a 0cd21bb7
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
#> 1     2013-01-09         -42.97238 f067f684
#> 2     2013-01-10         -42.97435 a77ef2b5
#> 3     2013-01-11         -42.97458 c36b595d
#> 4     2013-01-12         -42.98615 af7d6827
#> 5     2013-01-13         -43.78417 577ac0eb
#> 6     2013-01-14         -43.79907 c5d44800
#> 7     2013-01-15         -44.94408 147902b2
#> 8     2013-01-16         -47.92685 aae1000b
#> 9     2013-01-17         -51.82263 488905fa
#> 10    2013-01-18         -54.50187 c9124fdd
#> # ... with 34 more rows
#> 
#> $path_link_vertex
#> # A tibble: 44 × 3
#>    LONGITUDE_DEGEAST  vertex_    path_
#> *              <dbl>    <chr>    <chr>
#> 1           147.3809 f067f684 fa6f3d3d
#> 2           147.3793 a77ef2b5 fa6f3d3d
#> 3           147.3787 c36b595d fa6f3d3d
#> 4           147.3716 af7d6827 fa6f3d3d
#> 5           143.2391 577ac0eb fa6f3d3d
#> 6           141.6630 c5d44800 fa6f3d3d
#> 7           134.1367 147902b2 fa6f3d3d
#> 8           130.5645 aae1000b fa6f3d3d
#> 9           125.0200 488905fa fa6f3d3d
#> 10          120.3218 c9124fdd fa6f3d3d
#> # ... with 34 more rows
#> 
#> $path
#> # A tibble: 1 × 2
#>      path_  object_
#>      <chr>    <chr>
#> 1 fa6f3d3d f73a80fc
#> 
#> $object
#> # A tibble: 1 × 1
#>    object_
#>      <chr>
#> 1 f73a80fc
#> 
#> $segment
#> # A tibble: 43 × 4
#>    .vertex0 .vertex1    path_ segment_
#>       <chr>    <chr>    <chr>    <chr>
#> 1  f067f684 a77ef2b5 fa6f3d3d ab34b1f7
#> 2  a77ef2b5 c36b595d fa6f3d3d 18eef8c1
#> 3  c36b595d af7d6827 fa6f3d3d 72638b98
#> 4  af7d6827 577ac0eb fa6f3d3d 543753ba
#> 5  577ac0eb c5d44800 fa6f3d3d d7cc975a
#> 6  c5d44800 147902b2 fa6f3d3d c33ca997
#> 7  147902b2 aae1000b fa6f3d3d 41037d7d
#> 8  aae1000b 488905fa fa6f3d3d 8ed7dd6d
#> 9  488905fa c9124fdd fa6f3d3d 3477bc1c
#> 10 c9124fdd 01ca9305 fa6f3d3d 865d62fe
#> # ... with 33 more rows
#> 
#> attr(,"class")
#> [1] "PATH" "sc"
```
