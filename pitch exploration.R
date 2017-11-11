library(ggthemes)

# Avg velocity by team

pitch_data %>%
  group_by(mlb_team) %>%
  summarize("Release Speed" = mean(release_speed)) %>%
  arrange(desc(`Release Speed`)) %>%
  mutate("rank" = rank(-`Release Speed`))

# Avg fastball velocity by team

pitch_data %>%
  filter(pitch_type %in% c("FF","FT", "SI")) %>%
  group_by(mlb_team) %>%
  summarize("Release Speed" = mean(release_speed)) %>%
  arrange(desc(`Release Speed`)) %>%
    mutate("fastball rank" = rank(-`Release Speed`)) 


# Avg velocity by pitch type

pitch_data %>%
  group_by(pitch_type) %>%
  summarize("Release Speed" = mean(release_speed)) %>%
  arrange(desc(`Release Speed`))

pitch_data %>%
  group_by(pitch_type) %>%
  summarize("Release Speed" = mean(release_speed)) %>%
  arrange(desc(`Release Speed`)) %>%
  mutate(pitch_type = recode(pitch_type,
                             FF = "Four-Seam Fastball",
                             FT = "Two-Seam Faseball",
                             SI = "Sinker",
                             FC = "Cutter",
                             PO = "Pitchout",
                             FO = "Forkball",
                             null = "Null",
                             FS = "Splitter",
                             SL = "Slider",
                             CH = "Changeup",
                             KC = "Knuckle-Curve",
                             SC = "Screwball",
                             CU = "Curveball",
                             IN = "Intentional Ball",
                             KN = "Knuckleball",
                             AB = "Automatic Ball",
                             EP = "Eephus",
                             UN = "Unknown"))


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
        panel.grid.major.y = element_line(colour="grey60", linetype="dashed")) +
  xlab("Average Fastball Velocity") +
  ylab("Team")

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

pitch_data %>%
  group_by(mlb_team) %>%
  summarize("avg_curve" = mean(release_speed)) %>%
  ggplot(aes(x = avg_curve, y = reorder(mlb_team, avg_curve))) +
  geom_point(size=3) + 
  theme_light() +
  theme(panel.grid.major.x = element_blank(),
        panel.grid.minor.x = element_blank(),
        panel.grid.major.y = element_line(colour="grey60", linetype="dashed")) +
  ggtitle("Average Curveball Velo by Team")

## Avg velo of four pitch types

pitch_data %>%
  filter(pitch_type %in% c("CU", "FF", "SL", "CH")) %>%
  group_by(mlb_team, pitch_type) %>%
  summarize("avg_velo" = mean(release_speed)) %>%
  ggplot(aes(x = avg_velo, y = mlb_team, col = pitch_type)) +
  geom_point(size=3) + 
  theme_light() +
  theme(panel.grid.major.x = element_blank(),
        panel.grid.minor.x = element_blank(),
        panel.grid.major.y = element_line(colour="grey60", linetype="dashed")) +
  scale_color_discrete(name = "Pitch Type", breaks = c("CH", "CU", "FF", "SL"), labels = c("Change-Up", "Curveball", "Four-Seam FB", "Slider"))+
  xlab("Average release velolcity (mph)")+
  ylab("Team") +
  ggtitle("Average velocity of four pitch types")


## Avg Fastball Velocity by Inning
pitch_data %>%
  filter(pitch_type %in% c("FF", "FT", "SI")) %>%
  group_by(inning) %>%
  summarize("Average Velocity (mph)" = mean(release_speed)) %>%
  ggplot(aes(x = inning, y = `Average Velocity (mph)`)) +
  geom_point(size = 3) + 
  theme_light() +
  theme(panel.grid.major.y = element_line(colour="grey60", linetype="dashed")) +
  scale_x_continuous(breaks = 1:12, limits = c(1,12)) +
  scale_y_continuous(breaks = 91:97, limits = c(92,95)) +
  ggtitle("Average Fastball velo by inning") +
  xlab("Inning")
  
## Avg Curveball velo by inning
pitch_data %>%
  filter(pitch_type == "CU") %>%
  group_by(inning) %>%
  summarize("Average Velocity (mph)" = mean(release_speed)) %>%
  ggplot(aes(x = inning, y = `Average Velocity (mph)`)) +
  geom_point(size = 3) + 
  theme_light() +
  theme(panel.grid.major.y = element_line(colour="grey60", linetype="dashed")) +
  scale_x_continuous(breaks = 1:12, limits = c(1,12)) +
  ggtitle("Average Curveball velo by inning")



#economist theme

pitch_data %>%
  filter(pitch_type %in% c("FF", "FT", "FI")) %>%
  group_by(inning) %>%
  summarize("Average Velocity (mph)" = mean(release_speed)) %>%
  ggplot(aes(x = inning, y = `Average Velocity (mph)`)) +
  geom_point(size = 3) + 
  theme_economist() +
  scale_x_continuous(breaks = 1:12, limits = c(1,12)) +
  scale_y_continuous(breaks = 90:100) +
  ggtitle("Average Fastball velo by inning")

#pitchtypes by team
team_pitch_avg <- pitch_data %>%
  filter(pitch_type %in% c("CU", "FF", "SL", "CH")) %>%
  group_by(mlb_team, pitch_type) %>%
  summarize("avg_velo" = mean(release_speed))

## How many eephuses?
pitch_data %>%
  filter(pitch_type == "EP") %>%
  tally()

## Who threw all the Eephuses?
pitch_data %>%
  filter(pitch_type == "EP") %>%
  group_by(player_name) %>%
  tally() %>%
  arrange(desc(n))

## Eephus Balls/Strikes
pitch_data %>%
  filter(pitch_type == "EP") %>%
  group_by(type) %>%
  tally() %>%
  arrange(desc(n))

## Eephus outcomes
pitch_data %>%
  filter(pitch_type == "EP") %>%
  group_by(description) %>%
  tally() %>%
  arrange(desc(n))

  ## Shields Eephus: https://chicago.suntimes.com/sports/slower-is-better-for-the-reinvented-james-shields/



