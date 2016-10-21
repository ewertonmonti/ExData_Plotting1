setwd("C:/Users/Ewerton/Dropbox/Curso_Data_Science/4_ExploratoryAnalysis/Week1")

# Download and unzip data
if (!file.exists("data")){dir.create("data")}
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL, destfile = "./data/household_power_consumption.zip")
dateDownloaded <- date()
unzip("./data/household_power_consumption.zip", exdir = "./data")

# Load data into R
classes <- c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric")
original_data <- read.table("./data/household_power_consumption.txt", sep = ";", header = TRUE, colClasses=classes, na.strings = "?")

# Adjust Date and Time variable
original_data$Date <- as.Date(original_data$Date, format = "%d/%m/%Y")
#original_data$Time <- strptime(original_data$Time, format = "%H:%M:%S")

# Subset the database to include the desired dates
data <- subset(original_data, original_data$Date == "2007-02-01" | original_data$Date == "2007-02-02")

# Create variable to use in the x-axis
datetime <- as.POSIXlt(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S")
data <- cbind(data, datetime)

# Create the png file, make the plot and close the png device
png(filename = "plot4.png")
par(mfcol = c(2,2))

with(data, {
    plot(Global_active_power ~ datetime, xlab = "", ylab = "Global Active Power", type = "l")
    plot(Sub_metering_1 ~ datetime, type = "l", col = "black", xlab = "", ylab = "Energy sub metering")
    lines(Sub_metering_2 ~ datetime, col = "red")
    lines(Sub_metering_3 ~ datetime, col = "blue") 
    legend("topright", col = c("black", "red", "blue"), 
           legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
           lty=1, bty="n")
    plot(Voltage ~ datetime, type = "l")
    plot(Global_reactive_power ~ datetime, type = "l")
})

dev.off()

