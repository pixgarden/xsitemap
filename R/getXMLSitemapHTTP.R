#' getXMLSitemapHTTP
#'
#' Check if xml sitemap urls send a 200 http code
#'
#' @param sitemap dataframe
#' @param user_agent User agent string to http request
#'
#' @return dataframe
#' @export
#'
#' @examples
getXMLSitemapHTTP <- function(sitemap, user_agent) {
  message(paste("getXMLSitemapHTTP :", nrow(sitemap), " URL(s) to check"))

  if (missing(user_agent)) {
    user_agent <-
      "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/67.0.3396.99 Safari/537.36"
  }

  sitemap["http"] <- NA

  for (i in 1:nrow(sitemap)) {
    #progress.bar = TRUE
    cat(".")
    request <- HEAD(sitemap[i,]$loc, user_agent(user_agent))
    sitemap[i,]$http <- request$status_code
  }
  return(sitemap)
}
