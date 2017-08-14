
#Combine the Wayback Machine Data into one file

wd<-"/Users/JessicaBohning/Documents/Data Science/Projects/Pricing_Data/Booking/Wayback Machine DATA_COUNTRY"
setwd(wd)
files<-list.files(path=wd, full.names=TRUE)
alldata_country<-data.frame(NULL)
len<-length(files)
for(i in 1:len){
        alldata_country<-rbind(alldata_country,read.csv(files[i]))
}

#Remove erroneous first column
alldata_country<-alldata_country[-1]
#Set Date Class
alldata_country$Date<-as.POSIXct(alldata_country$Date,format="%Y-%b-%d")

#Save data into "Main Results DATA" file
setwd("/Users/JessicaBohning/Documents/Data Science/Projects/Pricing_Data/Booking/Country DATA/")
write.csv(alldata_country,file="waybackmachine_allcountrydata.csv")
