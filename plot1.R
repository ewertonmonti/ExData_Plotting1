setwd("C:/Users/Ewerton/Dropbox/Curso_Data_Science/4_ExploratoryAnalysis/Week1")

# Download and unzip data
if (!file.exists("data")){dir.create("data")}
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL, destfile = "./data/household_power_consumption.zip")
dateDownloaded <- date()
unzip("./data/household_power_consumption.zip", exdir = "./data")

# Load data into R
classes <- c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric")
data <- read.table("./data/household_power_consumption.txt", sep = ";", header = TRUE, colClasses=classes, na.strings = "?")

# Adjust Date and Time variable
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
data$Time <- strptime(data$Time, format = "%H:%M:%S")

# Subset the database to include the desired dates
data <- subset(data, data$Date == "2007-02-01" | data$Date == "2007-02-02")

# Create the png file, make the plot and close the png device
png(filename = "plot1.png")
hist(data$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()