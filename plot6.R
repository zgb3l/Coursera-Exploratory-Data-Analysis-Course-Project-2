# (0) Loading libraries.

library(ggplot2)
library(dplyr)

# (1) Reading all data (I put all data in the same map).

exdata_filename <- "exdata-data-NEI_data.zip"

# 1.1 Loading the NEI data.

if (!exists("NEI")) {
  # print("Loading NEI Data, please wait.")
  NEI <- readRDS("summarySCC_PM25.rds") 
}

# 1.2 Loading the SCC data.

if (!exists("SCC")) {
  # print("Loading SCC Data.")
  SCC <- readRDS("Source_Classification_Code.rds")
}


# Get the subset of the NEI data that corresponds to vehicles

vehicles <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
vehicles_SCC <- SCC[vehicles,]$SCC
vehicles_NEI <- NEI[NEI$SCC %in% vehicles_SCC,]

# Subset the vehicles NEI data by each city's fip and add city name.
vehiclesBaltimoreNEI <- vehicles_NEI[vehicles_NEI$fips=="24510",]
vehiclesBaltimoreNEI$city <- "Baltimore City"

vehiclesLANEI <- vehicles_NEI[vehicles_NEI$fips=="06037",]
vehiclesLANEI$city <- "Los Angeles County"

# Prepping data: combining the two subsets in one df.

citiesNEI <- rbind(vehiclesBaltimoreNEI,vehiclesLANEI)

# Making png and plot6.

png(filename="plot6.png", 
    units="px", 
    width=640, 
    height=480, 
    pointsize=12, 
    res=72)

plot6 <- ggplot(citiesNEI, aes(x = factor(year), 
                               y = round(Emissions),
                               fill = year)) +
  geom_bar(stat = "identity") + 
  facet_grid(scales="free", space="free", .~city) +
  ylab("Total PM2.5 emissions (tons)") + 
  xlab("Year") +
  ggtitle("Baltimore City vs Los Angeles County Motor Vehicle Emissions (1999-2008)")

print(plot6)
dev.off()



