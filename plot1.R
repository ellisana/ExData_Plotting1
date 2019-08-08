library(readr)
library(dplyr)
library(lubridate)

EPC <- read_delim("~/Documents/Coursera/EDA/data/household_power_consumption.txt", delim = ";")
glimpse(EPC)

# parse Date 
EPC$Date <- parse_date(EPC$Date, "%d/%m/%Y")

# using data from the dates 2007-02-01 and 2007-02-02
EPC_gap <- filter(EPC, Date == "2007-02-01" | Date == "2007-02-02")

# plot 1
hist(EPC_gap$Global_active_power, main = "Global Active Power", col = "red",
     xlab = "Global Active Power (Kilowatts)")
