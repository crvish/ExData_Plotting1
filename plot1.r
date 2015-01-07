	
#libraries required

library(lubridate)
library(dplyr)
library(ggplot2)
#converting the data to a data frame assume that the unzipped file is in the working directory 
 # loading the column names to a vector
 
 col_names <- c("Date","Time","Global_active_power","Global_reactive_power", "Voltage","Global_intensity","Sub_metering_1","Sub_metering_2", "Sub_metering_3")
 
# Reading the data into a dataframe call pow1. We start reading at 
#row number 66638 and read 2880 rows. i found that out by actually 
#looking at the data in the raw data form 

pow1 <- read.table("household_power_consumption.txt",sep =";",nrows =2880,skip=66637,col.names = col_names,na.strings = "?",stringsAsFactors = FALSE)

# find out if there are any NA 
sum(!is.na(select(pow,Date:Sub_metering_3)))
# we get the answer [1] 25920. there are 2880 rows and 9 columns 2880*9= 25920

# so we have clean data 

# convert the character date/time fields to a single consolidate date/time field using lubridate

  pow <- mutate(pow1,Date_Time = dmy_hms(paste(Date,Time)))
  
  #cleaning up and reording the dataset by removing character time/date fields
  
powr_final <- select(pow, Global_active_power:Date_Time)

#Drawing the first plot
hist(pow$Global_active_power, xlab = "Global Active Power   (kilowatts)",ylab = "frequency", col = "red", main = "Global Active Power")
#writing to file 
dev.copy(png, file = "plot1.png", width = 480, height = 480)
dev.off()
