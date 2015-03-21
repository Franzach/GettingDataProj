# GettingDataProj
Getting and cleaning data course project

The data analysis was carried out using data collected from the experiment conducted at the University of Genoa title "Human Activity Recognition Using Smartphones Dataset"

The objective of the analysis was to collect the relevant data, and after cleaning it up then performing analysis on the tidy data to produce summary statistics for the mean and standard deviations of the measured variables. The results of the analysis are grouped by subject and activity performed, and the means calculated for each.

### The following pre-analysis steps were performed
The data for the analysis was collected fromt the following source
  https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
The downloaded zip file was then extracted and the files placed in the R working              
     directory

### The R script called run_analysis.R that does the following. 
 1. Merges the training and the test sets to create one data set.
 2. Extracts only the measurements on the mean and standard deviation for each 
    measurement. 
 3. Uses descriptive activity names to name the activities in the data set
 4. Appropriately labels the data set with descriptive variable names. 
 5. From the data set in step 4, creates a second, independent tidy data set with 
    the average of each variable for each activity and each subject
 6. The resulting data table is then saved to the following file in the R working directory "wearables_data_summary.txt"