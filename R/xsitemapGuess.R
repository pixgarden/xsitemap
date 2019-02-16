#' Title xsitemapGuess
#'
#'surement la description la plus courte du monde
#' ????
#'
#' ??
#' @param urltocheck hostname string of the website you want to guess xml sitemap url
#'
#' @return dataframe
#' @export
#'
xsitemapGuess <- function(urltocheck) {
  message("Guessing for XML Sitemap URL...")
  test_paths <-
    c(
      "sitemap_index.xml",
      "sitemaps.xml",
      "sitemap.xml",
      "sitemap-index.xml",
      "sitemap.xml.gz"
    )


  if ("/" != substr(urltocheck, nchar(urltocheck),  nchar(urltocheck))) {
    urltocheck <- paste0(urltocheck, "/")

  }

  user_agent <-
    "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/67.0.3396.99 Safari/537.36"

  for (paths in test_paths) {
    cat(paths)
    request <-
      httr::GET(paste0(urltocheck, paths), user_agent(user_agent))
    if (request$status_code == 200) {
      message(" OK")
      return (paste0(urltocheck, paths))
    } else{
      message(" KO")
    }

  }

}
