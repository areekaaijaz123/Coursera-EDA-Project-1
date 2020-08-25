data <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))

data$Date <- as.Date(data$Date, "%d/%m/%Y")

data <- subset(data, Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))

DateTime <- paste(data$Date, data$Time)

DateTime <- as.POSIXct(DateTime)

data <- cbind(DateTime, data)

data <- data[, !(names(data) %in% c("Date", "Time"))]

png(filename = "plot4.png", width = 480, height = 480)

par(mfrow = c(2, 2))

with(data, {
  plot(Global_active_power ~ DateTime, xlab = "", ylab = "Global Active Power", type = "l")
  plot(Voltage ~ DateTime, xlab = "datetime", ylab = "Voltage", type = "l")
  plot(Sub_metering_1 ~ DateTime, xlab = "", ylab = "Energy sub metering", type = "l")
  lines(Sub_metering_2 ~ DateTime, col = "red")
  lines(Sub_metering_3 ~ DateTime, col = "blue")
  legend("topright", col=c("black", "red", "blue"), c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lwd = c(1,1,1))
  plot(Global_reactive_power ~ DateTime, xlab = "datetime", type = "l")
})

dev.off()
