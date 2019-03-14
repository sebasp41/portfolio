library(tidyverse)
library(ggiraph)
library(ggiraphExtra)
library(tidyr)
library(ggplot2)
library(ggdendro)
library(purrr)
cmb_def<-read.csv("/Users/sebastianpycior/college_mb_defense/ncaamb_deef - Sheet1.csv", stringsAsFactors = FALSE)

str_model <- paste0("<tr><td>Team</td><td>%s</td></tr>", 
                    "<tr><td>Conference</td><td>%s</td></tr>",
                    "<tr><td>Curr_Seas_Eff</td><td>%s</td></tr>", 
                    "<tr><td>Curr_Seas</td><td>%s</td></tr>")
cmb_def$tooltip <- sprintf(str_model, cmb_def$Team, cmb_def$Conference, cmb_def$Curr_Seas, cmb_def$Curr_Seas_Eff)
cmb_def$tooltip <- paste0( "<table>", cmb_def$tooltip, "</table>" )
p<-ggplot(data = cmb_def, aes(x = cmb_def$Curr_Seas, y = cmb_def$Team)) +
  geom_tile_interactive(aes(fill = cmb_def$Curr_Seas_Eff,tooltip = tooltip), stat="identity",colour = "white") +
  scale_fill_gradient2(midpoint = 0.95) +
  coord_equal() +
  theme_minimal() +
  theme(
    legend.position = "right",
    panel.grid.minor = element_line(color = "transparent"),
    panel.grid.major = element_line(color = "transparent"),
    axis.ticks.length   = unit(2, units = "mm"),
    plot.title = element_text(face = "bold", hjust = 0.5, size = 12),
    axis.title = element_text(size = 3, colour = "black"),
    axis.text.y = element_text(hjust = 1, size = 3, colour = "black"),
    axis.text.x = element_text(angle = 90, hjust = 1, size = 3, colour = "black"),
    legend.title=element_text(face = "bold", hjust = 0.5, size=4),
    legend.text=element_text(size=6))
girafe(ggobj = p)
