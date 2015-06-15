library(RODBC)

#########################################

sqlFileCon <- file("GetRawData.sql", "r")
sqlString <- gsub("\t", " ", paste(readLines(sqlFileCon), collapse=" "))
close(sqlFileCon)

channel <- odbcConnect("SQLServerVivaldi")
RawData <- as.data.frame(sqlQuery(channel, sqlString))
close(channel)

save(RawData, file = "DataSet.Rda")

##########################################

