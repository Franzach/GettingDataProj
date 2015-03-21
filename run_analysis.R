# The following R script called run_analysis.R that does the following. 
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each 
#    measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. From the data set in step 4, creates a second, independent tidy data set with 
#    the average of each variable for each activity and each subject.

library(dplyr)
library(tidyr)
library(reshape2)

# Read in the relevant data files, should be located in working directory
testdat <- read.table("X_test.txt", header = F, stringsAsFactors = FALSE)
traindat <- read.table("X_train.txt", header = F, stringsAsFactors = FALSE)
acttraindat <- read.table("y_train.txt", header = F, stringsAsFactors = FALSE)
acttestdat <- read.table("y_test.txt", header = F, stringsAsFactors = FALSE)
subjtrndat <- read.table("subject_train.txt", header = F, stringsAsFactors = FALSE)
subjtstdat <- read.table("subject_test.txt", header = F, stringsAsFactors = FALSE)
features <- read.table("features.txt", header = F, stringsAsFactors = FALSE)
actlabel <- read.table("activity_labels.txt", header = F, stringsAsFactors = FALSE)

# Convert to tbl df 
sel <- c(grep("mean()", variables), grep("std()", variables))
test <- tbl_df(testdat) %>% select(sel)
train <- tbl_df(traindat) %>% select(sel)

# Select the columns for mean & standard deviation and rename the columns
colnames(test) <- features[, 2][sel]
colnames(train) <- features[, 2][sel]

# Differentiate train and test data plus append rest of variables
# Train = Experiment type 1, Test = Experiment type 2
# Activity type and subject number from source files 
train <- mutate(train, experiment_type = 1, activity = acttraindat[[1]], 
                subject = subjtrndat[[1]])
test <- mutate(test, experiment_type = 2, activity = acttestdat[[1]], 
               subject = subjtstdat[[1]])

# Merge train and test data
data <- bind_rows(train, test)
data$activity <- factor(data$activity, levels = actlabel[, 1], labels = actlabel[, 2])
data$experiment_type <- factor(data$experiment_type, levels = c(1,2), 
     labels = c("train", "test"))

grpdata <- group_by(data, activity, subject)
means <- aggregate(. ~ activity + subject, data = grpdata, mean)

#means <- dcast(grpdata, subject ~ activity, mean)
write.table(means, "wearables_data_summary.txt", row.name=FALSE)
