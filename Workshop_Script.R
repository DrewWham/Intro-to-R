library(ggplot2)
library(dplyr)
library(reshape2)
library(stringr)
library(lubridate)
library(data.table)

DT<-fread("2008.csv")
AP<-fread("airports.csv")


setnames(AP,"iata_code","Origin")
setkey(DT,Origin)
setkey(AP,Origin)
DT<-merge(DT,AP,all.x=T)
WashAP<-c('DCA','IAD','BWI')
WF<-DT[Origin %in% WashAP]
WF<-WF[Cancelled==0]
Avg_tab<-dcast(WF,Origin ~ UniqueCarrier,mean,value.var= c("DepDelay"))
MPasAl<-c('AA','DL','UA','US')
WFsub<-WF[UniqueCarrier %in% MPasAl]

WFsub$Month<-str_pad(WFsub$Month,2,side="left",pad="0")
WFsub$DayofMonth<-str_pad(WFsub$DayofMonth,2,side="left",pad="0")
WFsub$CRSDepTime<-str_pad(WFsub$CRSDepTime,4,side="left",pad="0")
WFsub$DepDateTime <-paste0(WFsub$Month,WFsub$DayofMonth,WFsub$Year," ",WFsub$CRSDepTime)


WFsub$DepDateTime <-parse_date_time(WFsub$DepDateTime,"%m%d%Y %H%M")
WFsub$TimeOnly <-parse_date_time(WFsub$CRSDepTime,"%H%M")

ggplot(WFsub,aes(x=TimeOnly,y=DepDelay,col=UniqueCarrier))+geom_point()+scale_x_datetime(date_breaks= "2 hours",date_labels ="%r")

ggplot(WFsub,aes(x=TimeOnly,y=DepDelay,col=UniqueCarrier))+facet_wrap(~name,ncol= 1,scales = "free_x")+geom_smooth()+coord_cartesian(ylim=c(0,30))+theme_minimal()+scale_x_datetime(date_breaks= "2 hours",date_labels ="%r")+theme(text = element_text(size=20))
ggsave("WashAreaAirport_Delay_by_Hour.pdf")


ggplot(WFsub,aes(x=DepDateTime,y=DepDelay,col=UniqueCarrier))+facet_wrap(~name,ncol= 1,scales = "free_x")+geom_smooth()+coord_cartesian(ylim=c(-10,30))+theme_minimal()+scale_x_datetime(date_breaks= "1 month",date_labels ="%b")+ theme(text = element_text(size=20))
ggsave("WashAreaAirport_Delay_by_Month.pdf")
