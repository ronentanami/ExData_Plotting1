## plot3.R
## This function plots the Energy Sub Meetering as a function of day in the week break by Sub meetering

setwd("~/Data Science/Exploratory Data Analysis/Work")  ## Setting home directry

library(data.table)
DT <- fread("household_power_consumption.txt")  ## Reading the file into data table

FebDT <- subset(DT,Date == '1/2/2007' | Date == '2/2/2007')  ## Subsetting 2 days in February

par(oma = c(1,1,1,1))

with(FebDT, plot(strptime(paste(Date,Time), "%d/%m/%Y %H:%M:%S"),Sub_metering_1 , 
                 type = 'l',
                 col = "black",
                 xlab = "",
                 ylab = "Energy sub meetering"))

with(FebDT, lines(strptime(paste(Date,Time), "%d/%m/%Y %H:%M:%S"),Sub_metering_2, col = "red"))
with(FebDT, lines(strptime(paste(Date,Time), "%d/%m/%Y %H:%M:%S"),Sub_metering_3, col = "blue"))

box(col="black")
legend("topright", lty = c(1,1,1), col = c("black","red","blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))


dev.copy(png, file = "plot3.png")  ## Copying histogram to PNG file
dev.off()




