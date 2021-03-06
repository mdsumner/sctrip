#' sctrip.
#'
#' @name sctrip
#' @docType package
NULL


##' Voyage track data from the Aurora Australis
##'
##' This is a sample of the "Aurora Australis Voyage 3 2012/13 Track and Underway Data".
##' @name aurora
##' @docType data
##' @title Aurora Australis voyage track
##' @format \code{aurora} A data frame with 3 columns.  The columns
##' represent
##' \tabular{rl}{
##' \code{LONGITUDE_DEGEAST} \tab Longitude values \cr
##' \code{LATITUDE_DEGNORTH} \tab Latitude values \cr
##' \code{DATE_TIME_UTC} \tab Date-time values (POSIXct) \cr
##' }
##' @references
##' \url{http://gcmd.nasa.gov/KeywordSearch/Metadata.do?Portal=amd_au&MetadataView=Full&MetadataType=0&KeywordPath=&OrigMetadataNode=AADC&EntryId=201213030}
##' @examples
##' \dontrun{
##' ## These data were obtained like this
##' base <- "http://gcmd.gsfc.nasa.gov/KeywordSearch/RedirectAction.do?target"
##' b1 <-   "=F4t70bSf87FLsT1TNxR9TSPS74xbHAdheLQcH5Z5PMmgzJ9t%2Bi%2FEs1e8Fl61"
##' b2 <-   "MPhKjo9qxb2f9wyA%0D%0AoE1kjJ8AMcpFlMMRH7Z6umgNLsGMnWPeQdU7mZHMp%2"
##' b3 <-   "FtqMpahIrde%2F%2B9%2FZWAkIFrh2bhIiNfl4I9J%0D%0A5KBX9g5Wf7I9JdOgqY"
##' b4 <-   "bDdpj0iM1K%2BA%3D%3D"
##' aurora2013 <- read.csv(paste(base, b1, b2, b3, b4, collapse = ""), stringsAsFactors = FALSE)
##' aurora2013$DATE_TIME_UTC <- as.POSIXct(aurora2013$DATE_TIME_UTC, tz = "GMT")
##' ## get a daily sample
##' aurora <- aurora2013[,c("LONGITUDE_DEGEAST", "LATITUDE_DEGNORTH", "DATE_TIME_UTC")]
##' aurora <- aurora[!duplicated(format( aurora$DATE_TIME_UTC, "%Y-%j")), ]
##' aurora <- aurora[order(aurora$DATE_TIME_UTC), ]
##' save(aurora, file = "aurora.rda")
##' }
##' @keywords data
NULL
