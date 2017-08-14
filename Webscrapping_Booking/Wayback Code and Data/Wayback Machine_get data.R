#Using Wayback Machine to Get old Booking.com data

#Get array of urls
startdate<-as.Date("2015/12/17",format="%Y/%m/%d")
number_of_days<-14

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
                        "/http://www.booking.com/",sep=""))
}


#Scrape data
scraped_data<-NULL
for (i in 1:length(url_list)){
        scraping<-read_html(url_list[i])
        mainresults<-scraping %>%
                html_nodes("#usp_choice") %>%
                html_text()
        mainreviews_count<-scraping %>%
                html_nodes("#usp_review h3") %>%
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
        scraped_data<-rbind(scraped_data,
                            cbind(mainresults,mainreviews_count,month,day,year))
}


scraped_data<-data.frame(scraped_data)
#Clean up data
scraped_data$mainresults<-gsub(",",'',scraped_data$mainresults)
scraped_data$mainresults<-regmatches(scraped_data$mainresults,
                                     gregexpr('[0-9]+',scraped_data$mainresults))
mainresults_edited<-do.call(rbind.data.frame, scraped_data$mainresults)
names(mainresults_edited)<-c("Properties_Worldwide","Vacation_Rentals","Destinations","Countries")
scraped_data_edited<-mainresults_edited

mainreviews_count_edited<-gsub(",",'',scraped_data$mainreviews_count)
mainreviews_count_edited<-regmatches(mainreviews_count_edited,
                                     gregexpr('[0-9]+',mainreviews_count_edited))
mainreviews_count_edited<-data.frame(do.call("rbind",mainreviews_count_edited))
scraped_data_edited<-cbind(scraped_data_edited,mainreviews_count_edited)

names(scraped_data_edited)<-c("Properties_Worldwide","Vacation_Rentals",
                              "Destinations","Countries","Review_Count")

#Clean Up dates and add into scraped_data_edited
scraped_data$date<-paste(scraped_data$year,scraped_data$month,scraped_data$day,
                         sep="-")
scraped_data_edited$Date<-scraped_data$date

setwd("/Users/JessicaBohning/Documents/Data Science/Projects/Pricing_Data/Booking/Wayback Machine DATA/")
filename<-paste("wayback_machine",startdate,number_of_days,sep="_")
filename<-paste(filename,".csv",sep="")
write.csv(scraped_data_edited,file=filename)



        