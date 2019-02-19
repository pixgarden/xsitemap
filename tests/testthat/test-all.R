context("test-all.R context")

library(testthat)
library(xsitemap)

#test_check("xsitemap")

test_that("Search for example.com XML sitemap", {
  expect_equal(xsitemapGet("http://www.example.com"), FALSE)
})

test_that("Search for www.sitemaps.org XML sitemap", {
  expect_equal(class(xsitemapGet("https://www.sitemaps.org")), "data.frame")
})
