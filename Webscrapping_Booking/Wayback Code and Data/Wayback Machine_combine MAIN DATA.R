#Combine the Wayback Machine Data into one file

wd<-"/Users/JessicaBohning/Documents/Data Science/Projects/Pricing_Data/Booking/Wayback Machine DATA"
setwd(wd)
files<-list.files(path=wd, full.names=TRUE)
alldata<-data.frame(NULL)
len<-length(files)
for(i in 1:len){
        alldata<-rbind(alldata,read.csv(files[i]))
}

#Remove erroneous first column
alldata<-alldata[-1]
#Set Date Class
alldata$Date<-as.POSIXct(alldata$Date,format="%Y-%b-%d")

#Some dates appear more than once, so eliminate all but the first option
alldata<-subset(alldata, !duplicated(alldata$Date)) 

#Save data into "Main Results DATA" file
setwd("/Users/JessicaBohning/Documents/Data Science/Projects/Pricing_Data/Booking/Main Results DATA/")
write.csv(alldata,file="waybackmachine_alldata.csv")