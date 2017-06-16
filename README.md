# Getting-CleaningData
## Course Project
The course project for the Getting and Cleaning Data course. The R script, run_analysis.R, performs the following:

  Downloads the dataset if it does not already exist in the working directory
  Loads the activity and feature data
  Loads both the training and test datasets, keeping only those columns which reflect a mean or standard deviation
  Loads the activity and subject data for each dataset, and merges those columns with the dataset
  Merges the two datasets
  Creates a tidy dataset of the mean values of each variable for each subject and activity pair.
  
The final product is shown in the file tidy.txt.
