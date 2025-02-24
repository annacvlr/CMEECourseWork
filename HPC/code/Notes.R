
# Question 6
question_6 <- function(){
  # filter cond 3 & 4 
  rda_files <- list.files(path= "rda", pattern= "^simulation_quest4", full.names = TRUE)
  iter_values <- sapply(rda_files, function(file) as.numeric(gsub("^.*_(\\d+)\\.rda$", "\\1", basename(file))))
  #head(iter_values) #debug - works
  selected_files <- rda_files[iter_values >50] #condition 3 & 4
  pop_trends_list <- list()

  for (file in selected_files) {
    load(file)
    iter <- iter_values[which(rda_files== file)]
    

    #seperate the 2 conditions
    if (iter > 50 && iter <= 75) {
        initial_condition <- "Large Population Spread"
    } else if ( iter > 75 && iter <= 100) {
        initial_condition <- "Small Population Spread"
    } else {
        next
    }
    
  # extract time series of popu 
  pop_matrix <- do.call(cbind, results)  #convert list of timeseries to matrix

  temp_data <- data.frame(
    Time = seq_len(nrow(pop_matrix)), #time steps
    PopulationSize = rowMeans(pop_matrix, na.rm = TRUE), 
    InitialCondition = rep(initial_condition, nrow(pop_matrix))
  )
  
  pop_trends_list[[length(pop_trends_list)+ 1]] <- temp_data
  }
  
  
  pop_trends <- do.call(rbind, pop_trends_list)
  
  if (!all(c("Large Population Spread", "Small Population Spread") %in% pop_trends$InitialCondition)) {
  stop("Error: Missing one or both initial conditions in pop_trends")
   }
  #head(pop_trends)
  #table(pop_trends$InitialCondition) #debug we good

  #projection matrix
  growth_matrix <- matrix(c(0.1, 0.0, 0.0, 0.0,
                          0.5, 0.4, 0.0, 0.0,
                          0.0, 0.4, 0.7, 0.0,
                          0.0, 0.0, 0.25, 0.4),
        nrow=4, ncol=4, byrow=T)

  reproduction_matrix <- matrix(c(0.0, 0.0, 0.0, 2.6,
                          0.0, 0.0, 0.0, 0.0,
                          0.0, 0.0, 0.0, 0.0,
                          0.0, 0.0, 0.0, 0.0),
        nrow=4, ncol=4, byrow=T) #byrow T = fill out the row by row

  projection_matrix = reproduction_matrix + growth_matrix

  deterministic_results_list <- list()
  initial_state = rep(pop_trends$PopulationSize[1], 4)
  #head(initial_state)

  simulation_length = nrow(pop_trends)

  pop_trends <- do.call(rbind, pop_trends_list)
  #head(pop_trends)
  deterministic_results <- deterministic_simulation(
    initial_state = initial_state,
    simulation_length = simulation_length,
    projection_matrix = projection_matrix
  )

  pop_trends$DeterministicPopulation <- deterministic_results[1:nrow(pop_trends)]
  pop_trends$Deviation <- pop_trends$PopulationSize / pop_trends$DeterministicPopulation
head(pop_trends)

table(pop_trends$Time)
pop_trends$Time <- as.numeric(pop_trends$Time)
table(pop_trends$Deviation)

pop_trends$Deviation <- as.numeric(as.character(pop_trends$Deviation))
str(pop_trends)

table(pop_trends$Deviation == 0)
min(pop_trends$Deviation)



  png(filename="question_6.png", width = 600, height = 400)
    ggplot(pop_trends, aes(x= as.numeric(Time), y = Deviation, color = InitialCondition, group = InitialCondition)) +
      geom_point()+
      geom_smooth(se = FALSE) +
      facet_wrap( ~InitialCondition, scales = "free_y")+
      labs( 
        title = " Deviation of Stochastic Model from Deterministic Model", 
        x = "Time Step", 
        y = "Stochastic / Deterministic Population Size") +
      theme_minimal()
  
  # plot your graph here
  Sys.sleep(0.1)
  dev.off()
  
  deviation_means <- aggregate(Deviation ~ InitialCondition, data = pop_trends, mean)
  best_fit <- deviation_means$InitialCondition[which.min(abs(deviation_means$Deviation - 1))]
  #paste(deviation_means)
  #paste(best_fit)

  best_deviation_value <- deviation_means$Deviation[deviation_means$InitialCondition == best_fit]

  explanation <- paste0 ("Both Large and Small Population Spread have deviations below 1. But ", best_fit, 
  " has a deviation closer to 1 than the alternative.", 
  "The Deviation stays around: ", best_deviation_value, " demonstrating that", 
  "the stochastic simulations predicted lower population sizes compared to the deterministic model.",
  "Population growth is slower in the stochastic model, likely to be due to random extinction risk and variability.", 
  "Addtionally, the Deterministic model assumes ideal conditions", 
  "environmental fluctuations may therefore be affecting the stochastic model")
 
  print(explanation)
  return(explanation)
}

question_6()