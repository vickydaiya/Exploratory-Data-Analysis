#reading data into R dataframe
library(data.table)
data <- fread("household_power_consumption.txt",header = TRUE, sep = ";")

#subsetting data from the dates 2007-02-01 and 2007-02-02
reqd_data <- subset(data, Date == "1/2/2007" | Date == "2/2/2007")

#converting character date and time to Date and POSIXct objects
library(lubridate)
reqd_data$Date <- dmy(reqd_data$Date)
reqd_data$Time <- ymd_hms(paste(reqd_data$Date,reqd_data$Time))

#plotting the three submeter readings for the given period
png(filename = "plot3.png", width = 480, height = 480)
plot(reqd_data$Time, reqd_data$Sub_metering_1, type = "l", col = "black", ylab = "Energy sub metering", xlab = "")
lines(reqd_data$Time,reqd_data$Sub_metering_2, col = "red")
lines(reqd_data$Time,reqd_data$Sub_metering_3, col = "blue")
legend("topright",lty = c(1,1,1), lwd = 2, legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col = c("black","red","blue"))
dev.off()