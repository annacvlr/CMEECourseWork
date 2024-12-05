# CMEE bootcamp HPC week


## Description
Covering the basics for HPC and working on the cluster. 

## Languages 
R
    
## Dependencies

## Installation

## Project Structure and Usage
- Code: Contains Python files
- Data: Where all the data used has been collected
- Results: Contains the results from the code. 

##Code

**ac524_HPC_2024_demographic_cluster.R**: This script runs a stochastic demographic simulation model in a High-Performance Computing (HPC) environment, designed to project population dynamics over time. The script leverages parallel processing, allowing different initial conditions to be simulated across multiple nodes.
Key Features:
    - Clearing Workspace and Loading Functions:
        The script begins by clearing the R environment and loading necessary functions from an external file (Demographic.R) that supports the simulation process.
    - Cluster Job Initialization:
        The script is designed to run in parallel on an HPC cluster. It uses a job number (iter) to control the seed for random number generation, ensuring each parallel job has a unique initialization.
    - Model Parameter Definitions:
        Parameters such as Clutch Distribution, Growth Matrix, and Reproduction Matrix are defined. These matrices describe the population's growth rates, reproduction strategies, and the distribution of offspring.
    - Initial State Setup:
        The script initializes the population state based on predefined conditions (e.g., adults or spread across life stages). The initial state is chosen depending on the job number (iter), which selects one of several possible conditions for each parallel run.
    - Running Simulations:
        The script performs a set of 150 stochastic simulations. Each simulation uses the initial conditions defined earlier and runs a population model over a fixed time period (120 steps). Results are stored in a list and saved to a file specific to the job number.
    - Data Saving:
        After running the simulations, the results are saved into a .rda file for further analysis. This file can be used for post-processing or visualization of the simulation outcomes.
    - Parallel Execution:
        As the script is intended for HPC use, it allows multiple simulations to run concurrently, making efficient use of computational resources. This parallel approach speeds up the analysis process and helps in running large-scale simulations for demographic studies.
This script models population dynamics using stochastic processes, where random variables (like growth rates and reproductive success) are incorporated to simulate realistic population changes. It is useful for ecological modeling, conservation studies, and demographic research where understanding population growth under uncertainty is critical. The model can be applied to a variety of species and is particularly useful for studying populations with complex life cycle stages.

**ac524_HPC_2024_main.r** The script is structured to simulate demographic and ecological models for species populations using both deterministic and stochastic methods, employing high-performance computing (HPC) resources for parallel execution. Below is an overview of the key sections:
User Information and Setup:

    Personal Information: The user defines their name, preferred name, email, and username, which are stored in variables.
    Workspace Note: A reminder is given not to clear the workspace in this section to ensure that essential information remains intact for subsequent code executions.

Section One: Stochastic Demographic Population Model
Question 0: Initializing Population States

Two functions are defined for initializing the population:

    state_initialise_adult: Sets all individuals to the adult life stage.
    state_initialise_spread: Evenly distributes individuals across all life stages with a small adjustment for any remainder.

Question 1: Deterministic Simulation

This function runs a deterministic simulation for a population with four life stages and an initial population size of 100 individuals. It compares two initial conditions:

    One with all individuals as adults.
    Another with individuals spread across all life stages. The simulation is run for 24 steps, and the population sizes over time are plotted and saved as question_1.png. The plot compares the growth under these two conditions, and a brief explanation about how the initial distribution affects population growth is provided.

Question 2: Stochastic Simulation

The function question_2 performs a stochastic simulation with the same initial conditions as Question 1 but includes variability in the model (e.g., clutch distribution). It again runs the simulation for 24 steps and compares the population size time series for both initial conditions. The resulting plot is saved as question_2.png. The function also asks for an explanation of the difference in smoothness between the deterministic and stochastic simulations.
Subsequent Questions 3-6: HPC and Cluster Execution

These questions involve parallelizing the simulation code to run on an HPC cluster. For Questions 3 and 4, code for running the simulations across multiple nodes is expected, while Questions 5 and 6 involve creating plots and providing written explanations.
Section Two: Individual-Based Ecological Neutral Theory Simulation

This section outlines a neutral ecological model, where species' population dynamics follow neutral theory assumptions (i.e., no species have an inherent advantage over others). Functions for initializing communities, simulating neutral steps, and generating time series are provided. The section includes several questions (7-20) where the user must write functions to simulate species richness, neutral evolution, and speciation over time.
Question 21: Vector Summation

