setwd("/Users/pacha/bowie-timeline/")
library(plyr)
library(RCurl)
library(rCharts)

discography <- read.csv("discography.csv", as.is = TRUE)
discography <- alply(discography, 1, function(x) {
  list(startDate = x$Start.Date, headline = x$Headline, text = x$Text, asset = list(media = x$Media))
})

m = Timeline$new()
m$main(headline = paste0("David Bowie"), type = "default", text = paste0("Discography ", format(as.Date("1967-01-01"), 
                                                                                                "%Y"), "-", format(as.Date("2016-01-01"), "%Y")), 
startDate = format(as.Date("1967-01-01"), "%Y"), asset = list(media = "img/cover.jpg"))
names(discography) <- NULL
m$event(discography)

m$save("index.html")