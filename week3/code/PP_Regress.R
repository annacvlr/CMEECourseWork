###VISUALISING REGRESSION ANALYSES###
#       Script that draws and saves a pdf file with a figure, writing an accompanying regression results to a formatted table in csv


#load libraries 
library(ggplot2)
library(dplyr)


#load data and locations for output plots and csv files
data <- read.csv("../data/EcolArchives-E089-51-D1.csv")



##egression results corresponding to the lines fitted in the figure and save it to a csv delimited table

reg_data <- data %>%
        group_by(as.factor(Predator.lifestage), as.factor(Type.of.feeding.interaction)) %>% 
        group_modify(function(sub_data, group_id) {
        if (nrow(sub_data) >=3) { #check for minimum 3 rows of data 
            lm_model <- summary(lm(log(Predator.mass) ~ log(Prey.mass), data = sub_data)) # fit data to a log linear model

            #stats were interested in
            intercept <- lm_model$coefficients ["(Intercept)", "Estimate"]
            slope <- lm_model$coefficients["log(Prey.mass)", "Estimate"]
            rsqu <- lm_model$r.squared
            p_value <- lm_model$coefficients["log(Prey.mass)", "Pr(>|t|)"]
            f_stat <- lm_model$fstatistic[1]

            data.frame(
                Size = nrow(sub_data),
                Intercept = intercept,
                Slope = slope, 
                RSquared = rsqu, 
                PValue = p_value,
                FStat = f_stat, 
                Note = NA
                )
        } else {
            data.frame(
                Size = nrow(sub_data), 
                Intercept = NA, 
                Slope = NA, 
                RSquared = NA, 
                PValue = NA,
                FStat = NA,
                Note = "Not enough data"
                )
            }
           
})

View(reg_data)

write.csv(reg_data, "../results/PP_Regress_Results.csv", row.names = TRUE)

        
data <- data %>%
  filter(!is.na(Predator.mass), !is.na(Prey.mass)) %>% # Remove NAs
  mutate(
    FeedingType = as.factor(Type.of.feeding.interaction),
    PredatorLifeStage = as.factor(Predator.lifestage)
  )


# plot

pdf("../results/PP_Regress_Plot.pdf", height = 10) #location pdf will be in

plot <- ggplot(data, aes(x = Prey.mass, y = Predator.mass, color = PredatorLifeStage)) +
  geom_point(alpha = 1, shape = 3 ) + # Scatter plot
  scale_x_log10() + # Log for Prey Mass
  scale_y_log10() + # Log for Predator Mass
  geom_smooth(method = "lm", se = TRUE, fullrange = TRUE, size = 0.5 ) + # Add lines
  facet_wrap(~ FeedingType, ncol = 1, scales = "free_y", strip.position = "right") + # Facet by Feeding Type
  labs( #labels
    x = "Prey Mass in grams",
    y = "Predator Mass in grams",
    
  ) +
  theme_minimal() + # Clean theme
  theme( #add little things, rotation of facet titles, box around plots...
    strip.text = element_text(angle = -90, size = 10),
    legend.position = "bottom", 
    strip.background = element_rect(colour = "dark grey", fill = "grey"),
    panel.border = element_rect(colour = "grey", size = 1, fill = NA),
    legend.title = element_text(face = "bold")
  )

  plot

  dev.off()



##creating pdf 

