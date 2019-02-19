context("test-all.R context")

library(testthat)
library(xsitemap)

#test_check("xsitemap")

test_that("Search for example.com XML sitemap", {
  expect_equal(xsitemapGet("http://www.example.com"), FALSE)
})
