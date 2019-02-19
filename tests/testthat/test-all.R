context("test-all.R context")

library(testthat)
library(xsitemap)

test_that("It should'nt find an XML sitemap for example.com", {
  expect_equal(xsitemapGet("http://www.example.com"), FALSE)
})

test_that("Search for www.sitemaps.org XML sitemap", {
  expect_equal(class(xsitemapGet("https://www.sitemaps.org")), "data.frame")
})
