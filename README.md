# GettingAndCleaningData Readme

## Step 0: running the script and downloading the data set

The script uses R 3.2.x with data.tables and dplyr packages.
R-Studio is not required.

Start the script by running this command in R:

* source('run_analysis.R')

If the directory 'UCI HAR Dataset' is not found,
the [zip file](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) will be downloaded and unzipped.

## Step 1: merging training and test sets

This step is fairly simple:

* Using the 'cbind' function, the 'X_test.txt' (containing the measurements) will be extended with columns from the 'subject_test.txt' (subjects) and the 'y_test.txt' (activities)
* The same approach is used for extending the 'X_train.txt' with 'subject_train.txt' and 'y_train.txt'.
* Using the 'rbind' function, the rows of those two datasets will be combined into one big dataset 'data'. 

Note that the column names of the measurements are labeled V1, V2...

## Step 2: extracting mean and standard deviation measurements

We're only interested in measurements about mean and deviation (std).
As mentioned above, the column names are labeled V1, V2... so:

* Read the 'features.txt' file. This file contains the corresponding column names
* Grep for column names containing 'std' or 'mean', and put those in a 'keep' list.
* In the big 'data' set, remove all columns except the 'activity', 'subject' and the columns in the 'keep' list.

## Step 3: label data set with descriptive activity names

## Step 4: label data set with descriptive feature names

## Step 5: create data set with average for each activity and subject
