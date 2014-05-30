#reading data into working environment
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#merge two dataframes to get vehicle-related sources in Baltimore and LA
sccFilter <- SCC[grepl(".*Vehicles.*", SCC$EI.Sector), 1]
sccFilter <- data.frame(SCC = sccFilter)
neiFilter <- NEI[NEI$fips == "24510" | NEI$fips == "06037" , ]
merged <- merge(neiFilter, sccFilter, by.x="SCC", by.y="SCC")
library("reshape2")
Melt <- melt(merged, id = c("year","fips"), measure.vars = "Emissions")
meltFrame <- dcast(Melt, year + fips ~  variable, sum)


#making a plot
png(file = "plot6.png")
par(mfrow=c(1,2))
barplot(meltFrame[meltFrame$fips == "24510" , ]$Emissions, names.arg = meltFrame$year[c(1,3,5,7)], xlab = "Year", ylab = "Emissions", main = "Mobile Emissions in Baltimore")
barplot(meltFrame[meltFrame$fips == "06037" , ]$Emissions, names.arg = meltFrame$year[c(2,4,6,8)], xlab = "Year", ylab = "Emissions", main = "Mobile Emissions in LA")
dev.off()


##Baltimore city sees dramastically decreasing of emissions.
##but L.A. doesn't change much, and the base is high.