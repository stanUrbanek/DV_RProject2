# Workflow for experiment 2

# First the table
df %>% select(PERCENT_FINLOAN, STATE, AVGGRADDEBT) %>% filter(AVGGRADDEBT != "null", PERCENT_FINLOAN != "null") %>% mutate(region = state.region[match(STATE, state.abb)]) %>% group_by(region, STATE) %>% summarize(state_avg_loan = mean(as.numeric(as.character(PERCENT_FINLOAN))), state_avg_debt = mean(as.numeric(as.character (AVGGRADDEBT)))) %>% tbl_df

# Second the visualization
df %>% select(PERCENT_FINLOAN, STATE, AVGGRADDEBT) %>% filter(AVGGRADDEBT != "null", PERCENT_FINLOAN != "null") %>% mutate(region = state.region[match(STATE, state.abb)]) %>% group_by(region, STATE) %>% summarize(state_avg_loan = mean(as.numeric(as.character(PERCENT_FINLOAN))), state_avg_debt = mean(as.numeric(as.character (AVGGRADDEBT)))) %>% ggplot(aes(x = state_avg_loan, y = state_avg_debt, color = region)) + labs(title = "Regional Distribution of University Debt", x = "Average % of Students Needing Loans", y = "Average Debt Upon Graduation") + geom_point(size = 4)