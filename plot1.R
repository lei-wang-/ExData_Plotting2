#reading data into working environment
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#generate total emissions for years of interest.
s <- split(NEI, NEI$year)
y <- sapply(s, function(x)sum(x[,"Emissions"]))
x <- as.numeric(names(s))

#making a plot
png(file = "plot1.png")
plot(x, y, type = "l", xlab = "years of interest", ylab = "total emission", main = "Total Emission Trend")
dev.off()


##Total emissions of PM2.5 decreased in the US from 1999 to 2008

