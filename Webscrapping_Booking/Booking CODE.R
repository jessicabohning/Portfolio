library(rvest)
library(ggplot2)
library(gridExtra)
library(RSelenium)
library(wdman)

mainurl<-"http://www.booking.com/index.html?label=gen173nr-1FCAEoggJCAlhYSDNiBW5vcmVmcgV1c19tb4gBAZgBMbgBB8gBDNgBAegBAfgBAqgCAw;sid=96686802ac9fd5657590aaff5fbbae00;click_from_logo=1"
pDrv <- phantomjs(port = 4567L)
remDr <- remoteDriver(browserName = "phantomjs", port = 4567L)
remDr$open(silent=TRUE)
remDr$navigate(mainurl)
Sys.sleep(10+rnorm(1))
mainresults <- read_html(remDr$getPageSource()[[1]])%>%
        html_nodes("#usp_choice") %>%
        html_text()
mainreviews_count<-read_html(remDr$getPageSource()[[1]]) %>%
        html_nodes("#usp_review h3") %>%
        html_text()
# Close session
remDr$close()
pDrv$stop()

#Cleanup data
mainresults_edited<-gsub(",",'',mainresults)
mainresults_edited<-regmatches(mainresults_edited,gregexpr('[0-9]+',
                                                           mainresults_edited))
mainresults_edited<-do.call(rbind.data.frame, mainresults_edited)
names(mainresults_edited)<-c("Properties_Worldwide","Vacation_Rentals","Destinations","Countries")
mainresults_edited$Date<-Sys.Date()
mainreviews_count_edited<-gsub(",",'',mainreviews_count)
mainreviews_count_edited<-regmatches(mainreviews_count_edited,
                                     gregexpr('[0-9]+',mainreviews_count_edited))
mainreviews_count_edited$Date<-Sys.Date()


#allcountries
countriesurl<-"https://www.booking.com/country.html?label=gen173nr-1FCAEoggJCAlhYSDNiBW5vcmVmcgV1c19tb4gBAZgBMbgBB8gBDNgBAegBAfgBAqgCAw;sid=96686802ac9fd5657590aaff5fbbae00"
pDrv <- phantomjs(port = 4567L)
remDr <- remoteDriver(browserName = "phantomjs", port = 4567L)
remDr$open(silent=TRUE)
remDr$navigate(countriesurl)
Sys.sleep(10+rnorm(1))
countriesresults<-read_html(remDr$getPageSource()[[1]]) %>%
        html_nodes(".block_header") %>%
        html_text()
# Close session
remDr$close()
pDrv$stop()

countriesresults_edited<-gsub(pattern="\n",replacement="",countriesresults)
temp1<-gsub('[[:digit:]]+', '', countriesresults_edited)
temp1<-gsub(pattern="  hotels",'',temp1)
temp2<-regmatches(countriesresults,gregexpr('[0-9]+',countriesresults))
#countriesresults_edited<-data.frame(cbind(temp1,temp2))
countriesresults_edited<-data.frame(cbind(temp1,do.call("rbind", temp2)))
names(countriesresults_edited)<-c("Country","Hotels")
countriesresults_edited$Date<-Sys.Date()

allbookingdata<-merge(mainresults_edited,mainreviews_count_edited,by.x="Date",by.y="Date")
allbookingdata_names<-names(allbookingdata)
allbookingdata_names[6]<-"Review_Count"
names(allbookingdata)<-allbookingdata_names

#United states (which doesn't show up on the main country webpage)
usaurl<-"https://www.booking.com/country/us.html?aid=304142;label=gen173nr-1FCAEoggJCAlhYSDNiBW5vcmVmcgV1c19tb4gBAZgBMbgBB8gBDNgBAegBAfgBApICAXmoAgM;sid=2c2bcdff4862875fad41076b61b1a013"
pDrv <- phantomjs(port = 4567L)
remDr <- remoteDriver(browserName = "phantomjs", port = 4567L)
remDr$open(silent=TRUE)
remDr$navigate(usaurl)
Sys.sleep(10+rnorm(1))
usaresults<-read_html(remDr$getPageSource()[[1]]) %>%
        html_nodes("#breadcrumb span") %>%
        html_text()
# Close session
remDr$close()
pDrv$stop()

