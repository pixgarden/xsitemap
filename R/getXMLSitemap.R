#' getXMLSitemap
#'
#' @param urltocheck direct xml sitemap url or hostname string of the website you want to find xml sitemap from
#' @param user_agent User agent string to http request
#'
#' @return dataframe
#' @export
#'
getXMLSitemap <- function(urltocheck, user_agent) {
  if (missing(user_agent)) {
    user_agent <-
      "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/67.0.3396.99 Safari/537.36"
  }


  URL <- url_parse(urltocheck)


  if (is.na(URL$path) && !is.na(URL$domain)) {
    message("Searching for XML Sitemap URL...")


    # Reaching for robots.txt to find XML Sitemap

    xmlsitemap_from_robots <- getXMLSitemapFromRobotsTxt(urltocheck, user_agent)

    if (xmlsitemap_from_robots != "") {
      getXMLSitemap(xmlsitemap_from_robots)
    } else {
      xmlsitemap_from_guessing <- guessXMLSitemap(urltocheck, user_agent)
      if (!is.null(xmlsitemap_from_guessing)) {
        getXMLSitemap(xmlsitemap_from_guessing)

      } else{
        warning("Can't find xml sitemap url :(")
        return(FALSE)
      }
    }




  } else if (!is.na(URL$path)) {
    message(paste("Reaching for XML sitemap...", urltocheck))


    request <- GET(urltocheck, user_agent(user_agent))

    if(request$status_code != 200 && request$status_code != 301){
      warning(paste("xml sitemap is not accessible (HTTP:",request$status_code))
      return(NULL)
    }

    xml_doc <- xmlParse(request, encoding = "UTF-8")





    xml_data <- xmlToList(xml_doc)
    nb_children <- length(xml_data)
    #message(paste(" ", nb_children, " URL(s) found"))

    test_url <- lapply(xml_data, `[[`, 1)[1]
    #message(paste("test_url >", test_url))
    url_split <- strsplit(toString(test_url), "\\.")


    if ("xml" == mapply(`[`, url_split, lengths(url_split))) {
      if (nb_children < 50001) {
        message(paste(
          "sitemap index detected - ",
          nb_children,
          " sitemap url(s) found"
        ))

      } else{
        warning(paste("too many URLs - ",
                      nb_children,
                      " web page url(s) found"))
        return(NULL)

      }



      urls <- data.frame(
        loc = character(),
        lastmod = as.Date(character(), format = "%Y-%m-%d"),
        stringsAsFactors = FALSE
      )

      for (i in 1:nb_children) {
        individual_sitemap <-  xml_data[i]$sitemap$loc
        message(paste0("\n", i, " >>> ", individual_sitemap))
        new_urls <- getXMLSitemap(individual_sitemap)
        new_urls$origin <- url_parse(individual_sitemap)$path
        #new_urls$id <- i
        urls <- rbind(urls, new_urls)
      }
      return(urls)

    } else{
      # if (nb_children < 50000) {
      message(paste(
        "regular sitemap detected - ",
        nb_children,
        " web page url(s) found"
      ))
      #} else{
      #  warning(paste("too many URLs - ",
      #                nb_children,
      #                " web page url(s) found"))
      #  return(NULL)



      #urls <- vector(mode = "character", length = 0)

      urls <- data.frame(
        loc = character(),
        lastmod = as.Date(character(), format = "%Y-%m-%d"),
        stringsAsFactors = FALSE
      )


      for (i in 1:(nb_children - 1)) {
        cat(".")
        urls[i, ]$loc <- xml_data[i]$url$loc
        if (!is.null(xml_data[i]$url$lastmod)) {
          urls[i, ]$lastmod <- xml_data[i]$url$lastmod
        }
      }


      return(urls)
    }

  } else{
    stop("Mal formatted url")

    #return NA
  }

}
