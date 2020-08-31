##Code for download and unzip the dataset
urlfile <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if (!file.exists("household_power_consumption.txt")) {
        
        download.file(urlfile,"./exdata-data-household_power_consumption.zip",mode="wb")
        
        unzip("exdata-data-household_power_consumption.zip", exdir = getwd())
        print("File downloaded and unzipped")
} else {
        print('The dataset was previously downloaded and extracted')
}

#Read the complete dataset
T <- read.table("household_power_consumption.txt",header = TRUE, sep= ";")

#Select a subset 
Tsub <- subset(T, Date == "1/2/2007" | Date == "2/2/2007")

#Free memory
rm(T)

#Convert some columns
Tsub$Global_active_power = as.numeric(as.character(Tsub$Global_active_power))
Tsub$Global_reactive_power = as.numeric(as.character(Tsub$Global_reactive_power))
Tsub$Voltage = as.numeric(as.character(Tsub$Voltage))
Tsub$Global_intensity = as.numeric(as.character(Tsub$Global_intensity))
Tsub$Sub_metering_1= as.numeric(as.character(Tsub$Sub_metering_1))
Tsub$Sub_metering_2= as.numeric(as.character(Tsub$Sub_metering_2))

#Conver the firt two columns
datetime <- strptime(paste(Tsub$Date, Tsub$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 

#Code for plotting and saving in a PNG File
png("plot4.png", width=480, height=480)

par(mfrow = c(2, 2)) 
# First plot
plot(datetime, Tsub$Global_active_power, type="l", xlab="", ylab="Global Active Power", cex=0.25)
# Second plot
plot(datetime, Tsub$Voltage, type="l", xlab="datetime", ylab="Voltage")
# Third plot
plot(datetime, Tsub$Sub_metering_1, type="l", ylab="Energy Submetering", xlab="")
lines(datetime, Tsub$Sub_metering_2, type="l", col="red")
lines(datetime, Tsub$Sub_metering_3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=, lwd=2.5, col=c("black", "red", "blue"), bty="o")
# Fourth plot
plot(datetime, Tsub$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power", cex=0.2)

dev.off()