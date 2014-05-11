#Read the data
full <- read.table(file="household_power_consumption.txt", header=TRUE, sep=";", colClasses=c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"), stringsAsFactors=FALSE, na.strings="?")
#Subset to the two days to be used (02/01/2007 and 02/02/2007)
y <- subset(full, as.Date(x$Date, "%d/%m/%Y") > as.Date("2007-01-31") & as.Date(x$Date, "%d/%m/%Y") < as.Date("2007-02-03"))
#Create a POSIX date time column from the Date and Time columns
y$datetime <- strptime(paste(y[,"Date"],y[,"Time"]), "%d/%m/%Y %H:%M:%S")
#Create the tickmark labels by day of the week for the plots
atx <- seq(y$datetime[1],strptime("2007-02-03 00:00:00", "%Y-%m-%d %H:%M:%S"), by=24*60*60)
png("plot2.png")
#Plot Global_active_power against datetime, leaving off x-axis tick marks
with(y,plot(datetime,Global_active_power,type="l",xaxt="n",xlab="",ylab="Global Active Power (kilowatts)"))
#Add x-axis tick marks and labels using day of week abbreviations
axis(1, at=atx, labels=format(atx,"%a"))
dev.off()