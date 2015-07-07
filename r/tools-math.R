gauss <- function(a, x0, s2) { function(x) a * exp(-((x-x0)^2)/(2*s2))}
generate.noise <- function(length, mod) {
  noise <- runif(length * 2) * mod
  noise <- noise[1:length] + noise[(length + 1):(length * 2)] * 1i
  noise
}
generate.noise.seed <- function(seed, length, mod) {
  set.seed(seed)
  generate.noise(length, mod)
}