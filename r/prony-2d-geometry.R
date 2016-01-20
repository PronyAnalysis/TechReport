library(rgl)
library(ggplot2)
library(dplyr)

# generator
system("mcs -o+ prony-2d-geometry.cs")

generate <- function(h, make.2d = T, make.3d = T, show = T, save = F) {
  # create data
  system(paste("prony-2d-geometry.exe", h))
  
  # loading and processing
  df <- read.csv("data.csv", sep=";")
  breaks <- c(0, 0.0001, 0.0003, 0.0005, 0.0007, 0.001, 0.002, 0.006, 0.01, 0.02, 0.06, 100)
  clen <- length(levels(cut(df$value, breaks = breaks)))
  colorlut <- rainbow(clen)
  col <- colorlut[df$category]
  df <- df %>% 
    mutate(category = as.numeric(cut(value, breaks = breaks, labels = 1:clen))) %>% 
    mutate(interval = cut(value, breaks = breaks)) %>% 
    mutate(color = colorlut[category])
  
  # plots
  if (show | save) {
    if (make.2d) {
      p <- ggplot(na.omit(df), aes(x = x, y = y, fill = interval)) + geom_raster() +
        ggtitle(paste("h =", h)) + xlab("x") + ylab("y") + guides(fill = guide_legend(title = "Eps")) +
        scale_fill_manual(values = colorlut) + theme_bw()
      if (show)
        print(p)
      if (save)
        ggsave(paste0("../figures/prony-2d-geometry/plot2d-h", h, ".png"), p)
    }
    if (make.3d) {
      xs <- unique(df$x)
      ys <- unique(df$y)
      open3d(windowRect = c(-1000, 100, -500, 600))
      surface3d(xs, ys, matrix(df$value, nrow=length(xs), ncol=length(ys)), color = df$color, back = "lines")
      par3d(userMatrix = rotationMatrix(-pi/4 - pi, -0.15, 0.3, 1))
      if (save)
        snapshot3d(paste0("../figures/prony-2d-geometry/plot3d-h", h, ".png"))
      if (!show)
        rgl.close()
    }
  }
}

for (h in c(0.025, 0.05, 0.1, 0.2, 0.4))
  generate(h, show = F, save = T)

# generate(0.1)