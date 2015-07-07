library(rgl)
library(misc3d)

name <- "prony-2d-countour3d"

createModel <- function(s, labels, p0, surface.count=4, delta = 0.2) {
  m <- function(model, s, k) sum(s$a * exp(-2i*pi*k*s$mu*model$delta))
  dm <- function(model, s1, s2) {
    dmk <- Vectorize(function(k) m(model, s1, k) - m(model, s2, k))
    dmks <- dmk(0:(2*model$n - 1))
    sqrt(sum(c(Re(dmks), Im(dmks)) ^ 2))
  }
  getSeq <- function(x0) seq(0, min(x0*10, 7), length = 20)
  
  model <- list(
    n = length(s(0, 0, 0)$a),
    s = s,
    x0 = p0[1], y0 = p0[2], z0 = p0[3],
    xs = getSeq(p0[1]), ys = getSeq(p0[2]), zs = getSeq(p0[3]),
    labels = labels,
    surface.count = surface.count,
    delta = delta
  )
  model$s1 <- s(model$x0, model$y0, model$z0)
  model$f <- Vectorize(function(x, y, z) dm(model, model$s1, s(x, y, z)))
  model$points <- expand.grid(x = model$xs, y = model$ys, z = model$zs)
  model$points$f <- model$f(model$points$x, model$points$y, model$points$z)
  model$colors <- rainbow(surface.count)
  model$surface.alpha <- 1 / surface.count
  model$draw <- function(model, to.file=T) {
    with(model, {
      fs <- model$points$f
      levels <- seq(min(fs), min(fs) + (max(fs) - min(fs))/4, length = surface.count+1)[-1]
      open3d(windowRect = c(-1000, 100, -500, 600))
      contour3d(f, levels, xs, ys, zs, color = colors, alpha = surface.alpha)
      box3d();
      axes3d();
      title3d(xlab = labels[1], ylab = labels[2], zlab = labels[3])
      if (to.file) {
        snapshot3d(paste0(name, format(Sys.time(), "-%Y_%m_%d_%H_%M_%S"), ".png"))
        rgl.close()
      }
    })
    T
  }
  model
}
createModel.2d <- function(p0, surface.count=4, delta = 0.2)
  createModel(
    function(x, y, z) list(a = c(x, y), mu = c(-z/2, z/2)),
    c("a1", "a2", "dmu"),
    p0, surface.count, delta
  )
build.gif <- function() {
  cur.folder <- getwd()
  converter.folder <- "c:/Program Files/ImageMagick-6.9.1-Q16/"
  setwd(converter.folder)
  fullname <- paste0(cur.folder, "/", name)
  conv.cmd <- paste0("convert -delay 5 ", fullname, "*.png -coalesce -duplicate 1,-2-1 -loop 0 ", cur.folder, "/../figures/", name, "/", name ,".gif")
  system(conv.cmd)
  #unlink(paste0(fullname, "*.png"))
  setwd(cur.folder)
}
draw <- function(model) model$draw(model)

for (mu in seq(0.1, 5, by = 0.08))
  draw(createModel.2d(c(1, 1, mu)))
build.gif()
