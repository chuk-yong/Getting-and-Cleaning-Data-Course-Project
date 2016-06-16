# CodeBook

This code book describes the variables, the data, and transformations in producing tidy data in the output file: tidy_data.txt

##The data source

Original data: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
Original description of the dataset: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
Data Set Information

##Description of the data source

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

##Before running the script

Download, unzip the data and put them in your R working directory.

They should be in a folder: /UCI HAR Dataset

These are the files we will be using:
'features.txt': List of all the name of the measurements

'activity_labels.txt': What each number corresponds to - walking, running..etc

2 additional folder: train and test.  each contains the subjects, activities and data collected.

##To analyse the data, we need to perform the following:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean (mean) and standard deviation (std) for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive activity names.
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

##How run_analysis.R implements the above steps:

1. For train and test -- read in the relevent data 
2. Merge all the data into merge_all
3. Put in the corresponding names in the column: subject, activity and the rest of the names in features.txt
4. Substitute the numeric value in activity column with the right label from activity_labels,txt
5. Grab all the means and std columns to form a data as required.  They are contained in data_mean_std
6. Make the columns more meanning full by replacing t with time, f with frequency..etc and also removing "()" and changing "-" to "_"
7. Get the average of each columns with measurement and sort by subject and activity.  Done by using dplyr.
8. Tidy up the columns further by adding "Average" prefix to the columns with measurement.
9. Finally save it as a file: tidy_data.txt
