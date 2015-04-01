library(RODBC)
library(zoo)
library(scales)

#########################################
#library(xlsx)

sqlFileCon <- file("GetRawData.sql", "r")
sqlString <- gsub("\t", " ", paste(readLines(sqlFileCon), collapse=" "))

channel <- odbcConnect("SQLServerVivaldi")
RawData <- as.data.frame(sqlQuery(channel, sqlString))
close(channel)

save(RawData, file = "DataSet.Rda")

##########################################

