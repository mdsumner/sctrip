context("basic")

test_that("multiplication works", {
  expect_that(sc_path(aurora, LONGITUDE_DEGEAST, LATITUDE_DEGNORTH, DATE_TIME_UTC), is_a("PATH"))
  expect_that(sc::PRIMITIVE(sc_path(aurora, LONGITUDE_DEGEAST, LATITUDE_DEGNORTH, DATE_TIME_UTC)), is_a("sc"))
})
