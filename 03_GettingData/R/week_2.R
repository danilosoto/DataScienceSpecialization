# Week 2 Quiz

# Question 1
# -----------------------------------------------------------------------------
# Register an application with the Github API here https://github.com/settings/applications. Access the API to get information on your instructors repositories (hint: this is the url you want "https://api.github.com/users/jtleek/repos"). Use this data to find the time that the datasharing repo was created. What time was it created?

library(httr)

# Find OAuth settings for github:
oauth_endpoints("github")

# Replace your key and secret below.
myapp <- oauth_app("github",
                   key = "5f91fb1506f8913e3f48",
                   secret = "ca4a620c357fda94a4dd269afff27e83bd347f6a")

# Get OAuth credentials
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)

# Use API
gtoken <- config(token = github_token)
req <- GET("https://api.github.com/rate_limit", gtoken)
stop_for_status(req)
content(req)

# OR:
req <- with_config(gtoken, GET("https://api.github.com/rate_limit"))
stop_for_status(req)
content(req)

# Question 2 & 3
# -----------------------------------------------------------------------------
library(RCurl)
library(sqldf)
library(readr)
myurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(url=myurl, destfile="./Data/acs.csv", method="curl")
acs <- read_csv("./Data/acs.csv")

# Which of the following commands will select only the data for the probability weights pwgtp1 with ages less than 50?
sqldf("select pwgtp1 from acs where AGEP < 50")

# Using the same data frame you created in the previous problem, what is the equivalent function to unique(acs$AGEP)
sqldf("select distinct AGEP from acs")

# Question 4
# -----------------------------------------------------------------------------
# How many characters are in the 10th, 20th, 30th and 100th lines of HTML from this page: http://biostat.jhsph.edu/~jleek/contact.html

connection <- url("http://biostat.jhsph.edu/~jleek/contact.html")
htmlCode <- readLines(connection)
close(connection)
c(nchar(htmlCode[10]), nchar(htmlCode[20]), nchar(htmlCode[30]), nchar(htmlCode[100]))

# Question 5
# -----------------------------------------------------------------------------
# Read this data set into R and report the sum of the numbers in the fourth column. https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for

url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"
connection <- url("https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for")
htmlCode <- readLines(connection)
close(connection)

myurl <-"https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"
download.file(url=myurl, destfile="./Data/survey.for", method="curl")
acs <- read_fwf("./Data/survey.for")

df <- read.fwf(file = "./Data/survey.for", widths = c(15, 4, 1, 3, 5, 4), header = FALSE, sep = "\t", skip = 4)
head(df)
sum(df$V6)
