#' Convert trip to common form.
#'
#' @param x trip object
#' @examples
#' library(trip)
#' sc_object(walrus818)
#' sc_coord(walrus818)
#' sc_path(walrus818)
#'
#' ## now we have segments
#' PATH(walrus818) %>% PRIMITIVE()
#' @export
#' @importFrom tibble tibble
#' @importFrom trip getTORnames
#' @importFrom dplyr distinct_
sc_object.trip <- function(x, ...) {
  tor <- trip::getTORnames(x)
  #cnames <- sp::coordnames(x)
  d <- dplyr::distinct_(as.data.frame(x), tor[2L])
  d[["object_"]] <- sc_rand(nrow(d))
  d
}

#' @export
#' @importFrom sp coordinates
sc_coord.trip <- function(x, ...) {
  d <- tibble::as_tibble(sp::coordinates(x))
  tor <- trip::getTORnames(x)
  d[[tor[1L]]] <- x[[tor[1L]]]
  ## everything is a vertex here
  ## we need to keep them all but add extra info

  as.data.frame(x)
}

#' @export
#' @importFrom dplyr %>% group_by_ mutate summarize
sc_path.trip <- function(x, ...) {
  d <- as.data.frame(x) %>% group_by_(trip::getTORnames(x)[2L]) %>% dplyr::summarize(ncoords_ = n())
  d[["path_"]] = sc_rand(nrow(d))
  d
}
