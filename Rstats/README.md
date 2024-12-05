## My CMEE bootcamp Course Work - Statistics in R week

## Description


## Languages 
- R

## Dependencies
lubridate: For date handling and formatting.
dplyr: For data manipulation.
tidyr: For data tidying.
ggplot2: For plotting. 
WebPower: For statistical analysis. 
MASS: Modern Applied Statistics with S) is a package that provides functions for a wide range of statistical techniques, including linear and nonlinear modeling, classification, resampling, and more. It is often used for advanced statistical analyses and regression modeling.
ggpubr: extension to ggplot2, it provides additional functions to quickly add statistical annotations, customize plot themes, and adjust figure aesthetics.
mgcv: For fitting generalized additive models.
sjPlot: For exporting regression tables as images.
forecast: For time-series analysis with ARIMA models.

## Installation

## Project Structure and Usage
- Code: Contains script files.
- Data: Where all the data used has been collected.
- Results: Contains the results.
- Sandbox: Contains files that are not results, code, or data.

## Code
**assessment.R**: This script demonstrates how to perform data wrangling and cleaning in R, using multiple datasets related to tree growth, phenology, and weather data. The objective is to prepare the datasets for statistical analysis, focusing on merging datasets, handling date formats, cleaning TreeID columns, and converting phenology scores into dummy variables.
- Uploading and Inspecting the following datasets:
       a) girth: Contains girth (circumference) data of monitored trees.
       b) phenology: Contains phenology information, including leaf flushing data through spring.
       c) weather: Contains daily weather records (temperature, etc.) from a weather station.
       d) trees: Provides species and location information for oak trees.
- It then previews the first few rows of each dataset using head() to inspect the structure and contents.
- Handling Dates: The script checks and converts the Date column in the phenology dataset from a character format to Date format using lubridate::ymd(). It also converts the TIMESTAMP column in the weather dataset into a Date column (renamed as Date) using as.Date(), ensuring consistency between the phenology and weather datasets.
- Handling Girth Dates: The girth dataset includes year ranges. The script defines a function (parse_date) that extracts the start year from these ranges and creates a new DateStart column, representing the start date of the monitoring period for each tree.
- Cleaning TreeID Columns: Both girth and phenology datasets have a TreeID column, but some TreeID values contain non-numeric characters. The script:
Converts the TreeID to integers in the phenology dataset.
Filters out any non-numeric or zero values in the TreeID column to ensure that only valid tree identifiers remain.
- Merging Datasets:The script merges the phenology and girth datasets by the TreeID column using a left join (left_join()). It ensures that the DateStart from the girth dataset is less than or equal to the Date from the phenology dataset, indicating that the phenology event occurred after the tree monitoring period started.
- Grouping and Sorting Data: After merging, the dataset is grouped by TreeID, and data is arranged by the DateStart (start date of girth monitoring) and Date.x (date of phenology event). The slice_max() function is then used to keep only the most recent observation for each tree.
- Handling Phenology Scores (Dummy Variables): Although the code to convert the Score (phenology scores) into dummy variables is currently commented out, the intended approach is to use mutate() and case_when() to create a new column that classifies the phenology scores into distinct categories (e.g., bud burst, not yet burst).
- Writing the Cleaned Data: The final merged and cleaned dataset is written to a new CSV file (merged.csv) using write.csv() for further analysis or use in other scripts.

