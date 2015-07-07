library(ggplot2)
library(dplyr)
map2d <- function(title, sourceXName, sourceYName, mapXName, mapYName, levels, x0, y0, mapX, mapY) {
  sourceTypeName <- paste0("source (", sourceXName, ", ", sourceYName, ")")
  mapTypeName <- paste0("map (", sourceXName, ", ", sourceYName, ")")
  types <- factor(c(sourceTypeName, mapTypeName))
  
  phi <- seq(0, 2 * pi, length = 360)

  data <- expand.grid(x0 = x0, y0 = y0, r = levels, phi = phi)
  data1 <- data %>% 
    mutate(x = x0 + r * cos(phi), y = y0 + r * sin(phi)) %>% 
    mutate(type = types[1])
  data2 <- data1 %>% 
    transmute(x0 = x0, y0 = y0, r = r, phi = phi, x2 = mapX(x, y), y2 = mapY(x, y)) %>% 
    rename(x = x2, y = y2) %>%
    mutate(type = types[2])
  data <- rbind(data1, data2)
  data <- arrange(transform(data, type = factor(type, types)))
  data <- data %>% transform(r = factor(r))
  p <- ggplot(data, aes(x, y, group = r, colour = r)) +
    ggtitle(title) +
    labs(colour = "Radius") +
    geom_path() +
    xlab("") + 
    ylab("")
  labeller <- function(variable, value) {
    if (variable == "x0")
      paste0(sourceXName, " = ", value)
    else if (variable == "y0")
      paste0(sourceYName, " = ", value)
    else
      paste0(value)
  }
  if (length(x0) > 1)
    p <- p + facet_grid(x0 ~ type, labeller = labeller, scales = "free")
  else if (length(y0) > 1)
    p <- p + facet_grid(y0 ~ type, labeller = labeller)
  else
    p <- p + facet_grid(. ~ type, labeller = labeller)
  list(data = data, data1 = data1, data2 = data2, plot = p)
}