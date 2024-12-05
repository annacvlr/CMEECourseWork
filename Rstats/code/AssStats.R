##script changing bud burst scores into dummy variables, and making stat tests

library(ggplot2)
library(lubridate)
library(dplyr)
library(tidyr)

data <- read.csv("../data/merged.csv")#


## CONVERT BUDBURST score TO DUMMY VARIABLES 0,1,2
data <- data %>%
  mutate(Score_numeric = case_when(
    Score %in% c("2", "<2", ">2") ~ 1, ##bursting 
    Score %in% c("<3", "3", ">3", "4", "<4", ">4", "5", "<5", ">5", "<6", "6") ~ 2, ##bursted
    Score %in% c("0", "<1", ">1", "1") ~ 0, ##not bursted
    TRUE ~ NA_real_
  ))


head(data)

#remove all rows with Score NA
data <- data %>% 
    filter(!is.na(Score_numeric))
    
glimpse(data)
summary(data$Score_numeric)

head(data)

##calculate year date 
data$DateofYear <- yday(data$Date.x)
head(data)


#filter to only have day of year where the bud is bursting (Score numeric ==1 )
testdata <- data %>% 
    filter (Score_numeric == 1)

head(testdata)



##calculate year date where Numeric score is 1 -- date of the year were it budburst
ggplot(data = testdata, aes (x = DateofYear, y=Girth_cm)) +
    geom_point()
    #geom_smooth(method = "lm", col = "blue") 


#budburst vs girth 1)VISUALISE
ggplot(data = testdata, aes(x = as.factor(Score_numeric), y = Girth_cm))+
    geom_boxplot()


ggplot(data = testdata, aes(x = as.factor(DateofYear), y = Girth_cm))+
    geom_boxplot()

#summary stats
summary(testdata$DateofYear)
  # Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
 #  82.0   100.0   109.0   108.4   116.0   142.0 

 summary(testdata$Girth_cm)
  # Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
#   8.0    79.0   117.0   134.8   167.0   601.0

##because they are 2 continuous variables - days of the year and cm -- Linear regression model
linearmodel <- lm(Girth_cm ~ DateofYear, data = testdata)
summary(linearmodel)
AIC(linearmodel)

ggplot(testdata, aes(x=DateofYear, y = Girth_cm)) +
    geom_point(color="blue") +
    geom_smooth(method = "lm", se = FALSE, color = "red", lwd = 1 ) 

dev.off()

## testing assumptions of lm
    #1) linearity -- linearity assumption may be violated
plot(testdata$DateofYear, testdata$Girth_cm, main = "linear relationship", 
    col= "blue")
    abline(linearmodel, col = "red", lwd = 2)

    #2) independence of errors
    plot(fitted(linearmodel), residuals(linearmodel), 
    pch = 19, col = "blue")
    abline(h=0, col="red")
    
    library(car)
    durbinWatsonTest(linearmodel)

    #3) homoscedasticity 
    #4) normality of residuals ## skewed to the right
    hist(residuals(linearmodel), 
    main = "histogram of residuals", 
    col = "lightblue", breaks = 30)

    qqnorm(residuals(linearmodel))
    qqline(residuals(linearmodel)), col = "red")


    plot(linearmodel, which = 3) 
    plot(linearmodel, which = 4)



polymodel<- lm(Girth_cm ~ poly(DateofYear, 4), data = testdata)
summary(polymodel)
AIC(polymodel)

model_log <- lm(Girth_cm ~ log(DateofYear), data = testdata)
summary(model_log)
AIC(model_log)

model_exp <- lm(log(Girth_cm) ~ DateofYear, data = testdata)
summary(model_exp)
AIC(model_exp) ###### best AIC

ggplot(testdata, aes(x=DateofYear, y = sqrt(Girth_cm))) +
    geom_point(color="blue") +
    geom_smooth(method = "lm", se = FALSE, color = "red", lwd = 1 )





#plot
pred_log <- predict(model_exp, newdata= testdata)
pred_exp <- exp(pred_log)
ggplot(testdata, aes(x=DateofYear, y=Girth_cm))+
    geom_point(colour="blue") +
    geom_line(aes(x=DateofYear, y = pred_exp), color="red", size =1)
###variance is very high so not an log transformed linear regression model
dev.off()

library(forecast)
arima_model <- auto.arima(testdata$Girth_cm)
summary(arima_model)
AIC(arima_model)

library(mgcv)
gam_mod <- gam(Girth_cm ~ s(DateofYear), data = testdata)
summary(gam_mod)
AIC(gam_mod)

gam_model <- gam(log(Girth_cm) ~ s(DateofYear), data = testdata)
summary(gam_model)
AIC(gam_model) ####lowest AIC yet but R2 is 4.7%
plot(gam_model, select=1)



