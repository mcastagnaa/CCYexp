library(ggplot2)

rm(list = ls())
load("DataSet.Rda")

RawData$Date <- as.Date(RawData$Date)
LastDate <- max(RawData$Date, na.rm=TRUE)
Last6mRaw <- RawData[RawData$Date > 
                       as.Date(as.yearmon(LastDate) - 0.5, frac = 1) & 
                       (!is.na(RawData$CCYExposure)),]
Last6mRaw$FundCode <- factor(Last6mRaw$FundCode)

FundsNo <- levels(Last6mRaw$FundCode)
FundCounts <- as.data.frame(sapply(split(Last6mRaw$FundCode, Last6mRaw$Date), 
                                   function(x) length(unique(x))))
FundDatesCounts <- as.data.frame(sapply(split(Last6mRaw$Date, Last6mRaw$FundCode), 
                                        function(x) length(unique(x))))

Ranges <- as.data.frame(t(sapply(split(Last6mRaw$CCYExposure, Last6mRaw$FundCode), 
                                 range)))
colnames(Ranges) <- c("Min", "Max")
Ranges$Range <- Ranges$Max-Ranges$Min

FOUNDsub <- which(rownames(Ranges) %in% 
                    subset(rownames(Ranges), 
                           subset = grepl(glob2rx("FOUND*"), 
                                          rownames(Ranges))))
threshold <- 0.1
FundsOverThresh <- Ranges[Ranges$Range > threshold &
                            !rownames(Ranges) %in% rownames(Ranges)[FOUNDsub],]

FundsOverThresh <- FundsOverThresh[order(-FundsOverThresh$Range),]

PltsData <- Last6mRaw[Last6mRaw$FundCode %in% rownames(FundsOverThresh),]

PltsData$FundCode <- factor(PltsData$FundCode)
levels(PltsData$FundCode)

ggplot()+
    geom_line(data=PltsData,
           aes(y=CCYExposure, x = Date, group=FundCode), 
           stat= "identity") +
    facet_grid(FundCode ~ .) + 
    scale_y_continuous(labels =percent)

#########################