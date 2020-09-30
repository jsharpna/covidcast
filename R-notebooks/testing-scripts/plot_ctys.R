library(covidcast)
library(tidyverse)

all_ctys = suppressMessages(
  covidcast_signal(
    "usa-facts","confirmed_incidence_num", 
    geo_type = "county", 
    start_day = NULL
  )
)

forcast_locs <- all_ctys %>% group_by(geo_value) %>% 
  summarise(
    case_sum = sum(value, na.rm=TRUE),
    max_value = max(value, na.rm = TRUE)) %>%
  filter(as.numeric(geo_value) %% 1000 > 0) %>%
  arrange(desc(case_sum)) %>% top_n(200, wt=case_sum)

joined = left_join(all_ctys, forcast_locs) %>%
  filter(!is.na(case_sum), time_value == "2020-08-01") %>%
  mutate(value = case_sum)

plot(joined, range = range(joined$value))
