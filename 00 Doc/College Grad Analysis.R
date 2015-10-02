require("jsonlite")
require("RCurl")
require("ggplot2")
require("dplyr")
# Change the USER and PASS below to be your UTEid
df <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="select * from collegegrads"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521/PDBF15DV.usuniversi01134.oraclecloud.internal', USER='cs329e_vp5467', PASS='orcl_vp5467', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE), ))
summary(df)
head(df)

misc_names <- array("Virgin Islands", "Puerto Rico", "Washington, D.C.")

#df %>% select(PERCENT_FINLOAN, PERCENT_WHITE) %>% filter(PERCENT_FINLOAN != "null", PERCENT_WHITE != "null") %>% arrange(desc(PERCENT_WHITE)) %>%
#ggplot(aes(x=PERCENT_WHITE, y=PERCENT_FINLOAN)) +
#coord_cartesian() +
#scale_x_discrete() +
#scale_y_discrete() + 
#labs(x="Percent White",y="Percent FinLoan") +
#geom_point()

#df %>% select(STATE, AVGGRADDEBT) %>% filter(AVGGRADDEBT != "null") %>% mutate(avg = median(as.numeric(AVGGRADDEBT))) %>% group_by(STATE) %>% summarize(state_max = max(as.numeric(AVGGRADDEBT)))

#Plot 2
#df %>% select(PERCENT_FINLOAN, STATE, AVGGRADDEBT) %>% filter(AVGGRADDEBT != "null", PERCENT_FINLOAN != "null") %>% mutate(region = ifelse(state.region[match(STATE, state.abb)] %in% state.region, state.region[match(STATE, state.abb),]), match(STATE,["VI","PR","DC"]) %>% group_by(region, STATE) %>% summarize(state_avg_loan = mean(as.numeric(as.character(PERCENT_FINLOAN))), state_avg_debt = mean(as.numeric(as.character (AVGGRADDEBT)))) %>% ggplot(aes(x = state_avg_loan, y = state_avg_debt, color = region)) + labs(title = "Regional Distribution of University Debt", x = "Average % of Students Needing Loans", y = "Average Debt Upon Graduation") + geom_point(size = 4)

df %>% select(PERCENT_FINLOAN, STATE, AVGGRADDEBT) %>% filter(AVGGRADDEBT != "null", PERCENT_FINLOAN != "null") %>% mutate(region = ifelse(state.region[match(STATE, state.abb)] %in% state.region, state.region[match(STATE, state.abb),]), match(STATE,["VI","PR","DC"])

                                                                                                                                                                                                                                                      
#(aes(x = reorder(region, state_avg_debt), y = state_avg_debt, fill = region)) + labs(title = "University Debt by State", x = "Average Debt", y = "State") + theme(legend.position = "none") + geom_bar(stat = "identity") + coord_flip()

#Plot 3
df %>% select(PERCENT_FINLOAN, STATE, AVGGRADDEBT) %>% filter(AVGGRADDEBT != "null", PERCENT_FINLOAN != "null") %>% mutate(state_name = state.name[match(STATE, state.abb)]) %>% group_by(state_name) %>% summarize(state_avg_loan = mean(as.numeric(as.character(PERCENT_FINLOAN))), state_avg_debt = mean(as.numeric(as.character (AVGGRADDEBT)))) %>% ggplot(aes(x = reorder(state_name, state_avg_debt), y = state_avg_debt, fill = state_name)) + labs(title = "Average University Debt by State", x = "State", y = "Average Debt (USD)") + theme(legend.position = "none") + geom_bar(stat = "identity") + coord_flip()

#Plot 1
df %>% select(PERCENT_WHITE, PERCENT_BLACK, PERCENT_HISPANIC, PERCENT_ASIAN, AVGSAT, GRADINCOME) %>% filter (PERCENT_WHITE != "null", AVGSAT != "null", GRADINCOME != "null")      %>% mutate (majority_percent = pmax(as.numeric(as.character(PERCENT_WHITE)), as.numeric(as.character(PERCENT_BLACK)), as.numeric(as.character(PERCENT_HISPANIC)), as.numeric(as.character(PERCENT_ASIAN))))                                         %>% mutate(majority = ifelse(as.numeric(as.character(PERCENT_WHITE)) == majority_percent, "White", ifelse(as.numeric(as.character(PERCENT_BLACK)) == majority_percent, "Black", ifelse(as.numeric(as.character(PERCENT_ASIAN)) == majority_percent, "Asian", ifelse(as.numeric(as.character(PERCENT_HISPANIC)) == majority_percent, "Hispanic", "Other")))))                                                          %>% ggplot(aes(x = as.numeric(as.character(GRADINCOME)),y = as.numeric(as.character(AVGSAT)), color = majority)) + labs(title = "Income/SAT Distribution by Racial Majority", x = "Average Income Upon Graduation", y = "Average SAT") + geom_jitter()
