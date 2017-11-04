# Avg velocity by team

pitch_data %>%
  group_by(mlb_team) %>%
  summarize("rel_spd" = mean(release_speed)) %>%
  arrange(desc(rel_spd))

# Avg velocity by pitch type

pitch_data %>%
  group_by(pitch_type) %>%
  summarize("rel_spd" = mean(release_speed)) %>%
  arrange(desc(rel_spd))


# Avg fastball velocity by team
pitch_data %>%
  filter(pitch_type %in% c("FT", "FF", "SI")) %>%
  group_by(mlb_team) %>%
  summarize("avg_fb" = mean(release_speed)) %>%
  ggplot(aes(x = mlb_team, y = avg_fb)) +
  geom_bar(stat = "identity") +
  coord_flip() 


# Avg fastball by team - cleveland plot

pitch_data %>%
  filter(pitch_type %in% c("FT", "FF", "SI")) %>%
  group_by(mlb_team) %>%
  summarize("avg_fb" = mean(release_speed)) %>%
  ggplot(aes(x = avg_fb, y = reorder(mlb_team, avg_fb))) +
  geom_point(size=3) + 
  theme_bw() +
  theme(panel.grid.major.x = element_blank(),
        panel.grid.minor.x = element_blank(),
        panel.grid.major.y = element_line(colour="grey60", linetype="dashed")) 

## Curve

pitch_data %>%
  filter(pitch_type == "CU") %>%
  group_by(mlb_team) %>%
  summarize("avg_curve" = mean(release_speed)) %>%
  ggplot(aes(x = avg_curve, y = reorder(mlb_team, avg_curve))) +
  geom_point(size=3) + 
  theme_bw() +
  theme(panel.grid.major.x = element_blank(),
        panel.grid.minor.x = element_blank(),
        panel.grid.major.y = element_line(colour="grey60", linetype="dashed")) 

