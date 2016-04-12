setwd("/Users/pacha/bowie-timeline/")
library(plyr)
library(RCurl)
library(rCharts)

discography <- read.csv("discography.csv", as.is = TRUE)
discography <- alply(discography, 1, function(x) {
  list(startDate = x$Start.Date, headline = x$Headline, text = x$Text, asset = list(media = x$Media))
})

tl = Timeline$new()
tl$main(headline = paste0("David Bowie"), type = "default", text = paste0("Discography ", 
        format(as.Date("1967-01-01"), "%Y"), "-", format(as.Date("2016-01-01"), "%Y")), 
        startDate = format(as.Date("1967-01-01"), "%Y"), asset = list(media = "img/cover.jpg"))
names(discography) <- NULL
tl$event(discography)

tl$save("index.html")

# Modify JS Path
js <- paste(readLines("index.html", warn = F), collapse = "\n")
js <- gsub("/Users/pacha/bowie-timeline/timeline/js/storyjs-embed.js", 
          "timeline/js/storyjs-embed.js", 
          js)
writeLines(js, con = "index.html")