library(plyr)
library(ggplot2)

# read the rds file data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

NEIbaltimore <- NEI[NEI$fips == 24510,]

png(file = "plot3.png")  

# extract and aggregate the total emissions by year using tapply
pm25 <- ddply(NEIbaltimore, .(year,type), function(x) sum(x$Emissions))
colnames(pm25)[3] <- "Emissions" 

qplot(year, Emissions, data = pm25, color = type, geom = "line") + 
  ggtitle("PM25 emissions by source, Baltimore City") +
  xlab("Year") +
  ylab("Total PM25 emissions (tons)")

dev.off()  
## Close the PNG file device
