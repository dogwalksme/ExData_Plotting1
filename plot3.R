# Date;Time;Global_active_power;Global_reactive_power;Voltage;Global_intensity;Sub_metering_1;Sub_metering_2;Sub_metering_3
# 16/12/2006;17:24:00;4.216;0.418;234.840;18.400;0.000;1.000;17.000

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

D$Datetime <- as.POSIXlt(paste(D[,1], D[,2]))

plot(D$Datetime, D$Sub_metering_1, type="l",
     ylab= "Energy sub metering", xlab="")
lines(D$Datetime, D$Sub_metering_2, col = "red")
lines(D$Datetime, D$Sub_metering_3, col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"), lty=c(1,1))

dev.copy(png, file = "plot3.png", width = 480, height = 480)
dev.off()
