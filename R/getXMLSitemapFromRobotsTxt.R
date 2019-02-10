#' getXMLSitemapFromRobotsTxt
#' ceci est un description tres partiel
#' @param urltocheck hostname string of the website you want to find xml sitemap from robots
#' @param user_agent user agent string to http request
#'
#' @return string
#' @export
#'
getXMLSitemapFromRobotsTxt <- function(urltocheck, user_agent) {

  if (missing(user_agent)) {
    user_agent <-
      "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/67.0.3396.99 Safari/537.36"
  }

  if ("/robots.txt" != substr(urltocheck, nchar(urltocheck) - 10, nchar(urltocheck))) {
    urltocheck <- paste0(urltocheck, "robots.txt")
  }


  request <- httr::GET(urltocheck, user_agent(user_agent))
  if (request$status_code == 200) {
    robotstext <- httr::content(request)

    if (stringr::str_detect(robotstext, "\nSitemap:")) {
      message("XML sitemap url detect inside robots.txt")
      #library(stringr)
      xml_url <- stringr::str_match(robotstext, "Sitemap: (.*)(\\n|$)")[, 2]
      message(xml_url)
      return(paste0("", xml_url))

    } else{
      message("No XML sitemap url inside robots.txt")
      return("")
    }
  } else{
    message("no robots.txt")
    return("")
  }
}
