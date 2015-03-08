## plot2.R

## Coursera: 
## Exploratory Data Analysis (Johns Hopkins): Course Project 1, part 2.
##
## Uses Electric power consumption data from the UC Irvine Machine Learning Repository:
## https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
## (unzip in working dir to produce Input file needed)
##
## Input: "household_power_consumption.txt"
## Output: plot2.png (Date vs Global_active_power)

library(dplyr)

filename<-"household_power_consumption.txt"
data<-read.fwf(filename,header=TRUE,sep=";",widths=70,na.strings="?")

#only using data from the dates 2007-02-01 and 2007-02-02:
data$Date<-as.Date(data$Date,"%d/%m/%Y")          #class: Date
data.filt<-filter(data,Date=="2007-02-01" | Date=="2007-02-02")

#get the date/time info in one column:
data.filt<-mutate(data.filt,DateTime=paste(data.filt$Date,data.filt$Time))
data.filt$DateTime<-strptime(data.filt$DateTime,"%Y-%m-%d %H:%M:%S") #class: "POSIXlt" "POSIXt" 
data.filt$DateTime<-as.POSIXct(data.filt$DateTime)                   #class: "POSIXct" "POSIXt" 

#PLOT 2 (Date vs Global_active_power):
png("plot2.png",width=480,height=480,units="px",bg="transparent") 
data.filt$Global_active_power<-as.numeric(as.character(data.filt$Global_active_power))
plot(data.filt$DateTime,data.filt$Global_active_power,
     type="l",
     col="black",
     xlab="",
     ylab="Global Active Power (kilowatts)")

dev.off()