# set your working directory

## read in files from test and train folder, each containing subject, activity and their data.  also features
# that descrips the data

test_subject <- read.table("./UCI HAR Dataset/test/subject_test.txt")
test_activity <- read.table("./UCI HAR Dataset/test/y_test.txt")
test_data <- read.table("./UCI HAR Dataset/test/X_test.txt")
train_subject <- read.table("./UCI HAR Dataset/train/subject_train.txt")
train_activity <- read.table("./UCI HAR Dataset/train/y_train.txt")
train_data <- read.table("./UCI HAR Dataset/train/X_train.txt")
features <- read.table("./UCI HAR Dataset/features.txt")

# put the columns together for the test and train dataset.  Then merge them all
merge_test <- cbind(test_subject, test_activity, test_data)
merge_train <- cbind(train_subject, train_activity, train_data)
merge_all <- rbind(merge_train, merge_test)

# read in the column names and place it into the merged data frame
col_names <- c("subject", "activity", as.character(features[,2]))
names(merge_all) <- col_names

# create a data set with just the means and stds
data_mean_std <- merge_all[,c(1,2,grep("mean\\(\\)|std\\(\\)", names(merge_all)))]

# put in labels to descripe the activities instead of 1,2,3,4,5
activity_label <- read.table("./UCI HAR Dataset/activity_labels.txt")
data_mean_std$activity <- as.character(activity_label[match(data_mean_std$activity, activity_label$V1), "V2"])

# make the column names more meaningful, remove () and change "-" to "_"
names(data_mean_std)<-gsub("^t", "time", names(data_mean_std))
names(data_mean_std)<-gsub("^f", "frequency", names(data_mean_std))
names(data_mean_std)<-gsub("Acc", "Accelerometer", names(data_mean_std))
names(data_mean_std)<-gsub("Gyro", "Gyroscope", names(data_mean_std))
names(data_mean_std)<-gsub("Mag", "Magnitude", names(data_mean_std))
names(data_mean_std)<-gsub("BodyBody", "Body", names(data_mean_std))
names(data_mean_std)<-gsub("\\(|\\)", "", names(data_mean_std))
names(data_mean_std)<-gsub("-", "_", names(data_mean_std))

# load dplyr.  use it to create a tidy data with average of the means and stds and group
# them by subject and activity
library(dplyr)
tidy_data <- data_mean_std %>% 
  group_by(subject,activity) %>%
  summarise_each(funs(mean))

# add Average infront of the means and stds so we know they are averages.  Then output the tidy data
names(tidy_data)[3:ncol(tidy_data)]<-paste("Average", names(tidy_data)[3:ncol(tidy_data)], sep = "_")
write.table(tidy_data, file = "tidy_data.txt")
