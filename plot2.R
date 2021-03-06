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

#plot of global active power vs time as a thin black line. Set y axis title. 
#no main and x axis title.
plot(data$DateTime, data$Global_active_power, type="l",
     main="", xlab="", ylab="Global Active Power (kilowatts)")

#save plot
dev.copy( png, filename = "plot2.png", width = 480, height = 480, units = "px" )
dev.off()
