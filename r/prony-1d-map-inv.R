source("tools.R")

map <- map2d("Prony-1D inverse map", "m0", "m1", "x", "a",
   levels = c(0.2, 0.3, 0.4), 
   0.5, # m0
   2, # m1
   function(m0, m1) m0, 
   function(m0, m1) m1 / m0)
map$plot
ggsave("../figures/prony-1d-map-inv/prony-1d-map-inv.png", map$plot)