**AssStats.R**: This script is well-structured to process and analyze data related to tree phenology, specifically budburst scores, and their relationship with girth and timing metrics. Here's an overview of the key sections and operations performed in the script:
   1. Converting bud burst scores into dummy variables.
   2. Conducting statistical analyses on the relationship between the day of the year (DateofYear) and tree girth (Girth_cm).
   3. Visualizing the data through various plots.
   4. Running different regression models to explore the relationship between tree growth and bud burst timing.
   - Loading and Preparing Data: The script begins by loading the merged dataset (merged.csv) that combines girth and phenology data using read.csv().
   - Converting Bud Burst Scores to Dummy Variables: The Score column, which represents the phenological stage (e.g., bud burst), is converted into numeric dummy variables:
 1) Representing "bursting" (e.g., "2", "<2", ">2").
 2) Representing "bursted" (e.g., "3", "4", "5", "6").
 3)Representing "not bursted" (e.g., "0", "1").
  The conversion is done using mutate() and case_when() from dplyr.
   - Cleaning Data: Rows where the Score_numeric is NA are removed to ensure that only valid data is used in further analysis.
   - Calculating Day of the Year (DateofYear): The DateofYear is calculated using the yday() function from the lubridate package to represent the day of the year for each observation.
   - Filtering for Bud Burst Events: A subset of the data (testdata) is created, containing only rows where the Score_numeric equals 1 (indicating bud burst).
   - Visualizing the Data: The relationship between DateofYear and Girth_cm is visualized using ggplot2. Scatter plots, boxplots, and smoothed lines are generated to explore how the girth of trees changes during the bud burst period.
   - Descriptive Statistics: Summary statistics are calculated for both the DateofYear and Girth_cm variables, including measures like mean, median, standard deviation, range, and interquartile range (IQR).
  A boxplot is also generated to visually inspect the distribution of Girth_cm values.
   - Linear Regression Models: Several regression models are fitted to the data to explore the relationship between DateofYear and Girth_cm:
 -     Linear model: A basic linear regression model (lm()).
 -     Polynomial regression: Models with polynomial terms for DateofYear (up to degree 4).
 -      Logarithmic and exponential models: Exploring log transformations of both the predictor and response variables.
- The best model is selected based on the lowest Akaike Information Criterion (AIC).
 - Assumption Checking for Linear Models: Various diagnostic plots and statistical tests are used to check the assumptions of the linear regression model:
-    Linearity: A plot of the fitted values vs. residuals.
-    Independence of errors: Durbin-Watson test.
-    Homoscedasticity: Checking for constant variance of residuals.
-    Normality of residuals: Histogram and Q-Q plot of the residuals.
- Other Regression Models: The script explores other models like ARIMA (Auto-Regressive Integrated Moving Average) for time-series data and Generalized Additive Models (GAM) for non-linear relationships. The models are evaluated using AIC and R-squared values to find the best fitting model.
- Creating Visual Outputs he script generates several plots, including:
- Scatter plots with regression lines.
- Boxplots to visualize the distribution of girth across different days of the year.
   It saves the plots to .jpeg files for further reporting or presentation.
   - Exporting Model Results: The results of the linear regression model, including coefficients and other details, are saved as a table in .jpeg format for easy inclusion in reports.
 -  Additionally, the script generates summary plots for the models, saved as .jpeg files.
This script provides an in-depth analysis of the relationship between bud burst timing and tree growth, utilizing various regression models to explore and visualize the data. By converting phenology scores to dummy variables, checking model assumptions, and fitting multiple types of regression models, the script offers a thorough statistical analysis.

**HO1.R**: This script does mathematical exercises. 

**H02.R**: This script analyzes Tarsus measurements from the SparrowSize.txt dataset, exploring statistical summaries and visualizations.
 -   Data Loading and Exploration: Read the dataset, inspect its structure, and summarize the Tarsus variable.
 - Missing Value Handling: Identify and remove NA values.
 - Statistics: Calculate mean, median, variance, range, and standard deviation.
 - Visualizations: Create histograms with varied bin sizes, density plots, and z-score visualizations.
 - Z-Scores: Compute and visualize z-scores to standardize Tarsus.
    
**HO3.R**: This script analyzes variables in the SparrowSize.txt dataset to determine the type and summary statistics for key measurements.
   - Data Loading: Reads the dataset into R.
   - Variable Types: Determines the type of each variable (categorical or continuous).
   - Summary Statistics: Generates histograms and summary statistics for: BirdID (categorical): Assesses distribution and frequencies; Year (categorical/numeric): Reviews temporal trends; Tarsus, Bill, and Wing (continuous): Histograms and statistical summaries (mean, median, etc.).
    
