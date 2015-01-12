dataUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
tmpFile <- tempfile()
tmpDir <- tempfile()

download.file(url = dataUrl, destfile = tmpFile, method = "curl")
unzip(tmpFile, exdir = tmpDir)
data <- read.csv(paste(tmpDir, "/household_power_consumption.txt", sep =""), sep = ";", stringsAsFactors = FALSE)

unlink(tmpFile)
unlink(tmpDir, recursive = TRUE)

# as per the project requirements, limit to these two days
range <- data[data$Date %in% c("1/2/2007", "2/2/2007"), ]

range$Global_active_power <- as.double(range$Global_active_power)

# convert char columns to Date type, paste - concatenates strings
time <- strptime(paste(range$Date, range$Time, sep = " "), format = "%d/%m/%Y %H:%M:%S")

# create png file
png("plot4.png")

# limit margins, you can check defaults with: par()$mar
# order is bottom, left, top, right
par(mar = c(4.1, 4.1, 0.1, 0.1))

# set grid of graphs (2x2)
par(mfrow = c(2, 2))


# first chart (top-left)

#type  description
#p  points
#l  lines
#o  overplotted points and lines
#b, c	points (empty if "c") joined by lines
#s, S	stair steps
#h	histogram-like vertical lines
#n	does not produce any points or lines
plot(time, range$Global_active_power, ylab = "Global Active Power", type = "l")


# second plot (top-right)

plot(time, range$Voltage, xlab = "datetime", ylab = "Voltage", type = "l")


# third plot (bottom-left)

# type = "n" means no drawing
plot(time, range$Sub_metering_1, type = "n", ylab = "Energy sub metering", xlab = "")
lines(time, range$Sub_metering_1, col = "black")
lines(time, range$Sub_metering_2, col = "red")
lines(time, range$Sub_metering_3, col = "blue")

legend("topright",
       legend = c("Sub_matering_1", "Sub_matering_2", "Sub_matering_3"),
       lty = c(1, 1, 1), # type of symbol: line
       col = c("black", "red", "blue") # color
)


# fourth plot (bottom-right)
plot(time, range$Global_reactive_power, xlab = "datetime", type = "l")

# render/save file
dev.off()
