
# Inspiration: http://letstalkdata.com/2014/05/creating-voronoi-diagrams-with-ggplot/

# Load packages
library(deldir)
library(ggart)
library(ggthemes)
library(tidyverse)
library(tweenr)

# Set parameters
set.seed(101)
s <- 24 / 24
eps <- 0.05
n <- 1

# Function for computing n points around a circle with centre c0 and radius r0
compute_circle <- function(c0, r0, n = 360) {
  data.frame(i = 1:n) %>%
    dplyr::mutate(angle = i * (2 * pi / n), x = c0[1] + r0 * cos(angle), y = c0[2] + r0 * sin(angle)) %>%
    dplyr::select(x, y)
}

# Compute circle points
data <- 1:10 %>%
  map_df(~compute_circle(c(0, 0), ., n = 365)) %>%
  mutate(x = jitter(x, 50), y = jitter(y, 50))

# Create voronoi line segments
voronoi <- deldir(data$x, data$y)

# Create plot
p <- ggplot() +
  geom_segment(aes(x = x1, y = y1, xend = x2, yend = y2), data = voronoi$delsgs,
               color = "black", lineend = "round", alpha = 0.5) +
  geom_point(data = data, aes(x, y), size = 1) +
  coord_equal() +
  theme_tufte() +
  theme_blankcanvas(margin_cm = 0)

# Save plot
ggsave("voronoi-circle-05.png", p, width = 24, height = 24, units = "in", dpi = 300)
