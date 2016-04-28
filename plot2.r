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

##Plot2
png(filename = "plot2.png", width = 480, height = 480)
plot(proc_data$Global_active_power~proc_data$datetime, type="l", ylab="Global active power(kilowatts)")
dev.off()
