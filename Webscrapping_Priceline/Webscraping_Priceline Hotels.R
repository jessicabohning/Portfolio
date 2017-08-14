library(rvest)
library(RSelenium)
library(wdman)
library(stringr)
library(dplyr)
library(RColorBrewer)
library(ggplot2)

################################################################################################

source("/Users/JessicaBohning/Documents/Data Science/Projects/Portfolio/Webscrapping_Priceline/Hotel_links.R")

#Tuesday Data Grab
print("Attempting Tuesday Webscrape")
tuesdaydata<-data.frame(NULL)
tuesdayresults<-data.frame(NULL)
tuesdayfailuredata<-data.frame(NULL)
pDrv <- phantomjs(port = 4567L)
remDr <- remoteDriver(browserName = "phantomjs", port = 4567L)
remDr$open(silent=TRUE)
for (i in 1:length(tuesdayurls$X1.4)){
        print(paste("Tuesday Loop",i,"of",length(tuesdayurls$X1.4),"starting"))
        remDr$navigate(tuesdayurls$X1.4[i])
        Sys.sleep(10+rnorm(1))
        test.html <- read_html(remDr$getPageSource()[[1]])
        #Sys.sleep(20+rnorm(1))
        test<-test.html%>%
                html_nodes(".top")%>%
                html_text()
        test2<-cbind(test,tuesdayurls$location[i],tuesdayurls$WEEKS_OUT[i])
        resultstemp<-test.html%>%
                html_nodes(".itin-summary")%>%
                html_text()
        if(length(test)==0){
                print(paste("Loop",i,"Failed"))
                tuesdayfailuredata<-rbind(tuesdayfailuredata,tuesdayurls[i,])
                
        }
        else{
                resultstemp2<-cbind(resultstemp,tuesdayurls$location[i],tuesdayurls$WEEKS_OUT[i])
                tuesdayresults<-rbind(tuesdayresults,resultstemp2)
                tuesdaydata<-rbind(tuesdaydata,test2)
        }
        
}

# clean up
remDr$close()
pDrv$stop()

print("Attempting Tuesday Failures Again")
#Try the tuesday failure data again
if(length(tuesdayfailuredata$location>0)){
        pDrv <- phantomjs(port = 4567L)
        remDr <- remoteDriver(browserName = "phantomjs", port = 4567L)
        remDr$open(silent=TRUE)
        for (i in 1:length(tuesdayfailuredata$X1.4)){
                print(paste("Tuesday Failure Loop",i,"of",length(tuesdayfailuredata$X1.4),"starting"))
                remDr$navigate(tuesdayfailuredata$X1.4[i])
                Sys.sleep(30+rnorm(1))
                test.html <- read_html(remDr$getPageSource()[[1]])
                #Sys.sleep(20+rnorm(1))
                test<-test.html%>%
                        html_nodes(".top")%>%
                        html_text()
                test2<-cbind(test,tuesdayfailuredata$location[i],tuesdayfailuredata$WEEKS_OUT[i])
                resultstemp<-test.html%>%
                        html_nodes(".itin-summary")%>%
                        html_text()
                if(length(test)==0){
                        print(paste("Loop",i,"Failed"))
                }
                else{
                        resultstemp2<-cbind(resultstemp,tuesdayfailuredata$location[i],tuesdayfailuredata$WEEKS_OUT[i])
                        tuesdayresults<-rbind(tuesdayresults,resultstemp2)
                        tuesdaydata<-rbind(tuesdaydata,test2)
                }
                
        }
        
        # clean up
        remDr$close()
        pDrv$stop()
}

