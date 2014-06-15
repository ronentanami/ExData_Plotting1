## plot1.R
## This function plots the Global Active Power Frequency Histogram

setwd("~/Data Science/Exploratory Data Analysis/Work")  ## Setting home directry

library(data.table)
DT <- fread("household_power_consumption.txt")  ## Reading the file into data table

FebDT <- subset(DT,Date == '1/2/2007' | Date == '2/2/2007')  ## Subsetting 2 days in February

par(oma = c(1,1,1,1))

hist(as.numeric(FebDT$Global_active_power), 
     col = "red" , 
     main = "GLobal Active Power", 
     xlab = 'Global Active Power (kilowatts)', 
     ylab = "Frequency",
     ylim = c(0,1300)
)

dev.copy(png, file = "plot1.png")  ## Copying histogram to PNG file
dev.off()




