## plot4.R

## Coursera: 
## Exploratory Data Analysis (Johns Hopkins): Course Project 1, part 4.
##
## Uses Electric power consumption data from the UC Irvine Machine Learning Repository:
## https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
## (unzip in working dir to produce Input file needed)
##
## Input: "household_power_consumption.txt" 
## Output: plot4.png
##           --> 4 subplots:  a) Date vs Global Active Power
##                            b) datetime vs Voltage
##                            c) Date vs Energy sub metering
##                            d) datetime vs Global_reactive_power

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

#PLOT 4:
png("plot4.png",width=480,height=480,units="px",bg="transparent") 
par(mfrow=c(2,2))
#a) Date vs Global Active Power
data.filt$Global_active_power<-as.numeric(as.character(data.filt$Global_active_power))
plot(data.filt$DateTime,data.filt$Global_active_power,
     type="l",
     col="black",
     xlab="",
     ylab="Global Active Power")

#b) datetime vs Voltage
data.filt$Voltage<-as.numeric(as.character(data.filt$Voltage))
plot(data.filt$DateTime,data.filt$Voltage,type="l",
     col="black",
     xlab="datetime",
     ylab="Voltage")

#c) Date vs Energy sub metering
plot(data.filt$DateTime,data.filt$Sub_metering_1,type="l",
     col="black",
     xlab="",
     ylab="Energy sub metering")
lines(data.filt$DateTime,data.filt$Sub_metering_2,col="red")
lines(data.filt$DateTime,data.filt$Sub_metering_3,col="blue")
legend.txt<-c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
legend("topright",legend.txt,col=c("black","red","blue"),lty=c(1,1,1),bty = "n")

#d) datetime vs Global_reactive_power
data.filt$Global_reactive_power<-as.numeric(as.character(data.filt$Global_reactive_power))
plot(data.filt$DateTime,data.filt$Global_reactive_power,
     type="l",
     col="black",
     xlab="datetime",
     ylab="Global_reactive_power")

dev.off()