#SATURDAY GRABS
print("Attempting Saturday Webscrape")
saturdaydata<-data.frame(NULL)
saturdayresults<-data.frame(NULL)
saturdayfailuredata<-data.frame(NULL)
pDrv <- phantomjs(port = 4567L)
remDr <- remoteDriver(browserName = "phantomjs", port = 4567L)
remDr$open(silent=TRUE)
for (i in 1:length(saturdayurls$X1.4)){
        print(paste("Saturday Loop",i,"of",length(saturdayurls$X1.4),"starting"))
        remDr$navigate(saturdayurls$X1.4[i])
        Sys.sleep(10+rnorm(1))
        test.html <- read_html(remDr$getPageSource()[[1]])
        #Sys.sleep(20+rnorm(1))
        test<-test.html%>%
                html_nodes(".top")%>%
                html_text()
        test2<-cbind(test,saturdayurls$location[i],saturdayurls$WEEKS_OUT[i])
        resultstemp<-test.html%>%
                html_nodes(".itin-summary")%>%
                html_text()
        if(length(test)==0){
                print(paste("Loop",i,"Failed"))
                saturdayfailuredata<-rbind(saturdayfailuredata,saturdayurls[i,])
                
        }
        else{
                resultstemp2<-cbind(resultstemp,saturdayurls$location[i],saturdayurls$WEEKS_OUT[i])
                saturdayresults<-rbind(saturdayresults,resultstemp2)
                saturdaydata<-rbind(saturdaydata,test2)
        }
        
}

# clean up
remDr$close()
pDrv$stop()

print("Attempting Saturday Failures Again")
#Try the saturday failure data again
if(length(saturdayfailuredata$location>0)){
        pDrv <- phantomjs(port = 4567L)
        remDr <- remoteDriver(browserName = "phantomjs", port = 4567L)
        remDr$open(silent=TRUE)
        for (i in 1:length(saturdayfailuredata$X1.4)){
                print(paste("Saturday Failure Loop",i,"of",length(saturdayfailuredata$X1.4),"starting"))
                remDr$navigate(saturdayfailuredata$X1.4[i])
                Sys.sleep(30+rnorm(1))
                test.html <- read_html(remDr$getPageSource()[[1]])
                #Sys.sleep(20+rnorm(1))
                test<-test.html%>%
                        html_nodes(".top")%>%
                        html_text()
                test2<-cbind(test,saturdayfailuredata$location[i],saturdayfailuredata$WEEKS_OUT[i])
                resultstemp<-test.html%>%
                        html_nodes(".itin-summary")%>%
                        html_text()
                if(length(test)==0){
                        print(paste("Loop",i,"Failed"))
                }
                else{
                        resultstemp2<-cbind(resultstemp,saturdayfailuredata$location[i],saturdayfailuredata$WEEKS_OUT[i])
                        saturdayresults<-rbind(saturdayresults,resultstemp2)
                        saturdaydata<-rbind(saturdaydata,test2)
                }
                
        }
        
        # clean up
        remDr$close()
        pDrv$stop()
}

print("Webscrapes Complete; Begin Tuesday Cleanings")
#Eliminate the "\n" and areas with 2 or more spaces:
test<-tuesdaydata
test$test<-gsub("\n",'',test$test)
test$test<-gsub("  ",'',test$test)
#Eliminate the "ON SALE" messages 
test$test<-gsub("ON SALESign in now and pay less. Unless, of course, you don't like lower prices...Sign In",
           '',test$test)
test$test<-gsub("ON SALE",'',test$test)
test$test<-gsub("Sign in now and pay less. Unless, of course, you don't like lower prices...Sign In",
           '',test$test)
#Grab hotel name i.e. everything before the "-"
hotel_name<-sapply(strsplit(test$test, "\\-"), `[[`, 1)
hotel_name<-gsub("\\.","",hotel_name) #Eliminate the periods
hotel_name<-gsub('[[:digit:]]+', '', hotel_name) #Elimiate the numbers
hotel_name<-str_trim(hotel_name,"left") #Elimiate leading white space
hotel_name<-str_trim(hotel_name,"right") #Elimiate trialing white space
#Get price strings which are formatted with $##Choose, and if there is a 
#sale, the orginal price is formatted as ##from
cost<-substring(sapply(strsplit(test$test, "\\$"), `[[`, 2), 1, 20) #grabs the first 20 characters after the $
#Find original prices for those hotels with sales
presaleprice<-sapply(strsplit(cost, "\\from"), `[[`, 1)
presaleprice<-gsub("\\w+ *Choose",'NA',presaleprice)
presaleprice<-gsub("from","",presaleprice)
#Find final price for all hotels (sale or no sale)
price<-gsub("^.*\\$","", test$test)
price<-gsub("Choose","",price)
#Get review score (keep only the numbers)
score<-gsub("^.*\\:","", test$test)
score<-gsub("\\ reviews.*","",score)
score<-gsub(pattern=" verified guest",replacement="",score)
score<-str_trim(score,"left") #Eliminate leading white space

