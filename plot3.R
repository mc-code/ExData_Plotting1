#Rcode to create plot3.png
#read.csv entire table using the same arguments
house_hold_power_consumption <-
  read.table(
    "ExData_Plotting1-master/data_in/household_power_consumption.txt",
    header = TRUE,
    sep = ";",
    stringsAsFactors = FALSE,
    na.strings = "?"
  )
#extract rows between the dates 2007-02-01 and 2007-02-02.

#change class to date

house_hold_power_consumption$Date <-
  as.Date(house_hold_power_consumption$Date, "%d/%m/%Y")
#extract rows between the dates 2007-02-01 and 2007-02-02.

daterange <-
  subset(house_hold_power_consumption,
         Date >= "2007-02-01" & Date <= "2007-02-02")
#create a variable with correct label and data
"Global Active Power (kilowatts)" <- daterange$Global_active_power
#get the corresponding day for each date
library(lubridate)
dayofweek <- wday(daterange$Date, label = TRUE)
daterange2 <- with(daterange, ymd(Date) + hms(Time) + c(3, 9))
daterange3 <- cbind(daterange, dayofweek, daterange2)

#Plot 3 has 3 lines 'Submetering_1,._2, ._3
with(
  daterange3,
  plot(
    x = daterange2,
    y = Sub_metering_1,
    type = "l",
    col = "black",
    xlab = "",
    ylab = "Energy sub metering"
  )
)
lines(daterange2, daterange3$Sub_metering_2, col = "red")
lines(daterange2, daterange3$Sub_metering_3, col = "blue")
legend("topright",lty = c(1,1,1), c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3") , col = c("black", "red", "blue"))
dev.copy(png,'ExData_Plotting1-master/plot3.png', width = 480, height = 480)
dev.off()
