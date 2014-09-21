Coursera: Getting and Cleaning Data Project
============================================

Intro
-----
This repo contains the files that were written to complete the course project for the course "Getting and Cleaning Data".

Original Data
-------------
"x_test.txt": Contains the measurements of all features for the test set.
"y_test.txt": Contains the activity for the test set.
"subject_test.txt": Contains the subjects for the test set.

"x_training": Contains the measurements of all features for the training set.
"y_training.txt": Contains the activity for the training set.
"subject_training.txt": Contains the subject for the training set.

"activity_labels.txt": Contains the labes for the activity id.
"features.txt": Contains the labels of the features

run_analysis.R
--------------
This script solve the following:

- Merges the training and the test sets to create one data set.
- Extracts only the measurements on the mean and standard deviation for each measurement. 
- Uses descriptive activity names to name the activities in the data set
- Appropriately labels the data set with descriptive variable names. 
- From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Note that the folder "UCI HAR Dataset" must be stored in the same folder that "run_analysis.R"

This script merges the test and training datasets and filter the dataset, selecting only the columns that represent features with mean() and std().
The output of the script is other tidy dataset that contains the means of all the columns grouped by activity and subject. This output is written to a text file.

Code Book
---------
This file contains the transformations applied to the original data.