alldatatuesday<-data.frame(hotel_name,score,presaleprice,price,test$V2,test$V3)

filename<-paste("/Users/JessicaBohning/Documents/Data Science/Projects/Portfolio/Webscrapping_Priceline/TUESDAY DATA/Tuesday Priceline Hotel Data ",Sys.Date(),".csv",sep="")
write.csv(alldatatuesday,file=filename)

print("Webscrapes Complete; Begin Saturday Cleanings")
#Eliminate the "\n" and areas with 2 or more spaces:
test<-saturdaydata
test$test<-gsub("\n",'',test$test)
test$test<-gsub("  ",'',test$test)
#Eliminate the "ON SALE" messages 
test$test<-gsub("ON SALESign in now and pay less. Unless, of course, you don't like lower prices...Sign In",
                '',test$test)
test$test<-gsub("ON SALE",'',test$test)
test$test<-gsub("Sign in now and pay less. Unless, of course, you don't like lower prices...Sign In",
                '',test$test)
#Grab hotel name i.e. everything before the "-"
hotel_name<-sapply(strsplit(test$test, "\\-"), `[[`, 1)
hotel_name<-gsub("\\.","",hotel_name) #Eliminate the periods
hotel_name<-gsub('[[:digit:]]+', '', hotel_name) #Elimiate the numbers
hotel_name<-str_trim(hotel_name,"left") #Elimiate leading white space
hotel_name<-str_trim(hotel_name,"right") #Elimiate trialing white space
#Get price strings which are formatted with $##Choose, and if there is a 
#sale, the orginal price is formatted as ##from
cost<-substring(sapply(strsplit(test$test, "\\$"), `[[`, 2), 1, 20) #grabs the first 20 characters after the $
#Find original prices for those hotels with sales
presaleprice<-sapply(strsplit(cost, "\\from"), `[[`, 1)
presaleprice<-gsub("\\w+ *Choose",'NA',presaleprice)
presaleprice<-gsub("from","",presaleprice)
#Find final price for all hotels (sale or no sale)
price<-gsub("^.*\\$","", test$test)
price<-gsub("Choose","",price)
#Get review score
score<-gsub("^.*\\:","", test$test)
score<-gsub("\\ reviews.*","",score)
score<-gsub(pattern=" verified guest",replacement="",score)
score<-str_trim(score,"left") #Eliminate leading white space

alldatasaturday<-data.frame(hotel_name,score,presaleprice,price,test$V2,test$V3)

filename<-paste("/Users/JessicaBohning/Documents/Data Science/Projects/Portfolio/Webscrapping_Priceline/SATURDAY DATA/Saturday Priceline Hotel Data ",Sys.Date(),".csv",sep="")
write.csv(alldatasaturday,file=filename)

#Gather the Tuesday results data
print("Tuesday Results Data")
temptuesdayresults<-tuesdayresults
#Keep only the numbers
temptuesdayresults$resultstemp<-regmatches(temptuesdayresults$resultstemp,
                                           gregexpr('[0-9]+',
                                                   temptuesdayresults$resultstemp))
temptuesdayresults$DATE_RETRIEVED<-Sys.time()
temptuesdayresults$resultstemp<-do.call("rbind",temptuesdayresults$resultstemp)

#Gather the Saturday results data
print("Saturday Results Data")
#Keep only the numbers
tempsaturdayresults<-saturdayresults
tempsaturdayresults$resultstemp<-regmatches(tempsaturdayresults$resultstemp,
                                           gregexpr('[0-9]+',
                                                    tempsaturdayresults$resultstemp))
tempsaturdayresults$DATE_RETRIEVED<-Sys.time()
tempsaturdayresults$resultstemp<-do.call("rbind",tempsaturdayresults$resultstemp)


#Save All results data
allresults<-rbind(temptuesdayresults,tempsaturdayresults)

