require("jsonlite")
require("RCurl")
require("dplyr")
# Change the USER and PASS below to be your UTEid
df <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="select * from STANDOWNLOADSCOLLEGEGRAD"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521/PDBF15DV.usuniversi01134.oraclecloud.internal', USER='cs329e_su964', PASS='orcl_su964', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE), ))
df
summary(df)
head(df)
#mydata <- df %>% select(STATE, AVGGRADDEBT) %>% filter(!is.na(AVGGRADDEBT) )
mydata <- df %>% select(STATE, AVGGRADDEBT) %>% filter(AVGGRADDEBT != "null" ) %>% group_by(STATE) %>% summarize(aveGradDebt = mean(as.numeric(as.character(AVGGRADDEBT)))) %>% arrange(desc(aveGradDebt))
View(mydata)
mydata <- df %>% select(STATE, AVGGRADDEBT) %>% filter(AVGGRADDEBT != "null" ) %>% summarise(n=n())
mydata2 <- df %>% group_by(STATE) %>% tbl_df

View(mydata)
head(mydata,100)