A utility function, sum_vect, is defined to add two vectors of unequal lengths. The shorter vector is padded with zeros to match the length of the longer one, ensuring that their elements can be added together element-wise.
Challenge Questions (A-E)

These questions involve more complex simulations and are meant to challenge the user to apply the concepts learned in the exercises to new, more difficult problems.
Plotting and Output

For most questions, a plot is generated and saved as a .png file. These plots visualize population growth or changes in species diversity over time based on the simulated scenarios.
General Observations and Tips:

    Modular Approach: Functions are used to modularize tasks (e.g., simulation, initialization, plotting), making it easier to maintain and test individual components.
    HPC Utilization: For scalability, especially in larger simulations, the script utilizes HPC resources for parallel execution, which is essential for running large-scale simulations in reasonable timeframes.

This script is designed for advanced ecological modeling, where both deterministic and stochastic models are used to simulate population dynamics over time. It emphasizes the importance of understanding how initial conditions influence long-term population growth and how computational tools can be used to explore complex ecological systems efficiently. The integration of HPC resources ensures that large-scale simulations can be handled efficiently, while the modular code structure promotes flexibility and reusability in the modeling process.

**ac524_HPC_2024_neutral_cluster.R** This setup suggests that the exercise will involve running simulations based on a neutral ecological model, possibly on an HPC cluster, with the provided script (abc123_HPC_2024_main.R) containing the main logic, such as function definitions for population modeling, speciation, or statistical analysis. The rest of the code that will follow (likely in abc123_HPC_2024_main.R) will likely define more detailed steps, such as defining population parameters, running simulations, and possibly visualizing or analyzing the output data.


**ac524_HPC_2024_test.R**: The script sources two key R files, ac524_HPC_2024_main.R and Demographic.R, which contain functions to be used in the exercises. It is structured to allow for testing and debugging functions that will be used in cluster-based simulations.
Key Features:

    Function Sourcing: The script begins by sourcing external R scripts that contain the necessary functions for the exercises. These files are expected to define the key functions used for the exercises.
    Function Testing: The script allows you to test individual functions (like species_richness(), state_initialise_adult(), and sum_vect()) interactively to ensure they work correctly before being used in larger simulations.
    Environment Cleanup: It starts by clearing the R environment (rm(list=ls())), ensuring that no leftover objects interfere with the script’s execution.
    Debugging: The script is useful for debugging, where you can modify and test smaller parts of the code. However, it is recommended that the code be tidied up before final submission, especially before integrating it into the main simulation run.

The main goal of the script is to define and test functions in isolation, preparing them for later use in the main simulation code. This approach is meant to help maintain an organized workflow and ensure that all functions are properly tested before running large simulations on the cluster.

**Demongraphic.R**:This script is designed for simulating stochastic and deterministic demographic models in a population over time, as part of the CMEE 2024 HPC exercises. It contains functions to model population dynamics, both deterministically (fixed transitions between states) and stochastically (incorporating randomness in transitions).
Key Functions:

    Deterministic Model:
        deterministic_step(): Calculates the next state of the population using a projection matrix.
        deterministic_simulation(): Runs a simulation for a given length, applying the deterministic model to update population sizes at each time step.

    Stochastic Model:
        multinomial(): Simulates the multinomial distribution for survival/maturation and death probabilities.
        survival_maturation(): Updates the population state based on survival and maturation probabilities derived from a growth matrix.
        random_draw(): Makes a random selection based on a probability distribution.
        stochastic_recruitment(): Calculates the recruitment probability for new individuals based on the reproductive matrix and clutch size distribution.
        offspring_calc(): Calculates the number of offspring produced at each time step, accounting for recruitment and clutch sizes.
        stochastic_step(): One step of the stochastic model, updating the population with survival, maturation, and offspring.
        stochastic_simulation(): Runs a full simulation of the population using the stochastic model, stopping if the population reaches zero.

Purpose:

    Deterministic models assume fixed transitions and predictable population changes, while stochastic models incorporate randomness, making them more suitable for modeling real-world biological processes where variability and uncertainty are common.
    The script is designed to simulate both models over a specified time period and can be extended for use in high-performance computing (HPC) environments to run large-scale simulations efficiently.
    
        
## Author
   Anna Cavalieri Canosa
    	ac524@ic.ac.uk