filename<-paste("/Users/JessicaBohning/Documents/Data Science/Projects/Portfolio/Webscrapping_Priceline/RESULTS DATA/Results Priceline Hotel Data ",Sys.Date(),".csv",sep="")
write.csv(allresults,file=filename)



#Save to pdf
files<-list.files(path="/Users/JessicaBohning/Documents/Data Science/Projects/Portfolio/Webscrapping_Priceline/RESULTS DATA", full.names=TRUE)
abcd<-data.frame(NULL)
len<-c(1:length(files))
for(i in len){
        abcd<-rbind(abcd,read.csv(files[i]))
}

#Clean up data
abcd$DATE_RETRIEVED<-as.POSIXct(abcd$DATE_RETRIEVED)
abcd$V2<-gsub('[[:digit:]]+', '',abcd$V2)
abcd<-mutate(.data=abcd,Day_of_Week=V2)
abcd$V2<-gsub("_Tuesday_","",abcd$V2)
abcd$V2<-gsub("_Saturday_","",abcd$V2)
abcd$V2<-gsub("_"," ",abcd$V2)
abcd$Day_of_Week<-gsub("Las_Vegas_","",abcd$Day_of_Week)
abcd$Day_of_Week<-gsub("New_York_City","",abcd$Day_of_Week)
abcd$Day_of_Week<-gsub("Washington_DC","",abcd$Day_of_Week)
abcd$Day_of_Week<-gsub("London","",abcd$Day_of_Week)
abcd$Day_of_Week<-gsub("Paris","",abcd$Day_of_Week)
abcd$Day_of_Week<-gsub("Berlin","",abcd$Day_of_Week)
abcd$Day_of_Week<-gsub("Sydney","",abcd$Day_of_Week)
abcd$Day_of_Week<-gsub("_","",abcd$Day_of_Week)
#Eliminate the erroneous first column
abcd<-abcd[-1]
abcde<-NULL
abcde<-mutate(abcd,dayweek=paste(Day_of_Week,"Week",V3))
abcde$dayweek<-factor(abcde$dayweek,
                         levels=c("Tuesday Week 1","Tuesday Week 2",
                                  "Tuesday Week 3","Tuesday Week 4",
                                  "Saturday Week 1","Saturday Week 2",
                                  "Saturday Week 3","Saturday Week 4"))

pdf("/Users/JessicaBohning/Documents/Data Science/Projects/Portfolio/Webscrapping_Priceline/Priceline Summary.pdf",paper="a4r",width=10,height=7.5)
g1<-ggplot(abcde,aes(x=DATE_RETRIEVED,y=resultstemp,color=V2))+facet_wrap(~dayweek,ncol=4)+
        geom_line()+scale_color_brewer(palette = "Set1",name=NULL)+
        theme(axis.text.x = element_text(angle = 90))+
        ggtitle("Number of Hotels Available on Priceline")+
        theme(plot.title=element_text(hjust=0.5))+
        ylab(NULL)+xlab(NULL)
g2<-ggplot(abcde,aes(x=DATE_RETRIEVED,y=resultstemp,col=Day_of_Week))+
        stat_summary(fun.y="mean", geom="line")+
        facet_wrap(~V2,ncol=4, scales="free")+
        xlab("")+
        ylab("Average Number of Hotels Available")+
        scale_color_brewer(palette = "Set1",name=NULL)+
        ggtitle("Average Number of Hotels Available on Priceline (with different scales on y-axis)")+
        theme(plot.title=element_text(hjust=0.5))+
        theme(legend.position=c(.85,.25))+
        theme(axis.text.x = element_text(angle = 90))
g3<-ggplot(abcde,aes(x=as.factor(V3),y=resultstemp,col=Day_of_Week))+
        geom_boxplot()+facet_wrap(~V2,ncol=4)+
        xlab("Number of Weeks in the Future")+
        ylab("Number of Hotels Available")+
        scale_color_brewer(palette = "Set1",name=NULL)+
        ggtitle("Number of Hotels Available on Priceline")+
        theme(plot.title=element_text(hjust=0.5))+
        theme(legend.position=c(.85,.25))
g1;g2;g3
dev.off()

