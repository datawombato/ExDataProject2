
# read the rds file data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

png(file = "plot1.png")  
# extract and aggregate the total emissions by year using tapply
pm25 <- tapply(NEI$Emissions, NEI$year, sum)
x <- names(pm25)
plot(x,pm25, type = "l", col = "blue", ylab = "Total PM25 emissions (tons)",
     xlab = "Year", main = "Total PM25 emission from all sources")
dev.off()  
## Close the PNG file device