#Get rid of everything but the numbers
usaresults_edited<-gsub(pattern="\n",replacement="",usaresults)
usaresults_edited<-gsub(pattern=" properties",replacement="",usaresults_edited)
usaresults_edited<-gsub(pattern=",",replacement="",usaresults_edited)
usaresults_edited<-as.numeric(usaresults_edited)
usaresults_edited<-data.frame("United States",usaresults_edited,Sys.Date())
names(usaresults_edited)<-c("Country", "Hotels","Date")

#Save data- created so we can't overwrite previous day's data (but can overwrite today's data)
filename1<-paste("/Users/JessicaBohning/Documents/Data Science/Projects/Portfolio/Webscraping_Booking/Country DATA/Country Data",Sys.Date(),".csv")
write.csv(countriesresults_edited,file=filename1)
filename2<-paste("/Users/JessicaBohning/Documents/Data Science/Projects/Portfolio/Webscraping_Booking/Main Results DATA/Main Results",Sys.Date(),".csv")
write.csv(allbookingdata,file=filename2)
filename3<-paste("/Users/JessicaBohning/Documents/Data Science/Projects/Portfolio/Webscraping_Booking/USA DATA/USA Results",Sys.Date(),".csv")
write.csv(usaresults_edited,file=filename3)

#Combine the files into one data frame: Main Data First
files<-list.files(path="/Users/JessicaBohning/Documents/Data Science/Projects/Portfolio/Webscraping_Booking/Main Results DATA", full.names=TRUE)
alldata_main<-data.frame(NULL)
len<-length(files)
for(i in 1:len){
        alldata_main<-rbind(alldata_main,read.csv(files[i]))
}

#Combine the files into one data frame: Country data next
files<-list.files(path="/Users/JessicaBohning/Documents/Data Science/Projects/Portfolio/Webscraping_Booking/Country DATA", full.names=TRUE)
alldata_country<-data.frame(NULL)
len<-length(files)
for(i in 1:len){
        alldata_country<-rbind(alldata_country,read.csv(files[i]))
}

#Eliminate the erroneous first column
alldata_main<-alldata_main[,-1]
alldata_country<-alldata_country[,-1]

#Set the date class & country character class
alldata_main$Date<-as.POSIXct(alldata_main$Date,format="%Y-%m-%d")
alldata_country$Date<-as.POSIXct(alldata_country$Date,format="%Y-%m-%d")
alldata_country$Country<-as.character(alldata_country$Country)

#Get continent mapping data
continents<-read.csv("/Users/JessicaBohning/Documents/Data Science/Projects/Portfolio/Webscraping_Booking/Country to Continent List.csv")
continents$Country<-as.character(continents$Country)

#Curaçao fails (due to special symbol) so manually enter it.
continents<-rbind(continents,c("Curaçao","South America"))

#Map the countries to their continents in the alldata_country data
mergedcountrydata<-merge(alldata_country,continents,all.x=TRUE,by.x="Country",
                         by.y="Country")

#Add USA in
files<-list.files(path="/Users/JessicaBohning/Documents/Data Science/Projects/Portfolio/Webscraping_Booking/USA DATA", full.names=TRUE)
alldata_USA<-data.frame(NULL)
len<-length(files)
for(i in 1:len){
        alldata_USA<-rbind(alldata_USA,read.csv(files[i]))
}
#Eliminate the erroneous first column
alldata_USA<-alldata_USA[-1]
alldata_USA$Continent<-"North America"
alldata_USA$Date<-as.POSIXct(alldata_USA$Date,format="%Y-%m-%d")

#Add to merged country data
mergedcountrydata<-rbind(mergedcountrydata,alldata_USA)

#Save the combined data
filepath1<-"/Users/JessicaBohning/Documents/Data Science/Projects/Portfolio/Webscraping_Booking/ALLDATA_MAIN.csv"
filepath2<-"/Users/JessicaBohning/Documents/Data Science/Projects/Portfolio/Webscraping_Booking/ALLDATA_COUNTRIES.csv"
write.csv(alldata_main,file=filepath1)
write.csv(mergedcountrydata,file=filepath2)

#Graphing the data from the main webpage
plot1<-ggplot(alldata_main,aes(x=Date,y=Properties_Worldwide))+geom_line()+
        ggtitle("Booking.com: Number of Properties Worldwide")+
        xlab(NULL)+ylab(NULL)+
        theme(plot.title=element_text(hjust=0.5),
              axis.text.x = element_text(angle = 90, hjust = 1))
