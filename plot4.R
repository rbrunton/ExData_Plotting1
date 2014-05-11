#Read the data
full <- read.table(file="household_power_consumption.txt", header=TRUE, sep=";", colClasses=c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"), stringsAsFactors=FALSE, na.strings="?")
#Subset to the two days to be used (02/01/2007 and 02/02/2007)
y <- subset(full, as.Date(x$Date, "%d/%m/%Y") > as.Date("2007-01-31") & as.Date(x$Date, "%d/%m/%Y") < as.Date("2007-02-03"))
#Create a POSIX date time column from the Date and Time columns
y$datetime <- strptime(paste(y[,"Date"],y[,"Time"]), "%d/%m/%Y %H:%M:%S")
#Create the tickmark labels by day of the week for the plots
atx <- seq(y$datetime[1],strptime("2007-02-03 00:00:00", "%Y-%m-%d %H:%M:%S"), by=24*60*60)
png("plot4.png")
#Set canvas to have two rows and two columns, adding graphs across rows
par(mfrow=c(2,2))
#1
with(y,plot(datetime,Global_active_power,type="l",xaxt="n",xlab="",ylab="Global Active Power"))
axis(1, at=atx, labels=format(atx,"%a"))
#2
with(y,plot(datetime,Voltage,type="l",xaxt="n"))
axis(1, at=atx, labels=format(atx,"%a"))
#3
with(y,plot(datetime,Sub_metering_1,type="n",xaxt="n",xlab="",ylab="Energy sub metering"))
axis(1, at=atx, labels=format(atx,"%a"))
lines(y$datetime, y$Sub_metering_1)
lines(y$datetime, y$Sub_metering_2, col=c("red"))
lines(y$datetime, y$Sub_metering_3, col=c("blue"))
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty=c(1,1,1), col=c("black","red","blue"))
#4
with(y,plot(datetime,Global_reactive_power,type="l",xaxt="n"))
axis(1, at=atx, labels=format(atx,"%a"))
dev.off()