**HO4.R**:
This script calculates standard errors (SE) for various measurements in sparrows (e.g., Tarsus, Wing, Bill, and Mass), and performs statistical tests to assess differences and hypotheses.
   - Data Preparation:Load the dataset (SparrowSize.txt) and handle missing values using subset.Separate data for specific years (e.g., 2001) for targeted analyses.
   - Calculations: Compute SE for different measurements:Tarsus, Wing, Bill, Mass
   - Statistical Tests:
    A) One-sample t-test: Compare Tarsus mean to a hypothetical value (e.g., 18.5).
    B) Two-sample t-test: Assess differences in Tarsus between sexes.
   - Summaries:
    Calculate summary statistics (e.g., mean, length) for variables.
    Test for specific years or subsets of the data.
   - Requirements. Required Package: dplyr for data manipulation.The script assumes that missing values are encoded as "NA" and filters these values for each variable.
   - Output:
    SE Calculations for each measurement and specific year subsets.
    t-test Results for mean comparisons and between-group differences.
    Useful for understanding sparrow morphology and its variations.
        
**HO5.R**: This script compares sparrow wing lengths (Wing) across years and sexes, using statistical tests to identify significant differences. 
  - Key comparisons include:
    a) Wing length in 2001 vs. the overall (grand-total) mean.
    b) Differences in wing length between sexes in 2001.
    c) Differences in wing length between sexes across the entire dataset.
- Data Preparation: Load the SparrowSize.txt dataset. Filter out missing values for Tarsus and ensure accurate comparisons.
- Analyses:
    Comparison 1: Test if the mean wing length in 2001 differs from the grand-total mean.
    Comparison 2: Test if male and female wing lengths differ in 2001.
    Comparison 3: Test if male and female wing lengths differ in the full dataset.
- Statistical Tests:
    Perform one-sample t-tests (e.g., 2001 wing length vs. grand-total mean).
    Perform two-sample t-tests (e.g., male vs. female wing lengths).
   - Reporting:
   Summarize results in a table, including sample sizes (N).
       Interpret results in plain text for clarity.
   - Requirements
       dplyr: For data manipulation.
   - Ensure the dataset is correctly structured with NA values representing missing data.
   - Output
   A. Statistical Test Results:
-       Whether wing length in 2001 differs significantly from the grand-total mean.
 -      Differences in wing length between males and females in 2001 and across the full dataset.
   B. Key Findings:
- Wing lengths in 2001 do not significantly differ from the grand-total mean.    
- Statistically significant differences exist in wing lengths between males and females in 2001, with males having longer wings (mean difference: 2.19 cm).
- Differences in wing length between sexes are also significant across the full dataset.
This analysis provides insights into sparrow wing morphology and its variations across time and sexes.


**HO6.R**:This script performs basic statistical analysis and a power analysis for two variables x and y. Key steps include linear regression modeling, calculating effect size, statistical power, and sample size, along with plotting results.
   - Basic Statistical Analysis: 
    A) Linear Regression: The script fits a linear model (lm(y~x)) to the data and outputs a summary, ANOVA table, residuals, covariance, and variance.
    B) Plotting: The relationship between x and y is visualized using a scatter plot.
    C) Regression Equation: The fitted line equation y = 0.8288x + 2.6164 is displayed.
   - Statistical Power Analysis:
    a) WebPower Package: The WebPower package is used to calculate the required sample size for achieving a specific statistical power.
    b) Effect Size and Power: The script calculates power for a two-sample t-test with an effect size of 0.25 and 80% power. It explores how sample size influences power and generates plots for the results.
    c) Sample Size for Desired Power: Given a small effect size (e.g., d=0.11), the script estimates the required sample size to achieve 80% power.
   - Requirements
    dplyr: For data manipulation.
    WebPower: For statistical power analysis.
   - Output: The summary and ANOVA results from the linear regression model.
   - Plots:
    A plot showing the relationship between x and y.
    A plot of statistical power against sample size.
   - Power Calculations:
    The probability of detecting an effect based on different sample sizes.
    Estimated sample sizes required for a desired power level.
