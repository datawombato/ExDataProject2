library(plyr)
library(ggplot2)

# read the rds file data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# find all coal related SCC codes
SCCidx <- grep("coal", SCC$Short.Name, ignore.case = TRUE)
SCCcoal <- SCC[SCCidx,]
SCCidentifiers <- as.character(SCCcoal$SCC)

# find all observations that have a coal related SCC code
NEI$SCC <- as.character(NEI$SCC)
NEIcoal <- NEI[NEI$SCC %in% SCCidentifiers,]

png(file = "plot4.png")  

# extract and aggregate the total emissions by year using tapply
pm25 <- ddply(NEIcoal, .(year,type), function(x) sum(x$Emissions))
colnames(pm25)[3] <- "Emissions" 

qplot(year, Emissions, data = pm25, color = type, geom = "line") + 
  ggtitle("PM25 emissions by all coal combustion-related sources") +
  xlab("Year") +
  ylab("Total PM25 emissions (tons)")

dev.off()  
## Close the PNG file device
