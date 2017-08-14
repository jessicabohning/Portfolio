#Priceline Hotel Links
#Gets the following 4 Tuesday & Saturday prices (checking in on Tues and Sat)
library(lubridate)

#Get the actual dates for the next 4 tuesdays, wednesdays, saturdays, and sundays
today<-Sys.Date()
nextdays<-seq(today,today+40,by='day')
tuesdays<-nextdays[weekdays(nextdays)=='Tuesday']
tuesdays<-tuesdays[1:4]
wednesdays<-tuesdays+1
saturdays<-nextdays[weekdays(nextdays)=='Saturday']
saturdays<-saturdays[1:4]
sundays<-saturdays+1

#Convert them to character strings formatted as YYYYMMDD
tuesdays<-as.character(tuesdays,format="%Y%m%d")
wednesdays<-as.character(wednesdays,format="%Y%m%d")
saturdays<-as.character(saturdays,format="%Y%m%d")
sundays<-as.character(sundays,format="%Y%m%d")

#Get 8 urls per city, pasting their core urls with the dates

#Las Vegas, NV
#Example url: https://www.priceline.com/stay/search/hotels/3000015284/20170411/20170412/1/?searchType=CITY&page=1
Las_Vegas_tues<-data.frame(1:4)
Las_Vegas_sat<-data.frame(1:4)
for(i in 1:4){
        Las_Vegas_tues[i,]<-paste("https://www.priceline.com/stay/search/hotels/3000015284",tuesdays[i],wednesdays[i],"1/?searchType=CITY&page=1",sep="/")
        Las_Vegas_sat[i,]<-paste("https://www.priceline.com/stay/search/hotels/3000015284",saturdays[i],sundays[i],"1/?searchType=CITY&page=1",sep="/")
}
Las_Vegas_tues$location<-paste("Las_Vegas_Tuesday",tuesdays,sep="_")
Las_Vegas_tues$WEEKS_OUT<-c(1,2,3,4)
Las_Vegas_sat$location<-paste("Las_Vegas_Saturday",saturdays,sep="_")
Las_Vegas_sat$WEEKS_OUT<-c(1,2,3,4)


#NYC
#Example: https://www.priceline.com/stay/search/hotels/3000016152/20170404/20170405/1/?searchType=CITY&page=1
New_York_City_tues<-data.frame(1:4)
New_York_City_sat<-data.frame(1:4)
for(i in 1:4){
        New_York_City_tues[i,]<-paste("https://www.priceline.com/stay/search/hotels/3000016152",tuesdays[i],wednesdays[i],"1/?searchType=CITY&page=1",sep="/")
        New_York_City_sat[i,]<-paste("https://www.priceline.com/stay/search/hotels/3000016152",saturdays[i],sundays[i],"1/?searchType=CITY&page=1",sep="/")
}
New_York_City_tues$location<-paste("New_York_City_Tuesday",tuesdays,sep="_")
New_York_City_tues$WEEKS_OUT<-c(1,2,3,4)
New_York_City_sat$location<-paste("New_York_City_Saturday",saturdays,sep="_")
New_York_City_sat$WEEKS_OUT<-c(1,2,3,4)

#Washington DC
#Example: https://www.priceline.com/stay/search/hotels/3000003032/20170404/20170405/1?page=1
Washington_DC_tues<-data.frame(1:4)
Washington_DC_sat<-data.frame(1:4)
for(i in 1:4){
        Washington_DC_tues[i,]<-paste("https://www.priceline.com/stay/search/hotels/3000003032",tuesdays[i],wednesdays[i],"1/?searchType=CITY&page=1",sep="/")
        Washington_DC_sat[i,]<-paste("https://www.priceline.com/stay/search/hotels/3000003032",saturdays[i],sundays[i],"1/?searchType=CITY&page=1",sep="/")
}
Washington_DC_tues$location<-paste("Washington_DC_Tuesday",tuesdays,sep="_")
Washington_DC_tues$WEEKS_OUT<-c(1,2,3,4)
Washington_DC_sat$location<-paste("Washington_DC_Saturday",saturdays,sep="_")
Washington_DC_sat$WEEKS_OUT<-c(1,2,3,4)

