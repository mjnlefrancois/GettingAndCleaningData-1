library('data.table')
library('dplyr')

subdir = 'UCI HAR Dataset'
 
# convenience function for reading train / test file
read.uci <- function(type, fname) {
	f <- paste('.', subdir, type, fname, sep='/')
	read.table(f)
}

# convenience function for reading feature or activity label file
read.labels <- function(fname) {
	f <- paste('.', subdir, fname, sep='/')
	read.table(f)
}

# convenience function for merging sets
merge.uci <- function(type = c('test', 'train')) {
	subj <- read.uci(type, paste0('subject_', type, '.txt')) # who
	x <- read.uci(type, paste0('X_', type, '.txt')) # big table with values
	y <- read.uci(type, paste0('y_', type, '.txt')) # activity / what

	cbind(x, data.frame(subject=subj$V1, activity = y$V1))
}

# download and unzip the dataset
if (!(file.exists(subdir))) {
	url <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
	f <- 'dataset.zip'
	download.file(url, f, method='libcurl')
	unzip(f)
	unlink(f)
}

# merge training and test sets
data <- merge.uci('train')
data <- rbind(data, merge.uci('test'))

# read feature labels
features <- read.labels('features.txt')

# only keep the feature variables / columns we're interested in
keep <- features[grep('mean|std', features$V2),]
keep$V1 <- paste0('V', keep$V1)
tidy <- data[, c(keep$V1, 'subject', 'activity')]

# rename the feature column names (look up values in 'keep')
setnames(tidy, colnames(tidy), c(as.character(keep$V2), 'subject', 'activity'))

# read activity labels
activities <- read.labels('activity_labels.txt')
setnames(activities, 'V2', 'activity_name')

# rename the activity column names (merge with activity and drop number)
tidy <- merge(tidy, activities, by.x="activity", by.y="V1")
tidy$activity <- NULL

# aggregate by subject and activity_name
res <- aggregate(. ~ subject + activity_name, data=tidy, mean)
write.table(res, 'tidy.txt', col.names=FALSE)
