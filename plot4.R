#reading data into working environment
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


#merge two dataframes to get coal combustion-related sources
sccFilter <- SCC[grepl(".*Comb.*Coal.*", SCC$EI.Sector), 1]
sccFilter <- data.frame(SCC = sccFilter)
merged <- merge(NEI, sccFilter, by.x="SCC", by.y="SCC")
library("reshape2")
Melt <- melt(merged, id = "year", measure.vars = "Emissions")
meltFrame <- dcast(Melt, year ~ variable, sum)

#making a plot
png(file = "plot4.png")
barplot(meltFrame$Emissions, names.arg = meltFrame$year, xlab = "Year", ylab = "Emissions", main = "Emissions")
dev.off()

##Emissions from coal combustion-related sources decreased 
##from 1999 to 2008