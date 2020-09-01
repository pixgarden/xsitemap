#' xsitemapTokenize
#'
#' check keywords inside urls
#' @param domain domain name string
#'
#' @return table
#' @export
#'
xsitemapTokenize <- function(sitemap) {
  message(paste("xsitemapKeyworksFromUrl :", nrow(sitemap), " URL(s) to parse"))


  sitemap$path <- urltools::path(sitemap$loc)
  
  url_and_words <- tidytext::unnest_tokens(sitemap, words, path)
  
  bagOfWords <- table(words)
  message(paste("bagOfWords :",nrow(bagOfWords)," word(s)"))
  return(bagOfWords)
}
