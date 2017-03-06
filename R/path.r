#' Build a PATH from a raw data table.
#'
#' Nominated columns will be used to find unique coordinates. All other columns belong on
#' the path-link-vertex data. Currently this is to find a single path from a table of data.
#' In future there will be methods for grouped data frames, and for other ways of declaring
#' groupings at the path and object level.
#' @param x input data
#' @param ... columns that are nominated as vertex coordinates
#' @param .group group
#' @param path_cols path columns
#' @return `sc::PATH`
#' @export
#' @importFrom tibble as_tibble tibble
#importFrom sc sc_trip
#' @examples
#' data("Seatbelts", package= "datasets")
#' apath <- sc_trip(as.data.frame(Seatbelts), front, rear, kms)
#' sc::PRIMITIVE(apath)
#' sc_trip(aurora) ## we can have pure topology
#' aurora$id <- 1:nrow(aurora)
#' aurora$g <- aurora$id %/% 7
#' ## or more usually, nominate the geometric space in which the path turns
#' ## everything else is kept on a link table to the path entities
#' sc_trip(aurora, LONGITUDE_DEGEAST, LATITUDE_DEGNORTH, DATE_TIME_UTC)
#' sc::PRIMITIVE(sc_trip(aurora, LONGITUDE_DEGEAST, LATITUDE_DEGNORTH, DATE_TIME_UTC))
#' @name sc_trip
sc_trip.data.frame <- function(x, ..., .group = NULL) {
  path_cols <- unname(dplyr::select_vars(colnames(x), ...))
  #if (!is.null(.group)) .group <- unname(dplyr::select_vars(colnames(x), .group))
  print(path_cols)
  sc_trip_(x, path_cols, .group)
}
#' Create a trip the sc way
#' @export
#' @name sc_trip
sc_trip <- function(x, ..., .group = NULL) {
  UseMethod("sc_trip")
}
#' @export
#' @name sc_trip
sc_trip_ <- function(x, path_cols = character(), .group = NULL) {
  UseMethod("sc_trip_")
}
#' @export
#' @name sc_trip
sc_trip_.data.frame <- function(x, path_cols = character(), .group = NULL) {
  k_cols <- setdiff(names(x), path_cols)
  sc_trip_impl(tibble::as_tibble(x), path_cols, k_cols, .group = .group)
}
#' @export
#' @name sc_trip
sc_trip_.tbl_sqlite <- function(x, path_cols = character(), .group = NULL) {
  sc_trip_(dplyr::collect(x), path_cols)
}
paste_ <- function(...) paste(..., sep = "_")
#' @importFrom sc sc_rand
sc_trip_impl <- function(x, path_cols, k_cols, .group = NULL) {
  x[["vertex_"]] <-  as.integer(factor(do.call(paste_, x)))
  n_u <- length(unique(x[["vertex_"]]))
  x[["vertex_"]] <-  sc::sc_rand(n_u)[x[["vertex_"]]]
  v <- dplyr::select_(x, .dots = c(path_cols, "vertex_"))
  bXv <- dplyr::select_(x, .dots = c(k_cols, "vertex_"))
  if (!is.null(.group)) {
    groups <- bXv[[.group]]
    ngroups <- length(unique(groups))
  } else {
    groups <- rep(1, nrow(bXv))
    ngroups <- 1L
  }

  pth <- tibble::tibble(path_ = sc::sc_rand(ngroups), object_ = sc::sc_rand(ngroups))
  bXv[["path_"]] <- pth[["path_"]][factor(groups)]

  structure(list(vertex = dplyr::distinct_(v, "vertex_", .keep_all = TRUE),
                 path_link_vertex = bXv,
                 path = pth,
                 object = pth["object_"]),

            class = c("PATH", "sc"))
}
# trip from a PATH
#'examples
#'# data('example', package ="moveHMM")
#'#
#'# library(tibble)
#'# d <- as_tibble(example$data)
#'# d$step[is.na(d$step)] <- 0
#'# d <- d[!duplicated(d), ]
#'# d$step <- trip::adjust.duplicateTimes(cumsum(d$step), d$ID)
#'# tr <- trip.PATH(sc_trip(d, x, y, step, .group = "ID"))
#'# plot(tr)
#'# lines(tr, col = viridis::viridis(length(unique(d$ID))), lwd = 4)
#'# aurora$ID <- 1
#'# tr <- trip.PATH(sc_trip(aurora, LONGITUDE_DEGEAST, LATITUDE_DEGNORTH, DATE_TIME_UTC, .group = "ID"))
#'# plot(tr)
#'# lines(tr, col = viridis::viridis(length(unique(d$ID))), lwd = 4)
#'importFrom dplyr inner_join
#'importFrom sp coordinates<-
# trip.PATH <- function(x) {
#   tor <- setdiff(names(x$vertex), "vertex_")
#
#   d <- x$vertex %>% dplyr::inner_join(x$path_link_vertex) %>% dplyr::inner_join(x$path) %>% inner_join(x$object)
#
#   coordinates(d) <- tor[1:2]
#   epoch <- if(inherits(d[[tor[3]]], "POSIXt")) 0 else ISOdatetime(1970, 1, 1, 0, 0, 0, tz = "GMT")
#   d[[tor[3]]] <- epoch + d[[tor[3]]]
#   trip::trip(d, c(tor[3], "path_"))
# }
