#reading data into working environment
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#create new dataframe for different types of emissions 
#from 1999-2008 in Baltimore city
library("reshape2")
library("ggplot2")
dataFrame <- NEI[NEI$fips == "24510" , ]
Melt <- melt(dataFrame, id = c("type","year"), measure.vars = "Emissions")
meltFrame <- dcast(Melt, year + type ~ variable, sum)

#making a plot
png(file = "plot3.png")
ggplot(meltFrame, aes(year, Emissions)) + geom_point() + facet_grid(. ~ type)
dev.off()

##The Non-road, Non-point, and on-road emission decrease starting 
##from 1999 to 2008; the point emission increase a little.

