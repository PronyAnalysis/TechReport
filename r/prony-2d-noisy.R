source("tools-prony-nd.R")
source("tools-math.R")
source("tools-tables.R")
source("tools.R")
n <- 2
mu <- c(1, 1.5)
delta <- 0.05
x <- sort(exp(-2i * pi * delta * mu))
a <- rep(1, n)
m <- prony.moments(x, a)
noise <- generate.noise.seed(52777, 2 * n, 0.1)
reconstruct <- prony.solve(m + noise)
reconstruct.tr <- prony.tr2d.solve(m + noise, delta)
print.table(x, a, m, reconstruct$x, reconstruct$a, m + noise)
print.table(x, a, m, reconstruct.tr$x, reconstruct.tr$a, m + noise)

# Plotting 2D
t <- seq(-5, 5, by = 0.01)
f1 <- gauss(a[1], mu[1], 1)(t)
f2 <- gauss(a[2], mu[2], 1)(t)
f <- f1 + f2
df <- data.frame(t, f1, f2, f) %>% gather("name", "value", 2:4)
plot <- ggplot(df, aes(t, value, group = name, colour = name)) + geom_line()
plot
ggsave("../figures/prony-2d-noisy/prony-2d-noisy.png", plot)
