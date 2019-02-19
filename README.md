# xsitemap

### Description

This R' package aim to ease the work with XML sitemap and SEO related tasks. Tutorials will come later


## Install
```
#Github (dev version)
library(devtools)
devtools::install_github("pixgarden/xsitemap")
```

## Getting started
load the xsitemap package :
```
library(xsitemap)
```

## xsitemap Functions

### 1. xsitemapGet()
This is the main function. Add domain hostname or an XML URL as a parameter 
```
xsitemap_urls <- xsitemapGet("https://www.nationalarchives.gov.uk/")

```

### 2. xsitemapCheckHTTP()

Will check if sitemap urls are sending 200 http code.Beware it can take some time depending on the number of URLs

```
xsitemap_urls_http <- xsitemapCheckHTTP(xsitemap_urls)

```


### 3. xsitemapGuess.R()
Will try to guess XML Urls in this oder:
- search for xml sitemap inside robots.txt
- guess a XML sitemap urls


### 4. xsitemapGetFromRobotsTxt()

Will search for xml sitemap inside robots.txt


### 5. xsitemapGuess())

Will guess a XML sitemap urls



## Feedbacks
Questions and feedbacks welcome!

You want to contribute ? Open a pull request ;-) If you encounter a bug or want to suggest an enhancement, please open an issue.

- François
