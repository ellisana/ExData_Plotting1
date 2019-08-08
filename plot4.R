library(readr)
library(dplyr)
library(lubridate)

EPC <- read_delim("~/Documents/Coursera/EDA/data/household_power_consumption.txt", delim = ";")
glimpse(EPC)

# parse Date 
EPC$Date <- parse_date(EPC$Date, "%d/%m/%Y")
# using data from the dates 2007-02-01 and 2007-02-02
EPC_gap <- filter(EPC, Date == "2007-02-01" | Date == "2007-02-02")
#combine dateTime
EPC_gap$newDate <- with(EPC_gap, as.POSIXct(paste(Date, Time)))
glimpse(EPC_gap)

# create the frame
par(mfrow = c(2, 2), mar = c(4, 4, 2, 1), oma = c(0, 0, 2, 0))

# 4.1
plot(EPC_gap$newDate, EPC_gap$Global_active_power, type = "l", xlab = "", 
     ylab = "Global Active Power")
# 4.2
plot(EPC_gap$newDate, EPC_gap$Voltage, type = "l", xlab = "dateTime", ylab = "Voltage")
# 4.3
with(EPC_gap, plot(newDate, Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering"))
with(subset(EPC_gap), lines(newDate, Sub_metering_2, col = "red"))
with(subset(EPC_gap), lines(newDate, Sub_metering_3, col = "blue"))
legend("topright", pch = "-", col = c("black", "red", "blue"), 
       legend = paste0("Sub_metering_", 1:3))
#4.4
plot(EPC_gap$newDate, EPC_gap$Global_reactive_power, type = "l",  xlab = "dateTime",
     ylab = "Global_reactive_power")