#' Build a PATH from a raw data table.
#'
#' Nominated columns will be used to find unique coordinates. All other columns belong on
#' the path-link-vertex data. Currently this is to find a single path from a table of data.
#' In future there will be methods for grouped data frames, and for other ways of declaring
#' groupings at the path and object level.
#' @param x input data
#' @param ... columns that are nominated as vertex coordinates
#'
#' @return `sc::PATH`
#' @export
#' @importFrom tibble as_tibble tibble
#' @importFrom sc sc_path
#' @name sc_path_
#' @examples
#' data("Seatbelts", package= "datasets")
#' apath <- sc_path(as.data.frame(Seatbelts), front, rear, kms)
#' sc::PRIMITIVE(apath)
#' sc_path(aurora) ## we can have pure topology
#' aurora$id <- 1:nrow(aurora)
#' aurora$g <- aurora$id %/% 7
#' ## or more usually, nominate the geometric space in which the path turns
#' ## everything else is kept on a link table to the path entities
#' sc_path(aurora, LONGITUDE_DEGEAST, LATITUDE_DEGNORTH, DATE_TIME_UTC)
#' sc::PRIMITIVE(sc_path(aurora, LONGITUDE_DEGEAST, LATITUDE_DEGNORTH, DATE_TIME_UTC))
sc_path.data.frame <- function(x, ...) {
  path_cols <- unname(dplyr::select_vars(colnames(x), ...))
  print(path_cols)
  sc_path_(x, path_cols)
}
#' @export
#' @name sc_path_
sc_path_ <- function(x, path_cols = character()) {
  UseMethod("sc_path_")
}
#' @export
#' @name sc_path_
sc_path_.data.frame <- function(x, path_cols = character()) {
  k_cols <- setdiff(names(x), path_cols)
  sc_path_impl(tibble::as_tibble(x), path_cols, k_cols)
}
#' @export
#' @name sc_path_
sc_path_.tbl_sqlite <- function(x, path_cols = character()) {
  sc_path_(dplyr::collect(x), path_cols)
}
paste_ <- function(...) paste(..., sep = "_")
sc_path_impl <- function(x, path_cols, k_cols) {
  x[["vertex_"]] <-  as.integer(factor(do.call(paste_, x)))
  n_u <- length(unique(x[["vertex_"]]))
  x[["vertex_"]] <-  sc::sc_rand(n_u)[x[["vertex_"]]]
  v <- dplyr::select_(x, .dots = c(path_cols, "vertex_"))
  bXv <- dplyr::select_(x, .dots = c(k_cols, "vertex_"))
  pth <- tibble::tibble(path_ = sc::sc_rand(1L), object_ = sc::sc_rand(1L))
  bXv[["path_"]] <- pth[["path_"]][[1L]]

  structure(list(vertex = dplyr::distinct_(v, "vertex_", .keep_all = TRUE),
                 path_link_vertex = bXv,
                 path = pth,
                 object = pth["object_"]),

            class = c("PATH", "sc"))
}
