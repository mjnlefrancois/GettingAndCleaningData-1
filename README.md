# GettingAndCleaningData Readme

## Step 0: running the script and downloading the data set

The script uses R 3.2.x with data.table and dplyr packages.
R-Studio is not required.

Start the script by running this command in R:

* source('run_analysis.R')

If the directory 'UCI HAR Dataset' is not found,
the [zip file](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) will be downloaded and unzipped.

## Step 1: merging training and test sets

This step is fairly simple:

* Using the 'cbind' function, the 'X_test.txt' (containing the measurements) will be extended with columns from the 'subject_test.txt' and the 'y_test.txt'. The columns will be named 'subject' and 'activities'.
* The same approach is used for extending the 'X_train.txt' with 'subject_train.txt' and 'y_train.txt'.
* Using the 'rbind' function, the rows of those two datasets will be combined into one big dataset 'data'. 

Note that the columns of the measurements are labeled V1, V2...

Also note that the 'activities' are still short labels, not descriptive names. These labels will be replaced in step 3.

## Step 2: extracting mean and standard deviation measurements

We're only interested in measurements about mean and deviation (std).
As mentioned above, the column names are labeled V1, V2... so:

* Read the 'features.txt' file. This file contains the short label and the corresponding, descriptive column name.
* Grep the features for column names containing 'std' or 'mean', and put the short label in the 'keep' list.
* In the 'data', remove all columns except the 'activity', 'subject' and the columns in the 'keep' list.
* Put the result in a data set 'tidy'.

## Step 3: label data set with descriptive activity names

* Read the 'activity_labels.txt'. This file contains the short label (in column V1) used in the 'tidy' data set, and the corresponding, descriptive names (in V2) for the activities.
* Using the 'setnames' function, rename the V2 column to 'activity_name'.
* Using the 'merge' function, join the activities with the 'tidy' data set.
* Remove the 'activity' column containing the short label, and keep the 'activity_name' column containing the descriptive names.

## Step 4: label data set with descriptive feature names

* Using the 'keep' list in step 2, look up the descriptive names for the features columns in the 'tidy' set (instead of the short label 'V1'...)
* Rename the columns using the 'setnames' function.
* In addition, use the 'sub' function to replace columns names starting with 't' by 'Time' and column names starting with 'f' by 'Frequency'.

## Step 5: create data set with average for each activity and subject

* Using the 'aggregate' function, calculate the mean for every measurement, aggregated by activity and subject. This is the end result.
* Write the result to a file called 'tidy.txt'.

