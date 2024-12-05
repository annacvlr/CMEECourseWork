## Script on Is Florida Getting Warmer?

rm(list=ls())


load("../data/KeyWestAnnualMeanTemperature")

ls()

class(ats)

head(ats)

plot(ats)



#compute appropiate correlation coef betw years and temp and store it cor()

#repeat calc for sufficient number of times, eac time randomly reshuffle the temps (sample function)
#calculate what fraction of random correlation coefficients were greater than the observed one (asymptotic p value)

#interpret & present results in pdf doc writen in Latex - include cod ein submission

tail(ats)

#asssign variables Year and Temp
year <- ats$Year
year
temp <- ats$Temp
temp


#correlation coeff 
correl <- cor(year, temp)#

n_perm <- 10000
random_corr <- numeric(n_perm)
random_corr

for (i in 1: n_perm){
    suffle_temp <- sample(temp)
    random_corr[i] <- cor(year, suffle_temp)
}

p_value <- mean(random_corr >= correl)
p_value


jpeg("../results/random_correlation_hist.jpg")
hist(random_corr, breaks = 50, main = "Random Correlation Distribution",
     xlab = "Correlation Coefficients", col = "lightblue")
abline(v = correl, col = "red", lwd = 2, lty = 2)
legend("topleft", legend = paste("Observed Cor:", round(correl, 3)), 
       col = "red", lwd = 2, lty = 2)

dev.off()
cat("Observed Correlation:", correl, "\n")
cat("P-value:", p_value, "\n")

round(correl,3)

latex_content <- paste0("
\\documentclass{article}
\\usepackage[margin=1in]{geometry}
\\usepackage{amsmath}
\\usepackage{graphicx}
\\begin{document}

\\section*{Computational Biology Bootcamp Assignment: Permutation Test for Correlation}
Author : Anna Cavalieri Canosa}

\\section*{Introduction and Methodology}
The \\emph {KeyWestAnnualMeanTemperature} dataset was analysed in R using Visual Studio Code. 
A permutation test was carried out to evaulate the correlation between years and temperature. 
The test involved ", n_perm, " random shuffles of the temperature data to assess the likelihood of observing the correlation by chance.

\\section*{Results and Conclusion}
The observed correlation coefficient was $r = ", round(correl,3), "$, indicating a moderate positive relationship between years and temperature. 
This suggests that, on average, temperatures have increased over time. This relationship was found to be ",ifelse(p_value < 0.05, "statistically significant.", "not statistically significant."), "
as the p-value obtained was $p = ", round(p_value,5), "$. The null hypothesis was therefore ",ifelse(p_value < 0.05, "rejected.", "accepted."), ". 
This outcome indicates that the observed correlation is highly ",ifelse(p_value < 0.05, "unlikely", "likely"), " to be due to random chance. 
Figure 1 below illustrates the distribution of random correlation coefficients obtained from the permutation test. 
The observed correlation is represented by a red dashed line, which is absent in the figure. This absence highlights the extremity of the observed correlation and reinforces its statistical significance. 


\\begin{figure}[h!]
\\centering
\\includegraphics[height = 0.6\\textwidth]{../results/random_correlation_hist.jpg}
\\caption{Histogram of random correlation coefficients from the permutation test.}
\\label{fig:random_corr_hist}
\\end{figure}


\\end{document}
")

# Write LaTeX content to a .tex file
writeLines(latex_content, "../results/correlation_test.tex")

#convert latex to pdf
#pdflatex correlation_test.tex
# Message
cat("LaTeX document generated: correlation_test.tex\n")