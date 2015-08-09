# First plot: a histogram of the global active power.

### THE FOLLOWING CODE BLOCK IS COMMON TO ALL 4 PLOTS ###

# Read in data if the file exists. Only read the first 70000 lines (covering dates up to 2007-02-03)

filename <- "household_power_consumption.txt"
if(!file.exists(filename))
{
  stop("Input file ", filename, " not found in working directory. Exiting.")
}

data <- read.csv(filename, nrow=70000, header=T, sep=";", na.strings="?")

#Make a new date-time column
data$DateTime <- strptime( paste(data$Date, data$Time),  "%d/%m/%Y %T")

#Subset out relevant dates (2007-02-01 and 2007-02-02)
starttime <- strptime("2007-02-01 00:00:00", "%Y-%m-%d %T" )
endtime <- strptime("2007-02-03 00:00:00", "%Y-%m-%d %T")
data<-subset( data, DateTime >= starttime  & DateTime < endtime )


### END OF COMMON BLOCK ###

# one plot in one panel
par(mfcol = c(1,1))

#global font size
par(cex = 0.75)

#Set date time output format to english
Sys.setlocale("LC_TIME", "C")

#plot of energy sub metering vs time. Y axis label.
#3 lines with different colors corresponding to the 3 submetering columns.
plot(data$DateTime, data$Sub_metering_1, type="l",
     main="", xlab="", ylab="Energy sub metering")
lines(data$DateTime, data$Sub_metering_2, col="red")
lines(data$DateTime, data$Sub_metering_3, col="blue")

#legend. 3 entries: Lines in different colors with description.
legend( "topright",  lwd=c(1,1,1), lty=c(1,1,1), col=c("black", "red", "blue"), 
        legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

#save plot
dev.copy( png, filename = "plot3.png", width = 480, height = 480, units = "px" )
dev.off()
