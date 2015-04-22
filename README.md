# getting-and-cleaning-data
For the Getting and Cleaning Data class
The run_analysis.R downloads the data, and cleans it with basic orders and the help of "dplyr" and "tidyr" packages. 
##1.Merges the training and the test sets to create one data set. The potential problem is, after the title being added to the data, the function "merge" doesn't work well.  
##2.Extracts only the measurements on the mean and standard deviation for each measurement. Different columns contain different signals, including "mean" and "std". The measurements of mean and standard deviation don't need to be calculated.  
##3.Uses descriptive activity names to name the activities in the data set. There are just six activities, so I just type it. 
##4.Appropriately labels the data set with descriptive variable names.  This is down before, or the names of the column can be renamed by "colnames" function.
##5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject. The combination of "lapply", "gather" function can help to get the average of each activity and each subject. This requirement is rather flexible, I prefer to calculate the average of each person and each signal.

