
# Inspiration: http://letstalkdata.com/2014/05/creating-voronoi-diagrams-with-ggplot/

# Load packages
library(deldir)
library(ggart)
library(ggthemes)
library(tidyverse)

# Generate data
# set.seed(106)
# long<-rnorm(100000, -1, 1)
# lat<-rnorm(100000, -1, 1)
# df <- data.frame(lat,long)

set.seed(101)

n <- 10000
s <- 24 / 24
eps <- 0.05

data <- data.frame(x = runif(n, 0, 1), y = runif(n, 0, s))

#This creates the voronoi line segments
voronoi <- deldir(data$x, data$y, rw = c(0-eps, 1+eps, 0-eps, s+eps))

#Now we can make a plot
p <- ggplot(data = data, aes(x = x, y = y)) +
  geom_segment(aes(x = x1, y = y1, xend = x2, yend = y2), data = voronoi$dirsgs, color = "black", lineend = "round") + 
  geom_point(data = data, aes(x, y)) +
  coord_equal() +
  theme_tufte() +
  theme_blankcanvas() +
  theme(plot.margin = unit(c(0.5, 0.5, 0.5, 0.5), units = "in"))

ggsave("voronoi-square.png", p, width = 24, height = 24, units = "in", dpi = 300)
#ggsave("voronoi.tiff", p, width = 24, height = 35, units = "in", dpi = 720)
