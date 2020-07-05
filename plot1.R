#reading data into R dataframe
library(data.table)
data <- fread("household_power_consumption.txt",header = TRUE, sep = ";")

#subsetting data from the dates 2007-02-01 and 2007-02-02
reqd_data <- subset(data, Date == "1/2/2007" | Date == "2/2/2007")

#converting character date and time to Date and POSIXct objects
library(lubridate)
reqd_data$Date <- dmy(reqd_data$Date)
reqd_data$Time <- ymd_hms(paste(reqd_data$Date,reqd_data$Time))

#plotting a histogram of global active power
png(filename = "plot1.png", width = 480, height = 480)
hist(as.numeric(reqd_data$Global_active_power), xlab = "Global Active Power (kilowatts)", col = "red", main = "Global Active Power")
dev.off()