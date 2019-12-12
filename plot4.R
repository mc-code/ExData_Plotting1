#Rcode to create plot4.png
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
library(lubridate)
dayofweek <- wday(daterange$Date, label = TRUE)
daterange2 <- with(daterange, ymd(Date) + hms(Time) + c(3, 9))
daterange3 <- cbind(daterange, dayofweek, daterange2)
#set up the plot area
par(mar = c(4, 4, 4, 1))
par(mfrow = c(2, 2))
par(cex = 0.7)
#plot top left
with(
  daterange3,
  plot(
    daterange2,
    Global_active_power,
    xlab = "",
    ylab = "Global Active Power",
    type = "l"
  )
)
#plot top right
with(daterange3,
     plot(
       daterange2,
       Voltage,
       xlab = "datetime",
       ylab = "Voltage",
       type = "l"
     ))
#"plot bottom left"
with(
  daterange3,
  plot(
    daterange2,
    Sub_metering_1,
    type = "l",
    col = "black",
    xlab = "",
    ylab = "Energy  sub metering"
  )
)
legend(
  "topright",
  lty = c(1, 1, 1),
  c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3") ,
  col = c("black", "red", "blue"),
  bty = "n"
)
lines(daterange2, daterange3$Sub_metering_2, col = "red")
lines(daterange2, daterange3$Sub_metering_3, col = "blue")
#plot bottom right
with(
  daterange3,
  plot(
    daterange2,
    Global_reactive_power,
    xlab = "datetime",
    type = "l",
    col = "black"
  )
)
#create png
dev.copy(
  png,
  'ExData_Plotting1-master/plot4.png',
  width = 480,
  height = 480
)
dev.off()
