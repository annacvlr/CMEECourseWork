## plotting values of a matrix

require(reshape2)
require(ggplot2)

GenerateMatrix <- function(N) {
    M <- matrix(runif(N*N), N, N)
    return(M)
}

M <- GenerateMatrix(10)
Melt <- melt(M)

p <- ggplot(Melt, aes(Var1, Var2, fill = value)) + geom_tile() + theme(aspect.ratio=1)
p
p + geom_tile(colour = "black") + theme(aspect.ratio = 1)
p + theme(lengend.position = "none") + theme(aspect.ratio = 1)
p + theme(legend.position = "none", 
        panel.background = element_blank(), 
        axis.ticks = element_blank(),
        panel.grid.major = element_blank(),
        axis.text.x = element_blank(),
        axis.title.x = element_blank(),
        axist.text.y = element_blank(),
        axis.title.y = element_blank())

p + scale_fill_continuous(low = "yellow", high= "darkgreen")
p + scale_fill_gradient2()
p + scale_fill_gradientn(colours= grey.colors(10))
p + scale_fill_gradientn(colours= rainbow(10))
p + scale_fill_gradientn(colours= c("red", "white", "blue"))