This script is useful for understanding how statistical power and sample size relate to detecting meaningful differences in data, and it provides a basis for making data-driven decisions about study design.

**HO6.R**: This script demonstrates how to work with vectors in R, including accessing elements by index, performing simple arithmetic, and plotting linear relationships. It also shows how to create custom plots with grid lines and segments.
   - Vector Indexing:The script creates a sequence of numbers (x) from -5 to 5. It then shows how to access specific elements of the vector using indexing. Examples include accessing the first, second, and last elements of the vector using both direct indexing and a sequence of indices.
   - Plotting a Simple Linear Model:
    Linear Equation: A linear model y = a + b * x is defined where a = 2 and b = 1.
    The script then generates a plot of x versus y using this equation.
       Grid Lines and Segments: The plot is enhanced with grid lines and segments at the origin (both vertical and horizontal lines).
   - Plotting Adjustments:
       The plot is initially drawn with a white background, and grid lines are added using segments() to mark the x and y axes.
       The abline() function is used to plot the straight line defined by the equation y = 2 + 1 * x.
   - Output: A plot showing a simple linear relationship between x and y. Grid lines indicating the x and y axes, along with a plotted line based on the linear equation.

**HO7.R**: This script demonstrates how to work with simple linear functions, including accessing vector elements using indexing, applying linear functions to data, and visualizing the results using plots in R.
 - Vector Creation and Indexing:
       A sequence x from -5 to 5 with a step size of 1 is created using seq(-5, 5, 1).
       Different methods are used to access elements in the vector x, such as using the [[ ]] operator and checking specific indices:
    Access the first element (x[[1]]).
    Access the last element using x[[length(x)]].
    Indexing is also demonstrated using a sequence (i <- seq(0, 10, 1)).
   - Linear Function:
    A linear function y = a + b * x is defined, where a = 2 and b = 1. This function is applied to the sequence x to compute y.
   - Plotting:
    The relationship between x and y is visualized using the plot() function.
    Grid lines are added using the segments() function to highlight the x and y axes.
    The line corresponding to the linear equation y = 2 + 1 * x is added using the abline() function.
   - Plot Customization: The plot background is set to white using col="white". Dashed grid lines are added at the axes using segments(0, -10, 0, 10, lty=3) and segments(-10, 0, 10, 0, lty=3). The line defined by the linear function is drawn in the plot using abline(a=2, b=1).
   - This script provides a simple introduction to basic vector manipulation, applying linear functions, and customizing plots in R. It is a useful starting point for learners who want to understand indexing in vectors and visualizing data through basic linear model

**HO10.R**: This script demonstrates how to calculate and visualize variance and covariance in R. The script also explores the relationship between two variables and shows how their covariance changes depending on the strength of their association.
   - Variance Calculation:
    The script generates three sets of random data using rnorm(), each with different standard deviations (sqrt(1), sqrt(10), and sqrt(100)).
    The variance of each dataset is computed using the var() function.
   - Visualizing Data with Plots:
    The script plots the generated data using the plot() function. For each dataset (y1, y2, and y3), points are plotted, and horizontal and vertical reference lines (abline()) are added.
       The data points are visualized with color-coded points (col="red", col="blue", col="green"), and gridlines are added for clarity.
   - Polygons for Variance: The script uses the polygon() function to illustrate the spread of data points for each dataset. These polygons show how the deviations from the mean vary across the data.
    The polygons are drawn for each data point to visually emphasize the deviations from the mean.
   - Covariance Calculation:
    The script calculates covariance between two variables x and y1 using the cov() function.
    It plots these variables (x and y1) and includes the covariance value in the plot title using the main=paste() function.
    The script also explores how the covariance changes for different relationships:
    A positive relationship (y1 = x * 1 + rnorm(21, 0, sqrt(1))).
    A random relationship (y2 = rnorm(21, mean=0, sd=sqrt(1))).
      A negative relationship (y3 = x * (-1) + rnorm(21, 0, sqrt(1))).
   - Plotting with Covariance:
    Three plots are generated to visualize the covariance between x and y1, x and y2, and x and y3.
       The covariance values are displayed on each plot's title, illustrating how the relationship between variables affects the covariance.
