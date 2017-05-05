
# Inspiration: http://letstalkdata.com/2014/05/creating-voronoi-diagrams-with-ggplot/

# Load packages
library(deldir)
library(ggart)
library(ggthemes)
library(steiner)
library(tidyverse)
library(tweenr)

# Generate data
# set.seed(106)
# long<-rnorm(100000, -1, 1)
# lat<-rnorm(100000, -1, 1)
# df <- data.frame(lat,long)

set.seed(101)

n <- 10000
s <- 24 / 24
eps <- 0.05

#data <- data.frame(x = runif(n, 0, 1), y = runif(n, 0, s))

n <- 1

data <- 1:10 %>%
  map_df(~compute_circle(c(0, 0), ., n = 365)) %>%
  mutate(x = jitter(x, 50), y = jitter(y, 50))

#This creates the voronoi line segments
voronoi <- deldir(data$x, data$y)

#Now we can make a plot
p <- ggplot() +
  geom_segment(aes(x = x1, y = y1, xend = x2, yend = y2), data = voronoi$delsgs, color = "black", lineend = "round", alpha = 0.5) +
  #geom_segment(aes(x = x1, y = y1, xend = x2, yend = y2), data = voronoi$dirsgs, color = "black", lineend = "round", alpha = 0.5) + 
  geom_point(data = data, aes(x, y), size = 1) +
  coord_equal() +
  theme_tufte() +
  #facet_wrap(~id) +
  theme_blankcanvas() #+
  #theme(plot.margin = unit(c(0.5, 0.5, 0.5, 0.5), units = "in")) +
  #coord_polar()

ggsave("voronoi-circle-04.png", p, width = 24, height = 24, units = "in", dpi = 300)
#ggsave("voronoi.tiff", p, width = 24, height = 35, units = "in", dpi = 720)
