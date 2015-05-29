library(lattice)

xyplot(CCYExposure ~ Date|factor(FundCode), 
       data = PltsData,
       panel = function(x,y) {
         panel.grid(h=-1, v=2)
         I1 <- order(x)
         llines(x[I1], y[I1], col=1)
       })