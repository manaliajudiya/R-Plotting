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

#Plot
png("plot1.png",height=480,width=480)
hist(pd$Global_active_power,col="red",xlab="Global Active Power(kilowatts)",main="Global Active Power")
dev.off()