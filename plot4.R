#Read file
file <- "household_power_consumption.txt"
data <- read.delim(file, header = TRUE, sep = ";", quote = "\"", dec = ".", fill = TRUE,comment.char = "",na.string='?')

#Set date format
data$Date <- as.Date(data$Date,format = "%d/%m/%Y")
data$Date <- strftime(data$Date,'%d/%m/%y')

#Filter based on date
from <- as.Date('01/02/2007',format = "%d/%m/%Y")
from <- strftime(from,'%d/%m/%y')
to <- as.Date('02/02/2007',format = "%d/%m/%Y")
to <- strftime(to,'%d/%m/%y')
pd <- subset(data,Date %in% c(from,to))
pd$DateTime <- strptime(paste(pd$Date, pd$Time), 
                        "%d/%m/%Y %H:%M:%S")

#Plot
png("plot4.png",height=480,width=480)

par(mfrow=c(2,2))

plot(pd$DateTime, 
     pd$Global_active_power, 
     pch=NA, 
     xlab="", 
     ylab="Global Active Power (kilowatts)")
lines(pd$DateTime, pd$Global_active_power)

#Voltage plot
plot(pd$DateTime,pd$Voltage,ylab="Voltage", xlab="datetime", pch=NA)
lines(pd$DateTime,pd$Voltage)

#Energy sub metering plot
plot(pd$DateTime, 
pd$Sub_metering_1, 
pch=NA, 
xlab="", 
ylab="Energy sub metering")
lines(pd$DateTime, pd$Sub_metering_1)
lines(pd$DateTime, pd$Sub_metering_2, col='red')
lines(pd$DateTime, pd$Sub_metering_3, col='blue')
legend('topright', 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty = c(1,1,1),
       col = c('black', 'red', 'blue'),
       bty = 'n')

# Global reactive power plot
with(pd, plot(DateTime, Global_reactive_power, xlab='datetime', pch=NA))
with(pd, lines(DateTime, Global_reactive_power))

# Close PNG file
dev.off()