lm_poly <- lm(log(Girth_cm) ~ poly(DateofYear, 2), data = testdata)
summary(lm_poly)
AIC(lm_poly)


lm_poly_model <- lm(DateofYear ~ poly(log(Girth_cm), 2), data = testdata)
summary(lm_poly_model)
AIC(lm_poly_model)


library(splines)
lm_spline <- lm(log(Girth_cm) ~ ns(DateofYear, df = 5), data = testdata)
summary(lm_spline)
AIC(lm_spline)




lm_model <- lm(DateofYear ~ log(Girth_cm), testdata)
summary(lm_model)

AIC(lm_model)
library(sjPlot)

jpeg("../Results/tab_model_output.jpg")

tab_model(lm_model, dv.labels ="Day of Year bud burst")

dev.off()

shapiro_test <- shapiro.test(testdata)

# Print results
print(shapiro_test)
dev.off()



##make a table and make it into a jpeg
install.packages("gridExtra")
install.packages("jpeg")
library(gridExtra)
library(jpeg)
a <- as.data.frame(a)
jpeg("../Results/lm_summary.jpg")
grid.table(a)

coef <- a$coefficients
coef_df <- as.data.frame(coef)
coef_df$Term <- rownames(coef_df)
print(coef_df)

jpeg("../Results/lm_summary.jpg")
grid.table(coef_df)

dev.off()
####

#3600 × 1800 p
#####PLOTTED
p <- ggplot(testdata, aes(x=log(Girth_cm) , y = DateofYear)) +
    geom_point(color="blue", alpha = 0.30, size = 1.5) +
    geom_smooth(method = "lm", se = TRUE, color = "red", lwd = 1 )+
    labs(
        title = "Relationship Between Log of Tree Girth and Date of Year",
        x = "Log of Tree Girth (cm)",
        y = "Day of year"
    ) +
      # Customize x-axis ticks (every 30th d
    theme_minimal() +
    theme(
        plot.title = element_text(hjust =0.5, size = 16, face = "bold"),
        axis.title = element_text(size = 12),
        axis.text = element_text(size = 10),
        panel.grid.major = element_line(color = "gray90", size = 0.5),
        panel.grid.minor = element_blank(),
        plot.margin = margin(20, 20, 20, 20)
    )

ggsave("../Results/Assessment.jpeg", plot = p, device = "jpeg", width = 12, height = 6)



dev.off()

summary(testdata)



    #2) independence of errors
    plot(fitted(lm_model), residuals(lm_model), 
    pch = 19, col = "blue")
    abline(h=0, col="red")
    
    library(car)
    durbinWatsonTest(linearmodel)

    #3) homoscedasticity 
    #4) normality of residuals ## skewed to the right
    hist(residuals(lm_model), 
    main = "histogram of residuals", 
    col = "lightblue", breaks = 30)
        ###bimodal histogram 


    qqnorm(residuals(lm_model))
    qqline(residuals(lm_model), col = "red")


    plot(lm_model, which = 3) 
    plot(linearmodel, which = 4)



##descriptive stats 
summary(testdata$DateofYear)
mean(testdata$DateofYear)     # Mean
median(testdata$DateofYear)   # Median
sd(testdata$DateofYear)          # Standard Deviation
range(testdata$DateofYear)    # Range (min and max)
IQR(testdata$DateofYear)      # Interquartile Range
var(testdata$DateofYear) 

#girth
summary(testdata$Girth_cm)  # Provides min, 1st Qu., median, mean, 3rd Qu., max
mean(testdata$Girth_cm)     # Mean
median(testdata$Girth_cm)   # Median
sd(testdata$Girth_cm)       # Standard Deviation
range(testdata$Girth_cm)    # Range (min and max)
IQR(testdata$Girth_cm)      # Interquartile Range
var(testdata$Girth_cm) 


Q1 <- quantile(testdata$DateofYear, 0.25)
Q3 <- quantile(testdata$DateofYear, 0.75)
IQR_value <- IQR(testdata$DateofYear)

# Calculate lower and upper bounds
lower_bound <- Q1 - 1.5 * IQR_value
upper_bound <- Q3 + 1.5 * IQR_value

# Identify outliers
outliers <- testdata$DateofYear[testdata$DateofYear < lower_bound | testdata$DateofYear> upper_bound]

# Print outliers
print(outliers)

boxplot(testdata$Girth_cm)

install.packages("e1071")
library(e1071)

# Example dataset
data <- c(2, 3, 3, 3, 4, 5, 6, 6, 8, 10)

# Calculate kurtosis
kurtosis_value <- kurtosis(data)
print(kurtosis_value)