##extract data & processing Date and Time
start_row <- 66637; last_row <- 69516 #these numbers are from previous chunk.
header_db <- read.table(file="household_power_consumption.txt", header=F, sep=";", na.string="?", stringsAsFactors=FALSE, nrow=1)
ext_db <- read.table(file="household_power_consumption.txt", header=F, sep=";", na.string="?", stringsAsFactors=FALSE, skip=start_row, nrows=last_row-start_row+1)

#put header
ext_data <- ext_db 
colnames(ext_data) <- header_db

#processing Date and Time
datetime <- strptime(paste(ext_data$Date, ext_data$Time, sep=" "), format="%d/%m/%Y %T", tz = "UTC") #make Date and Time as posixlt
wdays <- strftime(datetime, format="%A")
proc_data <- cbind(datetime, wdays, ext_data) 

##Plot4
png(filename = "plot4.png", width = 480, height = 480)

par(mfrow=c(2,2)) #setting multiplot

plot(proc_data$Global_active_power~proc_data$datetime, type="l", ylab="Global active power(kilowatts)")#location(1,1)

plot(proc_data$Voltage~proc_data$datetime, type="l", xlab="datetime", ylab="Voltage")#location(1,2)

plot(proc_data$Sub_metering_1~proc_data$datetime, type="l", ylab="Energy sub metering")#location(2,1)
lines(proc_data$Sub_metering_2~proc_data$datetime, col="red")
lines(proc_data$Sub_metering_3~proc_data$datetime, col="blue")
legend("topright",col=c("black","red","blue"), lty=c(1,1,1), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

plot(proc_data$Global_reactive_power~proc_data$datetime, type="h", xlab="datetime", ylab="Global_reactive_power") #location(2,2)
par(mfrow=c(1,1)) #reset multiplot setting
dev.off()