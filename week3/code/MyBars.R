#annotating plots 


##creates a bar chart on the data Results.txt and creates a pdf .
require(ggplot2)
a <- read.table ("../data/Results.txt", header = TRUE)
head(a)

a$ymin <- rep(0, dim(a)[1]) #append a col of zeroes



#range(a$y1)  # Check range of y1
#range(a$y2)  # Check range of y2

#1st linerange
p <- ggplot(a)
p <- p + geom_linerange(data =a, aes(
    x = x,
    ymin = ymin,
    ymax = y1,
    size = (0.5)
    ),
    colour= "#E69F00",
    alpha = 1/2, show.legend = FALSE)
p

#2nd linerange
p <- p + geom_linerange(data = a, aes(
        x = x,
        ymin = ymin, 
        ymax = y2,
        size =(0.5)
        ),
        colour = "#56B4E9",
        alpha = 1/2, show.legend = FALSE )

#3rd linerange
p <- p + geom_linerange(data = a, aes(
            x = x,
            ymin = ymin, 
            ymax = y3, 
            size =(0.5),
            colour = "#D55E00",
            alpha = 1/2, show.legend = FALSE))
####
#labels
p <- p + geom_text(data = a, aes(x = x, y = -500, label = Label))


##creating pdf 
pdf("../results/MyBars.pdf")
#set new axis labels, remove legend
p <- p + scale_x_continuous("My x axis", 
            breaks = seq(3, 5, by = 0.05)) + 
            scale_y_continuous("My y axis") + 
            theme_bw() +
            theme(legend.position = "none")

p
dev.off() 


