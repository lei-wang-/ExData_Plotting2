#reading data into working environment
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#generate total emissions for years of interest
#in the Baltimore City.
s <- split(NEI, NEI$year)
y <- sapply(s, function(x)sum(x[x$fips == "24510", "Emissions"]))
x <- as.numeric(names(s))

#making a plot
png(file = "plot2.png")
plot(x, y, type = "l", xlab = "years of interest", ylab = "total emission", main = "Total Emission Trend in Baltimore")
dev.off()


##Total emission of PM2.5 in Baltimore city decreased from 
##1999 to 2008, although it's not linearly decreasing.