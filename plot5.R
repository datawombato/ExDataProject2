library(plyr)
library(ggplot2)

# read the rds file data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# find all motor vehicle related SCC codes
SCCidx <- grep("vehicle", SCC$EI.Sector, ignore.case = TRUE)
SCCvehicle <- SCC[SCCidx,]
SCCidentifiers <- as.character(SCCvehicle$SCC)

# find all observations that have a coal related SCC code
NEI$SCC <- as.character(NEI$SCC)
NEImotor <- NEI[NEI$SCC %in% SCCidentifiers,]
NEImotorbaltimore <- NEImotor[NEImotor$fips == 24510,]

png(file = "plot5.png")  

# extract and aggregate the total emissions by year using tapply
pm25 <- ddply(NEImotorbaltimore, .(year), function(x) sum(x$Emissions))
colnames(pm25)[2] <- "Emissions" 

qplot(year, Emissions, data = pm25, geom = "line") + 
  ggtitle("PM25 emissions by motor vehicles, Baltimore City") +
  xlab("Year") +
  ylab("Total PM25 emissions (tons)")

dev.off()  
## Close the PNG file device
