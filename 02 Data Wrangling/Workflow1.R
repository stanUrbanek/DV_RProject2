# Workflow 1

# First the table
df %>% select(PERCENT_FINLOAN, STATE, AVGGRADDEBT) %>% filter(AVGGRADDEBT != "null", PERCENT_FINLOAN != "null") %>% mutate(state_name = state.name[match(STATE, state.abb)]) %>% group_by(state_name) %>% summarize(state_avg_loan = mean(as.numeric(as.character(PERCENT_FINLOAN))), state_avg_debt = mean(as.numeric(as.character (AVGGRADDEBT)))) %>% tbl_df

# Second the visualization
df %>% select(PERCENT_FINLOAN, STATE, AVGGRADDEBT) %>% filter(AVGGRADDEBT != "null", PERCENT_FINLOAN != "null") %>% mutate(state_name = state.name[match(STATE, state.abb)]) %>% group_by(state_name) %>% summarize(state_avg_loan = mean(as.numeric(as.character(PERCENT_FINLOAN))), state_avg_debt = mean(as.numeric(as.character (AVGGRADDEBT)))) %>% ggplot(aes(x = reorder(state_name, state_avg_debt), y = state_avg_debt, fill = state_name)) + labs(title = "Average University Debt by State", x = "State", y = "Average Debt (USD)") + theme(legend.position = "none") + geom_bar(stat = "identity") + coord_flip()
