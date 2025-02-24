name <- "Anna Cavalieri Canosa"
preferred_name <- "Anna"
email <- "ac524@imperial.ac.uk"
username <- "ac524"

source("Demographic.R")
library(ggplot2)
question_6 <- function() {
    library(ggplot2)

    # Locate RDA files (Ensure correct filename pattern)
    result_files <- list.files(path = "rda", pattern = "^simulation_quest4_\\d+\\.rda$", full.names = TRUE)

    if (length(result_files) == 0) {
        stop("No simulation result files found in the RDA directory.")
    }

    # Store population time series for large and small spread conditions
    pop_data <- list(
        "Large Population Spread" = list(),
        "Small Population Spread" = list()
    )

    # Helper function: get condition index
    get_condition_index <- function(iter) {
        return((iter - 1) %% 4 + 1)  # Maps iteration number to a condition index
    }

    # Load relevant simulations
    for (file_path in result_files) {
        fname <- basename(file_path)  # Extract filename

        # Extract numeric part of filename safely
       iter_str <- sub(".*_(\\d+)\\.rda$", "\\1", fname)

        iter <- as.numeric(iter_str)

        if (is.na(iter)) {
            print(paste("Skipping file with invalid iteration number:", fname))
            next  # Skip files with invalid names
        }

        cond_index <- get_condition_index(iter)

        print(paste("Processing file:", fname, "Iteration:", iter, "Condition Index:", cond_index))

        if (!is.na(cond_index) && (cond_index == 3 || cond_index == 4)) {
            load(file_path)  # Loads 'simulation_results' list

            if (!exists("simulation_results") || length(simulation_results) == 0) {
                print(paste("Skipping empty file:", fname))
                next  # Skip empty files
            }

            cond_name <- if (cond_index == 3) "Large Population Spread" else "Small Population Spread"

            # Store simulation results efficiently
            pop_data[[cond_name]] <- append(pop_data[[cond_name]], simulation_results)
        }
    }

    # Print debugging info
    print("Final population data counts:")
    print(sapply(pop_data, length))  # Check if data was stored correctly
}

question_6()