This script demonstrates the concepts of variance and covariance, showing how they can be calculated and visualized in R. By visualizing the data and computing the covariance between variables with different relationships, the script provides insight into how the strength and direction of the association between variables influence these statistics.

**HO11.R**: This R script demonstrates how to explore a dataset (daphnia.txt) and fit a model using multiple variables to explain the response variable (Growth.rate). The script covers the following steps:
   - Data exploration and summary statistics.
   - Visualization of the data using boxplots and histograms.
   - Checking assumptions such as homogeneity of variance and normality.
   - Calculating means and standard errors for different groups.
   - Fitting a linear regression model to assess the impact of multiple explanatory variables (Detergent and Daphnia) on the response variable.
   - Output:
    A) Boxplots: Visualize the distribution of growth rates for different detergent types and Daphnia clones.
       B) Variance: Check for homogeneity of variance across groups.
    C) Histogram: Assess the normality of the Growth.rate data.
       D) Bar Plots: Display means and standard errors for Growth.rate by Detergent and Daphnia.
    E) Linear Model: Summarizes the effects of Detergent and Daphnia on Growth.rate.

**HO12.R**: This script demonstrates how to explore, build, fit, interpret, and validate Poisson regression models for fisheries data. The focus is on modeling the relationship between total fish abundance (TotAbund) and explanatory variables such as the mean depth of the water column (MeanDepth) and time periods (Period).
- Data Exploration: Load dataset on fish abundance, which includes information on the density (Dens), mean depth (MeanDepth), and total abundance (TotAbund) of fish across different sites and time periods (from 1977 to 2002).The dataset is examined using the str() function to understand the structure, and exploratory visualizations are created to observe the relationship between MeanDepth and TotAbund.
   - Model Building and Fitting: A basic Poisson regression model is built using the formula TotAbund ~ MeanDepth, where TotAbund is the response variable, and MeanDepth is the explanatory variable. The glm() function is used to fit the model with the Poisson family, and the summary of the model is examined to interpret the coefficients and understand how MeanDepth affects the total abundance of fish.
   - Model Diagnostics: A series of diagnostic plots is created using the plot() function to check for model assumptions such as linearity, residuals, and outliers. The script computes Cook's distance to identify potential outliers, with a threshold of Cook’s distance greater than 1. The script examines overdispersion by comparing the model's deviance to the degrees of freedom.
   - Model Refitting and Validation: Based on the model diagnostics, the script refits the model by incorporating the interaction between MeanDepth and Period using the formula TotAbund ~ MeanDepth * Period. The model is re-evaluated using the summary() and anova() functions, and the impact of time periods on fish abundance is assessed.
   - Visualizations: 
       Scatter plots and boxplots are created to visualize the relationships between MeanDepth, TotAbund, and Period.
       Scatterplot: Shows the relationship between MeanDepth and TotAbund, colored by Period.
       Boxplot: Displays the distribution of TotAbund for each time period (Period).
This script demonstrates how to build a Poisson regression model in R to analyze fish abundance data. It includes key steps in model fitting, validation, and interpretation, as well as visualizations to help explore the data and assess model assumptions. By incorporating interactions between explanatory variables, the script provides a more accurate understanding of how factors like MeanDepth and Period influence total fish abundance.

        
## Author
   Anna Cavalieri Canosa
    	ac524@ic.ac.uk

