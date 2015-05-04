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
NEImotorbaltimore <- NEImotor[NEImotor$fips == "24510",]
NEImotorbaltimore$city <- "Baltimore"
NEIlosangeles <- NEImotor[NEImotor$fips == "06037",]
NEIlosangeles$city <- "Los Angeles County"
NEImerged <- rbind(NEImotorbaltimore,NEIlosangeles)

png(file = "plot6.png")  
# aggregate emissions using aggregate
pm25 <- aggregate(Emissions ~ city * year, data = NEImerged, FUN = sum)


qplot(year, Emissions, data = pm25, color = city, geom = "line") + 
  ggtitle("PM25 emissions by motor vehicles,\nBaltimore City and Los Angeles County") +
  xlab("Year") +
  ylab("Total PM25 emissions (tons)")


dev.off()  
## Close the PNG file device
