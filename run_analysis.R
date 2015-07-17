library('data.table')
library('dplyr')

subdir = 'UCI HAR Dataset'
 
# convenience function for reading train / test file
read.uci <- function(type, fname) {
	f <- paste('.', subdir, type, fname, sep='/')
	read.table(f)
}

# convenience function for merging sets
merge.uci <- function(type = c('test', 'train')) {
	subj <- read.uci(type, paste0('subject_', type, '.txt')) # who
	x <- read.uci(type, paste0('X_', type, '.txt')) # big table with values
	y <- read.uci(type, paste0('y_', type, '.txt')) # activity / what

	x <- mutate(x, subj=subj$V1, activity=y$V1)	
}

# download and unzip the dataset
if (!(file.exists(subdir))) {
	url <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
	f <- 'dataset.zip'
	download.file(url, f, method='curl')
	unzip(f)
	unlink(f)
}

# merge training and test sets

train <- merge.uci('train')
test <- merge.uci('test')

