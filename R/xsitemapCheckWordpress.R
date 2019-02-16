#' xsitemapCheckWordpress
#'
#' check classic wordpress urls http code and return it inside the original data frame
#' @param domain domain name string
#'
#' @return data frame
#' @export
#'
xsitemapCheckWordpress <- function(domain) {

  wordpress_paths <-
    c("catalog_entries-sitemap.xml",
      "category-sitemap.xml",
      "dt_catalog-sitemap.xml",
      "dt_portfolios-sitemap.xml",
      "ngg_tag-sitemap.xml",
      "page-sitemap.xml",
      "portfolio_entries-sitemap.xml",
      "post-sitemap.xml",
      "post_tag-sitemap.xml",
      "product-sitemap.xml",
      "product_cat-sitemap.xml",
      "product_shipping_class-sitemap.xml",
      "product_tag-sitemap.xml"
    )

  urls <- data.frame(
    loc = paste0(domain,wordpress_paths),
    stringsAsFactors = FALSE
  )
  xsitemapCheckHTTP(urls)

}
