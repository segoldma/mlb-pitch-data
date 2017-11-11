library(dplyr)
library(ggplot2)

## Load in all team files
df1 <- read.csv("ARI.csv")
df2 <- read.csv("ATL.csv")
df3 <- read.csv("BAL.csv")
df4 <- read.csv("BOS.csv")
df5 <- read.csv("CHC.csv")
df6 <- read.csv("CIN.csv")
df7 <- read.csv("CLE.csv")
df8 <- read.csv("COL.csv")
df9 <- read.csv("CWS.csv")
df10 <- read.csv("DET.csv")
df11 <- read.csv("HOU.csv")
df12 <- read.csv("KCR.csv")
df13 <- read.csv("LAA.csv")
df14 <- read.csv("LAD.csv")
df15 <- read.csv("MIA.csv")
df16 <- read.csv("MIL.csv")
df17 <- read.csv("MIN.csv")
df18 <- read.csv("NYM.csv")
df19 <- read.csv("NYY.csv")
df20 <- read.csv("OAK.csv")
df21 <- read.csv("PHI.csv")
df22 <- read.csv("PIT.csv")
df23 <- read.csv("SDP.csv")
df24 <- read.csv("SEA.csv")
df25 <- read.csv("SFG.csv")
df26 <- read.csv("STL.csv")
df27 <- read.csv("TBR.csv")
df28 <- read.csv("TEX.csv")
df29 <- read.csv("TOR.csv")
df30 <- read.csv("WSH.csv")

# Combine each team's data into one data frame... there's gotta be a better way
pitch_data <- rbind(df1, df2, df3, df4, df5, df6, df7, df8, df9, df10, df11, df12, df13, df14, df15)
pitch_data_2 <- rbind(df16, df17, df18, df19, df20, df21, df22, df23, df24, df25, df26, df27, df28, df29, df30)

pitch_data <-rbind(pitch_data, pitch_data_2)

## IF DF IS ALREADY CREATED
pitch_data <- read.csv("pitch_data.csv")

# Add player ids to add team key

player_ids <- read.csv("player_ids.csv")

pitch_data <- left_join(pitch_data, player_ids, by = c("pitcher" = "mlb_id"))

