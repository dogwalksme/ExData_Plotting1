if (!file.exists("subset.RData")) {
  colClasses <- c("character", "character", "numeric", "numeric", "numeric",
                  "numeric", "numeric", "numeric", "numeric" )
  D <- read.csv( "household_power_consumption.txt",
                 sep=";", colClasses = colClasses, na.strings = "?")
  D$Date <- as.Date(D$Date, "%d/%m/%Y")
  D <- D[D$Date >= as.Date("2007/02/01") & D$Date <= as.Date("2007/02/02"), ]

  save(D, file="subset.RData")
} else {
  load("subset.RData")
}

par(mfrow = c(2,2))

D$Datetime <- as.POSIXlt(paste(D[,1], D[,2]))

# Global Active power by day
plot(D$Datetime, D$Global_active_power, type="l",
     ylab= "Global Active Power (kilowatts)", xlab="")

# Voltage
plot(D$Datetime, D$Voltage, type="l",
     ylab = "Voltage", xlab = "datetime")

# Energy Sub Metering
plot(D$Datetime, D$Sub_metering_1, type="l",
     ylab= "Energy sub metering", xlab="")
lines(D$Datetime, D$Sub_metering_2, col = "red")
lines(D$Datetime, D$Sub_metering_3, col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"), lty=c(1,1), box.lwd = 0)

# global reactive power
plot(D$Datetime, D$Global_reactive_power, type = "l",
     ylab = " Global_reactive_power", xlab = "datetime")

dev.copy(png, file = "plot4.png", width = 480, height = 480)
dev.off()