#London
#Example: https://www.priceline.com/stay/search/hotels/3000035825/20170404/20170405/1?page=1
London_tues<-data.frame(1:4)
London_sat<-data.frame(1:4)
for(i in 1:4){
        London_tues[i,]<-paste("https://www.priceline.com/stay/search/hotels/3000035825",tuesdays[i],wednesdays[i],"1/?searchType=CITY&page=1",sep="/")
        London_sat[i,]<-paste("https://www.priceline.com/stay/search/hotels/3000035825",saturdays[i],sundays[i],"1/?searchType=CITY&page=1",sep="/")
}
London_tues$location<-paste("London_Tuesday",tuesdays,sep="_")
London_tues$WEEKS_OUT<-c(1,2,3,4)
London_sat$location<-paste("London_Saturday",saturdays,sep="_")
London_sat$WEEKS_OUT<-c(1,2,3,4)

#Paris
#Example: https://www.priceline.com/stay/search/hotels/3000035827/20170404/20170405/1?page=1
Paris_tues<-data.frame(1:4)
Paris_sat<-data.frame(1:4)
for(i in 1:4){
        Paris_tues[i,]<-paste("https://www.priceline.com/stay/search/hotels/3000035827",tuesdays[i],wednesdays[i],"1/?searchType=CITY&page=1",sep="/")
        Paris_sat[i,]<-paste("https://www.priceline.com/stay/search/hotels/3000035827",saturdays[i],sundays[i],"1/?searchType=CITY&page=1",sep="/")
}
Paris_tues$location<-paste("Paris_Tuesday",tuesdays,sep="_")
Paris_tues$WEEKS_OUT<-c(1,2,3,4)
Paris_sat$location<-paste("Paris_Saturday",saturdays,sep="_")
Paris_sat$WEEKS_OUT<-c(1,2,3,4)

#Berlin
#Example: https://www.priceline.com/stay/search/hotels/3000035821/20170404/20170405/1?page=1
Berlin_tues<-data.frame(1:4)
Berlin_sat<-data.frame(1:4)
for(i in 1:4){
        Berlin_tues[i,]<-paste("https://www.priceline.com/stay/search/hotels/3000035821",tuesdays[i],wednesdays[i],"1/?searchType=CITY&page=1",sep="/")
        Berlin_sat[i,]<-paste("https://www.priceline.com/stay/search/hotels/3000035821",saturdays[i],sundays[i],"1/?searchType=CITY&page=1",sep="/")
}
Berlin_tues$location<-paste("Berlin_Tuesday",tuesdays,sep="_")
Berlin_tues$WEEKS_OUT<-c(1,2,3,4)
Berlin_sat$location<-paste("Berlin_Saturday",saturdays,sep="_")
Berlin_sat$WEEKS_OUT<-c(1,2,3,4)

#Sydney
#Example: https://www.priceline.com/stay/search/hotels/3000040000/20170404/20170405/1?page=1
Sydney_tues<-data.frame(1:4)
Sydney_sat<-data.frame(1:4)
for(i in 1:4){
        Sydney_tues[i,]<-paste("https://www.priceline.com/stay/search/hotels/3000040000",tuesdays[i],wednesdays[i],"1/?searchType=CITY&page=1",sep="/")
        Sydney_sat[i,]<-paste("https://www.priceline.com/stay/search/hotels/3000040000",saturdays[i],sundays[i],"1/?searchType=CITY&page=1",sep="/")
}
Sydney_tues$location<-paste("Sydney_Tuesday",tuesdays,sep="_")
Sydney_tues$WEEKS_OUT<-c(1,2,3,4)
Sydney_sat$location<-paste("Sydney_Saturday",saturdays,sep="_")
Sydney_sat$WEEKS_OUT<-c(1,2,3,4)


#All Tuesday links
tuesdayurls<-rbind(Las_Vegas_tues,New_York_City_tues,Washington_DC_tues,
                        London_tues,Paris_tues,Berlin_tues,Sydney_tues)

#All Saturday links
saturdayurls<-rbind(Las_Vegas_sat,New_York_City_sat,Washington_DC_sat,
                         London_sat,Paris_sat,Berlin_sat,Sydney_sat)