source("tools.R")

map <- map2d("Prony-1D inverse map", "m1", "m0", "x", "a",
   levels = c(0.2, 0.4), 
   2, # m1
   0.5, # m0
   function(m1, m0) m1 / m0, # x
   function(m1, m0) m0 # a
)
map$plot
ggsave("../figures/prony-1d-map-inv/prony-1d-map-inv.png", map$plot)