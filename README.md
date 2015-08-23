# CourseProject
the repository for Getting and Cleaning data course project

Set up:  The goal is to create an R script called run_analysis.R that does the following
  --create one R script called run_analysis.R that does the following. 
1 --Merges the training and the test sets to create one data set.
2 --Extracts only the measurements on the mean and standard deviation for each measurement. 
3 --Uses descriptive activity names to name the activities in the data set
4 --Appropriately labels the data set with descriptive variable names. 
5 --From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The Raw data is provided on the coursera website and consists of the following files

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

Description of analysis:

-first all the datasets are read in
-then the variable names were changed to "activity" and "subject" for the activity and subject id data sets, respectively
-then the values of the features data set were compiled into a list, and applied as variable names for both the training and test subject groups (objective 3)
-the training and test data sets were then bound using rbind, called "all" (objective 1)
-then the values of the features data set were separated to form 3 new variables, to allow isolation of "mean" and "std dev" measurements. this list was then
   used to subset the bound data set "all" (objective 2)
-then subject id's and activity id's were bound to "all" using cbind.
-finally, the activity id numbers were replaced with character labels of the activity, resulting in the data set "tiny_data" (objective 4)

-to produce the final smaller tiny data set that shows the mean of each variable by activity, by subject, the summarise_each command is applied (objective 5) creating "tidy_data2"

-lastly, "tidy_data2" is written to a txt file using write.table
