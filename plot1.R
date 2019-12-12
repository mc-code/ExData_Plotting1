#Rcode to create plot1.png
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
#check for values in all rows using is.na and !is.na
na <- subset(is.na(daterange))
notna <- subset(!is.na(daterange))

#Plot 1 is a histogram plot with col = "red' and Global Active Power by Frequency
"Global Active Power (kilowatts)" <- daterange$Global_active_power
Plot1 <-
  with(
    daterange,
    hist(
      breaks = 12,
      `Global Active Power (kilowatts)`,
      col = "red",
      ylim = c(0, 1400),
      main = title("Global Active Power",
                   ylab = "Frequency")
    )
  )
dev.copy(png,
         'ExData_Plotting1-master/plot1.png',
         width = 480,
         height = 480)
dev.off()
