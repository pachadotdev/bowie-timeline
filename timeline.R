if (!require("pacman")) install.packages("pacman")
p_load(plyr,dplyr,readr,RCurl)
p_load_gh("ramnathv/rCharts")


discography = read_csv("discography.csv", col_types = cols(.default = "c")) 

discography = alply(discography, 1, function(x) {
  list(startDate = x$`Start Date`, headline = x$Headline, text = x$Text, asset = list(media = x$Media))
})

tl = Timeline$new()
tl$main(headline = paste0("David Bowie"), type = "default", text = paste0("Discography ", 
        format(as.Date("1967-01-01"), "%Y"), "-", format(as.Date("2016-01-01"), "%Y")), 
        startDate = format(as.Date("1967-01-01"), "%Y"), asset = list(media = "img/cover.jpg"))
names(discography) = NULL
tl$event(discography)

tl$save("index.html")

# Modify JS Path
js = paste(read_lines("index.html"), collapse = "\n") %>% 
  gsub("/home/pacha/GitHub/bowie-timeline/", "", .) %>% 
  gsub("1/1/", "19", .) %>% 
  gsub(" 00:00", "", .) %>% 
  gsub("190", "200", .) %>% 
  gsub("191", "201", .)
write_lines(js, "index.html")