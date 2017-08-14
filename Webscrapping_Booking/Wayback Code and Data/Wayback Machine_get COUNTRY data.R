#Using Wayback Machine to Get old Booking.com data

#Get array of urls
startdate<-as.Date("2017/2/26",format="%Y/%m/%d")
number_of_days<-50

#First Get a List of Dates
datelist<-NULL
for (i in 0:(number_of_days-1)){
        datelist<-rbind(datelist,startdate+i)
}
datelist<-as.Date(datelist,format="%Y-%m-%d")

#Format those dates like "201701011"
datelist<-as.character(datelist)
datelist<-gsub(pattern="-",replacement = "",x=datelist)

#Get URLS
url_list<-NULL
for (i in 1:length(datelist)){
        url_list<-rbind(url_list,paste("https://web.archive.org/web/",datelist[i],
                                       "/http://www.booking.com/country.html",sep=""))
}


#Scrape data
scraped_data<-NULL
for (i in 1:length(url_list)){
        scraping<-read_html(url_list[i])
        countriesresults<-scraping %>%
                html_nodes(".block_header") %>%
                html_text()
        month<-scraping %>%
                html_nodes("#displayMonthEl") %>%
                html_text()
        day<-scraping %>%
                html_nodes("#displayDayEl") %>%
                html_text()
        year<-scraping %>%
                html_nodes("#displayYearEl") %>%
                html_text()
        date<-paste(year,month,day,sep="-")
        countriesresults_temp<-data.frame(countriesresults)
        countriesresults_temp$Date<-date
        scraped_data<-rbind(scraped_data,countriesresults_temp)
}

#Clean it up
countriesresults_edited<-gsub(pattern="\n",replacement="",scraped_data$countriesresults)
temp1<-gsub('[[:digit:]]+', '', countriesresults_edited)
temp1<-gsub(pattern="  hotels",'',temp1)
temp2<-regmatches(scraped_data$countriesresults,gregexpr('[0-9]+',scraped_data$countriesresults))
#countriesresults_edited<-data.frame(cbind(temp1,temp2))
countriesresults_edited<-data.frame(cbind(temp1,do.call("rbind", temp2)))
names(countriesresults_edited)<-c("Country","Hotels")
countriesresults_edited$Date<-scraped_data$Date

#Save data
setwd("/Users/JessicaBohning/Documents/Data Science/Projects/Pricing_Data/Booking/Wayback Machine DATA_COUNTRY/")
filename<-paste("wayback_machine_country",startdate,number_of_days,sep="_")
filename<-paste(filename,".csv",sep="")
write.csv(countriesresults_edited,file=filename)

