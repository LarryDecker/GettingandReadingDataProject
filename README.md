# Getting and Cleaning Data Course Project - README file 

This project involves obtaining data involving smartphone measures from UC Irvine's Machine Learning repository and summarizing it into a tidy data set 
using an r script, run_analysis.R. Discussion of the data can be found at http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones. 
Also, the contents of the original README.txt file that came with the data has been provided as an appendix below. You may want to read it before proceeding
since it will be referred to. The goal of the project is to combine the train and test sets and calculate the mean of the features by subject and activity. Only features 
that are means or standard deviations are used. 

The files below are used in the following way in the script. Note that they are read into the workspace with the same names as the files. 
* files with suffixes "_train" and "_test" are read in and combined to create data sets with a "_total" suffix. For example X_train and X_test are used to create X_total.
* These "_total" sets are combined to credit the full data set that is the source of the tidy data set.
* The features.txt file has the descriptive feature names for the features in the X_train and X_test data sets. It is used in the process of creating the X_total data set
  in the filtering of the columns to those that are only means or standard deviations. It is also used to rename the X_total columns.
* The activity_labels.txt file is used in conjunction with the Y_totals data set to obtain a column of activities that are descriptive rather than just the numbers that
  came with the Y_train and Y_test sets.
* The features_info.txt file is used in the separately supplied code book.
* The files in the "Inertial Signals" folders are not used. 

## Obtain the data and run the R script 

The following steps will allow you to obtain the data and run the R script to create the tidy data set:
* Download the zipped file containing the data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
* Unzip the file and note the location of the "UCI HAR Dataset" folder. If desired copy or move this folder and its contents to a different location.
* Open the run_analysis.R script.
* In line 2 of the script, change the path in the setwd() command to reflect the location of the "UCI HAR Dataset" folder.
* Run the script. Note that you will need to have the dplyr package installed.


## Logical order of the run_analysis.R script 

The logical order of the script is as follows:
* Set the working directory and load the dplyr package.
* Read in the necessary files, giving them same name as their file name.
* Combine X_train, Xtest, Y_train, Y_test, subject_train, and subject_test into X_total, Y_total, and subject_total.
* Change Y_total data from integers to descriptive labels.
* Give the columns of X_total, Y_total, and subject_total descriptive names.
* Combine X_total, Y_total, and subject_total into the full data set, fullset, as a tibble.
* Summarize fullset by Subject and Activity to create the tidy data set "tidyset".
* Clean up the names of tidyset columns 
* Inspect the names and the tidyset data set.
* Write tidyset as a table out to a file called "tidyset.txt"
* Read the table back in to the data set tidysetread and check that it matches tidyset.

## Discussion of why the result meets the criteria for a tidy data set
### Each variable you measure should be in one column.
I had considered narrowing the data set by breaking up the feature names, putting them in rows and just having two measurement columns - one for mean and one for standard deviation.
But then it occurred to me that I would be violating this principle and the mean and std columns would be a mixture of variables. So in the end I kept all of the feature columns separate.
### Each different observation of that variable should be in a different row.
In this case the combination of Subject and Activity forms the basis for an "observation" and each row contains the variable for that observation.
### There should be one table for each "kind" of variable.
It is somewhat debatable whether or not this criteria is met. One could argue that the means and standard deviations are different kinds of variables and should have separate tables. The
assignment seems to imply the use of only one table so that is what I went with. This can be seen as okay if you loosely define "kind of variable" as observed statistics from the
smart phone study.
### If you have multiple tables, they should include a column in the table that allows them to be linked.
Only one table used so not applicable.

#Appendix - Original README.txt file that came with the data.
==================================================================
Human Activity Recognition Using Smartphones Dataset
Version 1.0
==================================================================
Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Università degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws
www.smartlab.ws
==================================================================

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

For each record it is provided:
======================================

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

The dataset includes the following files:
=========================================

- 'README.txt'

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 

- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 

- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 

Notes: 
======
- Features are normalized and bounded within [-1,1].
- Each feature vector is a row on the text file.

For more information about this dataset contact: activityrecognition@smartlab.ws

License:
========
Use of this dataset in publications must be acknowledged by referencing the following publication [1] 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.


