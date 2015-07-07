library(xtable)
print.table <- function(x1, a1, m1, x2, a2, m2) {
  results <- matrix(nrow = 3, ncol = 4 * n)
  results[1,] <- c(x1, a1, m1)
  results[2,] <- c(x2, a2, m2)
  results[3,] <- results[2,] - results[1,]
  results <- prettyNum(results, preserve.width = "common", drop0trailing = T, digits = 3, format = "f")
  dim(results) <- c(3, 4 * n)
  colnames(results) <- c(paste0("x", 1:n), paste0("a", 1:n), paste0("m", 0:(2 * n - 1)))
  rownames(results) <- c("S1", "S2", "dS")
  xtable(results)
}