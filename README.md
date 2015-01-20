GettingAndCleaningDataProject
=============================

This repository contins code written for the course project of the and Cleaning Data Coursera course.

## Using the script

* Unzip the data file ([found here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)) into the same directory as the run_analysis.R source file.
* In R, set the working directory to that of the source file using the ```setwd()``` command.
* Run ```source("run_analysis.R")``` to generate the averages data, which will be outputted in a file called "averages_data.txt".

## How it works

* The script run_analysis.R reads all text files using ```read.table()``` before training and test sets are combined using ```rbind()```.
* ```grep()``` is used to find only the variables that relate to means and standard deviations nd the variable names are tidied with the ```gsub()``` and ```tolower()``` functions.
* The S, Y and X variable groups are combined using ```cbind()``` to create a large but tidy datas.
* To calculate and output the average of each variable for each activity, nested for loops are used to populate a new data frame before writing that summary data frame to a file named "averages_data.txt".