library(ggplot2)
library(dplyr)
types <- factor(c("source (x, a)", "map (m0, m1)"))
x0 <- c(1, 1.5, 2)
a0 <- 2
r <- c(1, 1.5, 2)
phi <- seq(0, 2 * pi, length = 360)
data <- expand.grid(x0 = x0, a0 = a0, r = r, phi = phi)
data1 <- data %>% 
  mutate(x = x0 + r * cos(phi), a = a0 + r * sin(phi)) %>% 
  mutate(type = types[1])
data2 <- data1 %>% 
  transmute(x0 = x0, a0 = a0, r = r, phi = phi, m0 = a, m1 = a * x) %>% 
  mutate(type = types[2])
data <- rbind(data1 %>% rename(x = x, y = a), data2 %>% rename(x = m0, y = m1))
data <- arrange(transform(data, type = factor(type, types)))
data <- data %>% transform(r = factor(r))
p <- ggplot(data, aes(x, y, group = r, colour = r)) +
  ggtitle("Prony-1D map") +
  labs(colour = "Radius") +
  geom_path() + 
  facet_grid(x0 ~ type, labeller = label_both)
p
ggsave("../figures/prony-1d-map/prony-1d-map.png", p)