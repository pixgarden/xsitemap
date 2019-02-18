#' xsitemapCheckHTTP
#'
#' Check if xml sitemap urls send a 200 http code
#'
#' @param sitemap dataframe
#'
#' @return dataframe
#' @export
#'
xsitemapCheckHTTP <- function(sitemap) {
  message(paste("xsitemapCheckHTTP :", nrow(sitemap), " URL(s) to check"))
  if (nrow(sitemap) > 1000) {
    if (!askYesNo(
      paste("Are you sure you want to crawl", nrow(sitemap), "URLs?"),
      default = TRUE,
      prompts = getOption("askYesNo", gettext(c(
        "Yes", "No", "Cancel"
      )))
    )) {
      return(NULL)
    }
  }
  user_agent <-
    "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/67.0.3396.99 Safari/537.36"

  sitemap["http"] <- NA

  for (i in 1:nrow(sitemap)) {
    #progress.bar = TRUE
    cat(".")
    request <-
      HEAD(sitemap[i,]$loc,
           user_agent(user_agent),
           config(followlocation = 0))
    sitemap[i,]$http <- request$status_code
  }
  return(sitemap)
}
