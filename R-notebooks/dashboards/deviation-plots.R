library(covidcast)
library(tidyverse)
library(lubridate)


today = Sys.Date()
minus_2_weeks = today - days(15)


fb_cli = covidcast_signal(
  "fb-survey", "raw_cli", start_day = minus_2_weeks, geo_type = "state")
most_recent = fb_cli %>% summarize(avail = max(time_value)) %>% pull()
lagged = fb_cli %>% group_by(geo_value) %>% 
  filter(time_value < most_recent, time_value > most_recent - days(8)) %>%
  summarize(
    ave_val = mean(value, na.rm=TRUE), 
    ave_samp = mean(sample_size, na.rm=TRUE))
last_release = fb_cli %>% filter(time_value==most_recent)
merged = left_join(last_release, lagged, by="geo_value") %>%
  mutate(
    pct_chg_value = (value - ave_val)/ave_val,
    pct_chg_sample = (sample_size - ave_samp)/ave_samp)
map_df = usmap::us_map("state") %>% mutate(geo_value =tolower(abbr))
toplot = left_join(map_df, merged, by=c("geo_value")) %>%
  dplyr::select(x, y, group, pct_chg_value, pct_chg_sample) 

library(cowplot)

p1 = ggplot(toplot, aes(x, y, group=group)) + 
  geom_polygon(aes(fill=pct_chg_value)) +
  theme_void() + 
  coord_equal() + scale_fill_gradient2()
p2 = ggplot(toplot, aes(x, y, group=group)) +
  geom_polygon(aes(fill=pct_chg_sample)) +
  theme_void() + 
  coord_equal() + scale_fill_gradient2()
plot_grid(p1,p2)
