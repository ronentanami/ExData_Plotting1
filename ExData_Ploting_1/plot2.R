## plot2.R
## This function plots the Global Active Power as a function of day in the week

setwd("~/Data Science/Exploratory Data Analysis/Work")  ## Setting home directry

library(data.table)
DT <- fread("household_power_consumption.txt")  ## Reading the file into data table

FebDT <- subset(DT,Date == '1/2/2007' | Date == '2/2/2007')  ## Subsetting 2 days in February

par(oma = c(1,1,1,1))

with(FebDT, plot(strptime(paste(Date,Time), "%d/%m/%Y %H:%M:%S"),Global_active_power , 
                 type = 'l',
                 col = "black",
                 xlab = "",
                 ylab = "Global Active Power (kilowatts)"))

box(col="black")


dev.copy(png, file = "plot2.png")  ## Copying histogram to PNG file
dev.off()




