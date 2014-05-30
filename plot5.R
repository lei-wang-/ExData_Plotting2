#reading data into working environment
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#merge two dataframes to get vehicle-related sources
sccFilter <- SCC[grepl(".*Vehicles.*", SCC$EI.Sector), 1]
sccFilter <- data.frame(SCC = sccFilter)
neiFilter <- NEI[NEI$fips == "24510" , ]
merged <- merge(neiFilter, sccFilter, by.x="SCC", by.y="SCC")
library("reshape2")
Melt <- melt(merged, id = "year", measure.vars = "Emissions")
meltFrame <- dcast(Melt, year ~ variable, sum)

#making a plot
png(file = "plot5.png")
barplot(meltFrame$Emissions, names.arg = meltFrame$year, xlab = "Year", ylab = "Emissions", main = "Mobile Emissions in Baltimore")
dev.off()

#Emissions from motor vehicle sources decreased from 1999-2008 in Baltimore

