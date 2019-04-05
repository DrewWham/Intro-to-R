library(ggplot2)
library(stringr)
library(lubridate)
library(data.table)

#This reads in the flight data and stores it as an object called 'DT'
DT<-fread("2008.csv")
#This reads in the data about airports and stores it as an object called 'AP'
AP<-fread("airports.csv")

#this changes the name of the "iata_code" column to "Origin"
setnames(AP,"iata_code","Origin")
#before merging we can re-order the datasets by what we want to merge on
setkey(DT,Origin)
#this will match the order for both data frames, this will significantly speed up the merge
setkey(AP,Origin)
#Now we can merge, notice the "all.x=T"
DT<-merge(DT,AP,all.x=T)
#we can make a vector
WashAP<-c('DCA','IAD','BWI')
#then using that vector to subset
WF<-DT[Origin %in% WashAP]
#we can also use a logical statement
WF<-WF[Cancelled==0]
Avg_tab<-dcast(WF,Origin ~ UniqueCarrier,mean,value.var= c("DepDelay"))
#this is a useful way of looking at summary stats but notice that it is not 'tidy'

#making a vector
MPasAl<-c('AA','DL','UA','US')
#subsetting with a vector
WFsub<-WF[UniqueCarrier %in% MPasAl]

WFsub$Month<-str_pad(WFsub$Month,2,side="left",pad="0")
WFsub$DayofMonth<-str_pad(WFsub$DayofMonth,2,side="left",pad="0")
WFsub$CRSDepTime<-str_pad(WFsub$CRSDepTime,4,side="left",pad="0")

#the paste0() function will concatenate columns
WFsub$DepDateTime <-paste0(WFsub$Month,WFsub$DayofMonth,WFsub$Year," ",WFsub$CRSDepTime)

#make a new column with both the date and the time
WFsub$DepDateTime <-parse_date_time(WFsub$DepDateTime,"%m%d%Y %H%M")
#make a new column with just the time
WFsub$TimeOnly <-parse_date_time(WFsub$CRSDepTime,"%H%M")

ggplot(WFsub,aes(x=TimeOnly,y=DepDelay,col=UniqueCarrier))+geom_point()+scale_x_datetime(date_breaks= "2 hours",date_labels ="%r")

ggplot(WFsub,aes(x=TimeOnly,y=DepDelay,col=UniqueCarrier))+facet_wrap(~name,ncol= 1,scales = "free_x")+geom_smooth()+coord_cartesian(ylim=c(0,30))+theme_minimal()+scale_x_datetime(date_breaks= "2 hours",date_labels ="%r")+theme(text = element_text(size=20))
#The ggsave function will save the plot as a ".pdf"
ggsave("WashAreaAirport_Delay_by_Hour.pdf")


ggplot(WFsub,aes(x=DepDateTime,y=DepDelay,col=UniqueCarrier))+facet_wrap(~name,ncol= 1,scales = "free_x")+geom_smooth()+coord_cartesian(ylim=c(-10,30))+theme_minimal()+scale_x_datetime(date_breaks= "1 month",date_labels ="%b")+ theme(text = element_text(size=20))
ggsave("WashAreaAirport_Delay_by_Month.pdf")
