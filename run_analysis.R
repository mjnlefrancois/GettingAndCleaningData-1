library(data.table)
library(dplyr)

subdir = 'UCI HAR Dataset'
 
# convenience function for reading train / test file
read.uci <- function(type, fname) {
	f = paste('.', subdir, type, fname, sep='/')
	read.table(f)
}


# download and unzip the dataset
if (!(file.exists(subdir))) {
	url = 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
	f = 'dataset.zip'
	download.file(url, f, method='curl')
	unzip(f)
	unlink(f)
}

# merge training and test sets

train.subj = read.uci('train', 'subject_train.txt')
train.x = read.uci('train', 'X_train.txt')
train.y = read.uci('train', 'y_train.txt')

test.subj = read.uci('test',' subject_train.txt')
test.x = read.uci('test', 'X_train.txt')
test.y = read.uci('test', 'y_train.txt')


