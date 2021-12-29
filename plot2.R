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


# (2) Subset NEI data by Baltimore's fip.

baltimoreNEI <- NEI[NEI$fips=="24510",]

# (3) Aggregate using sum the Baltimore emissions data by year.

aggTotalsBaltimore <- aggregate(Emissions ~ year, baltimoreNEI,sum)

# (4) Making png and creating plot2.

png("plot2.png",width=480,height=480,units="px",res=72)

barplot(
  aggTotalsBaltimore$Emissions,
  names.arg=aggTotalsBaltimore$year,
  xlab="Year",
  ylab="Total PM2.5 emissions (tons)",
  main="Total PM2.5 Emissions (1999-2008) at Baltimore City, Maryland",
  col = "red"
)

dev.off()