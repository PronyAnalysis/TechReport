source("tools.R")

map <- map2d("Prony-1D map", "x", "a", "m1", "m0", 
  levels = c(1, 1.5, 2), 
  c(1, 1.5, 2), # x
  2, # a
  function(x, a) x * a, # m1
  function(x, a) a, # m0
)
map$plot
ggsave("../figures/prony-1d-map/prony-1d-map.png", map$plot)