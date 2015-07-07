clamp <- function(x, a, b) max(a, min(x, b))
prony.moments <- function(x, a) {
  n <- length(a)
  sapply(0:(2 * n - 1), function(k) sum(a * x ^ k))
}
prony.solve <- function(m) {
  n <- length(m) / 2
  u.A <- outer(1:n, 1:n, function(i, j) m[i - j + n] * (-1) ^ (j + 1))
  u.B <- m[(n + 1):(2 * n)]
  u <- solve(u.A, u.B)
  x <- sort(polyroot(c(rev(u), 1) * sapply(1:(length(u)+1), function(i) (-1)^i)))
  a.A <- t(sapply(0:(n - 1), function(i) x ^ i))
  a.B <- m[1:n]
  a <- solve(a.A, a.B)
  list(x = x, a = a)
}
prony.tr2d.solve <- function(m, delta) {
  m0 <- m[1]; m1 <- m[2]; m2 <- m[3]
  M0 <- Mod(m0); M1 <- Mod(m1); M2 <- Mod(m2)
  
  Delta.cos <- clamp((2 * M1 ^ 2 - M0 ^ 2 - M2 ^ 2) / (2 * M0 ^ 2 - 2 * M1 ^ 2), -1, 1)
  Delta <- acos(Delta.cos)
  D <- max(M0 ^ 2 - 4 * (M1 ^ 2 - M0 ^ 2) ^ 2 / (M2 ^ 2 + 3 * M0 ^ 2 - 4 * M1 ^ 2), 0)
  a.r <- (M0 - sqrt(D)) / 2
  b.r <- (M0 + sqrt(D)) / 2
  
  p <- a.r * Delta.cos + b.r
  q <- a.r * sin(Delta)
  theta.cos <- clamp((Re(m1) * p + Im(m1) * q) / (p ^ 2 + q ^ 2), -1, 1)
  theta <- -acos(theta.cos)
  phi <- theta + Delta  
  mu.r <- phi / (-2 * pi * delta)
  nu.r <- theta / (-2 * pi * delta)
  x.r <- exp(-2i * pi * delta * mu.r)
  y.r <- exp(-2i * pi * delta * nu.r)
  list(x = c(x.r, y.r), a = c(a.r, b.r))
}