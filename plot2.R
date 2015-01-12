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
png("plot2.png")

# limit margins, you can check defaults with: par()$mar
# order is bottom, left, top, right
par(mar = c(2.1, 4.1, 0.1, 0.1))

#type  description
#p	points
#l	lines
#o	overplotted points and lines
#b, c	points (empty if "c") joined by lines
#s, S	stair steps
#h	histogram-like vertical lines
#n	does not produce any points or lines
plot(time, range$Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")

# render/save file
dev.off()

