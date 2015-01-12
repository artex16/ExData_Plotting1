dataUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
tmpFile <- tempfile()
tmpDir <- tempfile()

download.file(url = dataUrl, destfile = tmpFile, method = "curl")
unzip(tmpFile, exdir = tmpDir)
data <- read.csv(paste(tmpDir, "/household_power_consumption.txt", sep =""), sep = ";", stringsAsFactors = FALSE)

unlink(tmpFile)
unlink(tmpDir, recursive = TRUE)

range <- data[data$Date %in% c("1/2/2007", "2/2/2007"), ]
#range$Date <- as.Date(range$Date)
#range$Time <- strptime(range$Time, format= "%H:%M:%S")

range$Global_active_power <- as.double(range$Global_active_power)

png("plot1.png")
hist(range$Global_active_power, xlab = "Global Active Power (kilowatts)", col="red", main = "Global Active Power")
dev.off()

