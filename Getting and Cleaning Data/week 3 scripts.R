library(RMySQL)
ucscDb <- dbConnect(MySQL(), user = "genome",
                   host = "genome-mysql.cse.ucsc.edu")
result <- dbGetQuery(ucscDb,"show databases;");dbDisconnect(ucscDb);

hg19 <- dbConnect(MySQL(),user="genome", db="hg19",
                  host="genome-mysql.cse.ucsc.edu")
allTables <- dbListTables(hg19)
length(allTables)
allTables[1:5]
dbGetQuery(hg19, "
           SELECT COUNT(*)
           FROM affyU133Plus2
           ")
dbDisconnect(hg19)


library(httr)
myapp <- oauth_app("github", "b1ef6b91dc15d6593f72", secret = "5e66a539d06c5fb56f6eb476f07235c9c8a4df43")
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)
gtoken <- config(token = github_token)
req <- with_config(gtoken, GET("https://api.github.com/users/jtleek/repos"))
stop_for_status(req)
json1 <- content(req)
json2 <- fromJSON(toJSON(json1))
names(json2)
class(json2)
json2[json2$name == "datasharing",]
json2



htmlUrl <- url("http://biostat.jhsph.edu/~jleek/contact.html")
htmlCode <- readLines(htmlUrl)
close(htmlUrl)
readLines(c(nchar(htmlCode[10]), nchar(htmlCode[20]), nchar(htmlCode[30]), nchar(htmlCode[100])))




# DPLYR

library(dplyr)
cars <- mtcars
head(cars)
head(select(cars,cyl:wt))
head(filter(cars, hp > 100 | cyl == 4))
head(arrange(cars, hp))
head(arrange(cars, desc(drat)))
head(arrange(cars, cyl, hp))
cars <- rename(cars, horsepower = hp)
head(cars)
cars <- mutate(cars, summpgcyl = mpg+cyl)
bycyl <- group_by(cars, cyl)
summarize(bycyl, mean(mpg), mean(horsepower))
