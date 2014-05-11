#Read the data
full <- read.table(file="household_power_consumption.txt", header=TRUE, sep=";", colClasses=c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"), stringsAsFactors=FALSE, na.strings="?")
#Subset to the two days to be used (02/01/2007 and 02/02/2007)
y <- subset(full, as.Date(x$Date, "%d/%m/%Y") > as.Date("2007-01-31") & as.Date(x$Date, "%d/%m/%Y") < as.Date("2007-02-03"))
#Create a POSIX date time column from the Date and Time columns
y$datetime <- strptime(paste(y[,"Date"],y[,"Time"]), "%d/%m/%Y %H:%M:%S")
#Create the tickmark labels by day of the week for the plots
png("plot1.png")
#plot the histogram for plot 1 with modified title, x-axis labels, and red bar color
hist(y$Global_active_power, main="Global Active Power", xlab="Global Active Power (kilowatts)", col="red")
dev.off()