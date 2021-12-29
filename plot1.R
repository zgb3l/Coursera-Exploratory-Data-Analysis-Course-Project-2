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

# (2) Aggregate by sum the total emissions by year.

aggTotals <- aggregate(Emissions ~ year,NEI, sum)


# (3) Making png file and creating plot1.

png("plot1.png",width=480,height=480,units="px",res=72)

barplot(
  (aggTotals$Emissions)/10^6,
  names.arg=aggTotals$year,
  xlab="Year",
  ylab="Total PM2.5 emissions (millions of tons)",
  main="Total PM2.5 Emissions From All US Sources",
  col = "blue"
)

dev.off()





