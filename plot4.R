#reading data into R dataframe
library(data.table)
data <- fread("household_power_consumption.txt",header = TRUE, sep = ";")

#subsetting data from the dates 2007-02-01 and 2007-02-02
reqd_data <- subset(data, Date == "1/2/2007" | Date == "2/2/2007")

#converting character date and time to Date and POSIXct objects
library(lubridate)
reqd_data$Date <- dmy(reqd_data$Date)
reqd_data$Time <- ymd_hms(paste(reqd_data$Date,reqd_data$Time))

#plotting the global active power,three submeter readings,voltage and global reactive power for the given period
png(filename = "plot4.png", width = 480, height = 480)
par(mfcol = c(2,2))
plot(reqd_data$Time,reqd_data$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
plot(reqd_data$Time, reqd_data$Sub_metering_1, type = "l", col = "black", ylab = "Energy sub metering", xlab = "")
lines(reqd_data$Time,reqd_data$Sub_metering_2, col = "red")
lines(reqd_data$Time,reqd_data$Sub_metering_3, col = "blue")
legend("topright",lty = c(1,1,1), lwd = 2, legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col = c("black","red","blue"), bty = "n")
plot(reqd_data$Time,reqd_data$Voltage,ylab = "Voltage", xlab = "datetime", type = "l")
plot(reqd_data$Time,reqd_data$Global_reactive_power,ylab = "Global_reactive_power", xlab = "datetime", type = "l")
dev.off()