plot2<-ggplot(alldata_main,aes(x=Date,y=Vacation_Rentals))+geom_line()+
        ggtitle("Booking.com: Number of Vacation Rentals")+
        xlab(NULL)+ylab(NULL)+
        theme(plot.title=element_text(hjust=0.5),
              axis.text.x = element_text(angle = 90, hjust = 1))
plot3<-ggplot(alldata_main,aes(x=Date,y=Destinations))+geom_line()+
        ggtitle("Booking.com: Number of Destinations")+
        xlab(NULL)+ylab(NULL)+
        theme(plot.title=element_text(hjust=0.5),
              axis.text.x = element_text(angle = 90, hjust = 1))
plot4<-ggplot(alldata_main,aes(x=Date,y=Review_Count))+geom_line()+
        ggtitle("Booking.com: Number of Customer Reviews")+
        xlab(NULL)+ylab(NULL)+
        theme(plot.title=element_text(hjust=0.5),
              axis.text.x = element_text(angle = 90, hjust = 1))

countrygraphlist<-c("United States","United Kingdom (the UK) hotels","Germany",
                    "France","Venezuela","Argentina","Mexico","South Africa",
                    "Russia (Russian Fed.) hotels",
                    "United Arab Emirates (U.A. Emirates) hotels",
                    "Saudi Arabia","India","China","Thailand","Australia",
                    "Jamaica")
reducedcountries<-mergedcountrydata[mergedcountrydata$Country %in% countrygraphlist,]
reducedcountries$Country<-gsub(pattern="United Kingdom (the UK) hotels",
                               replacement="United Kingdom",
                               x=reducedcountries$Country, fixed=TRUE)
reducedcountries$Country<-gsub(pattern="United Arab Emirates (U.A. Emirates) hotels",
                               replacement="United Arab Emirates",
                               x=reducedcountries$Country, fixed=TRUE)
reducedcountries$Country<-gsub(pattern="Russia (Russian Fed.) hotels",
                               replacement="Russia",
                               x=reducedcountries$Country, fixed=TRUE)

#Get data for the past 90 days to highlight more recent data in the graphs
dateposixct_90<-as.POSIXct(Sys.Date()-90,format="%Y-%m-%d")
alldata_main_90<-alldata_main[alldata_main$Date>=dateposixct_90,]
plot5<-ggplot(alldata_main_90,aes(x=Date,y=Properties_Worldwide))+geom_line()+
        ggtitle("Number of Properties Worldwide in the Past 90 Days")+
        xlab(NULL)+ylab(NULL)+
        theme(plot.title=element_text(hjust=0.5),
              axis.text.x = element_text(angle = 90, hjust = 1))
plot6<-ggplot(alldata_main_90,aes(x=Date,y=Vacation_Rentals))+geom_line()+
        ggtitle("Number of Vacation Rentals in the Past 90 Days")+
        xlab(NULL)+ylab(NULL)+
        theme(plot.title=element_text(hjust=0.5),
              axis.text.x = element_text(angle = 90, hjust = 1))
plot7<-ggplot(alldata_main_90,aes(x=Date,y=Destinations))+geom_line()+
        ggtitle("Number of Destinations in the Past 90 Days")+
        xlab(NULL)+ylab(NULL)+
        theme(plot.title=element_text(hjust=0.5),
              axis.text.x = element_text(angle = 90, hjust = 1))
plot8<-ggplot(alldata_main_90,aes(Date,y=Review_Count))+geom_line()+
        ggtitle("Number of Customer Reviews in the Past 90 Days")+
        xlab(NULL)+ylab(NULL)+
        theme(plot.title=element_text(hjust=0.5),
              axis.text.x = element_text(angle = 90, hjust = 1))

pdf("/Users/JessicaBohning/Documents/Data Science/Projects/Portfolio/Webscraping_Booking/Summary Stats.pdf",paper="a4r",width=10,height=7)
grid.arrange(plot1,plot2,plot3,plot4,ncol=2,widths=unit(c(5,5),"inches"),
             heights=unit(c(3,3),"inches"))
grid.arrange(plot5,plot6,plot7,plot8,ncol=2,widths=unit(c(5,5),"inches"),
             heights=unit(c(3,3),"inches"))
ggplot(reducedcountries,aes(x=Date,y=Hotels))+geom_line()+
        facet_wrap(~Country, ncol=4, scales="free")+
        theme(plot.title=element_text(hjust=0.5),
              axis.text.x = element_text(angle = 90, hjust = 1))
dev.off()








