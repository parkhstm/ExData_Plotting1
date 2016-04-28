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

##Plot3
png(filename = "plot3.png", width = 480, height = 480)
plot(proc_data$Sub_metering_1~proc_data$datetime, type="l", ylab="Energy sub metering")
lines(proc_data$Sub_metering_2~proc_data$datetime, col="red")
lines(proc_data$Sub_metering_3~proc_data$datetime, col="blue")
legend("topright",col=c("black","red","blue"), lty=c(1,1,1), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dev.off()