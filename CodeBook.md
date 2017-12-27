# Getting and Cleaning Data Course Project - Codebook file 

This codebook describes raw data and how it was transformed to arrive at final data.

## Data obtained from the raw X_train.txt and X_test.txt files 

The description of the raw data from these files was provided with the data in the features_info.txt file. This contents of this file is provided below as
an appendix. The original X_train and X_test have cryptic column names V1 - V561. The file features.txt is a cross reference table between these names and the more descriptive
names implied by the appendix. The data from these files were manipulated as follows: 
* The "mean" and "std" variables were combined into the data frame X_total 
* The X_total columns were renamed using the labels in the features.txt file.
* This data was merged into the full data set, fullset, along with the Subject and Activity tables. 
* The means of these variables were summarized by Subject and Activity, with the means retaining the same names as the variables. 
* The names of these variables were cleaned up in order to:
	- Fix an apparent typo where the word Body was repeated twice ("BodyBody" changed to "Body")
	- Replace the domain indicators f and t with freq- and time- in order to be more descriptive 
	- Remove empty parentheses for a cleaner look
	- Add dashes between the parts of the name where one did not exist
	- Rearrange so that mean or std is at end of name
	- Replace X, Y, and Z with dimX, dimY, and dimZ to indicate dimension and make more descriptive
	- Put mean() around mean or std to show this is a mean of those measures from the original data
	- Replace the dashes with underscores. If you leave the dashes they get changed to periods when the output file is read back in.

The result of the name manipulation is to have names with 5 parts:
* The domain (time,freq),
* Signal type (Body, Gravity),
* Signal source or associated Jerk (Acc, Gyro, AccJerk, GyroJerk),
* Dimension or Magnitude measure (dimX, dimY, dimZ, Mag)
* Measure used (mean(mean), mean(std))

For example "freq_Body_Acc_dimY_mean(mean)" indicates the mean of the mean body acceleration signal along the Y dimension in the frequency domain.
These features make up columns 3-68 in the tidyset tibble. Additional discussion of these features can be found in the appendix. 

## Data obtained from the Y_train.txt and Y_test.txt files. 
These files only have one column which is an integer from 1-6 representing an activity. The file activity_labels.txt is cross reference table between the integer and the
activity name. The following was done with these files:
* Y_train and Y_test were combined into Y_total.
* Y_total was merged with activity_labels to get a column of activity names instead of integers. This was done by merging and only retaining the column with the activity names.
* The column was renamed "Activity".
* This data was merged into the full data set, fullset, along with the Subject and X_total tables. 

## Data obtained from the subject_train.txt and subject_test.txt files.
These files only have one column with a number that indicates the test subject. The following was done with these files:
* They were combined to create subject_total
* The column was renamed to "Subject".
* This data was merged into the full data set, fullset, along with the X_total and Y_total tables. 

## Appendix: Original features_info.txt file that came with the data.


Feature Selection 


The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 

mean(): Mean value
std(): Standard deviation
mad(): Median absolute deviation 
max(): Largest value in array
min(): Smallest value in array
sma(): Signal magnitude area
energy(): Energy measure. Sum of the squares divided by the number of values. 
iqr(): Interquartile range 
entropy(): Signal entropy
arCoeff(): Autorregresion coefficients with Burg order equal to 4
correlation(): correlation coefficient between two signals
maxInds(): index of the frequency component with largest magnitude
meanFreq(): Weighted average of the frequency components to obtain a mean frequency
skewness(): skewness of the frequency domain signal 
kurtosis(): kurtosis of the frequency domain signal 
bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
angle(): Angle between to vectors.

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

gravityMean
tBodyAccMean
tBodyAccJerkMean
tBodyGyroMean
tBodyGyroJerkMean

The complete list of variables of each feature vector is available in 'features.txt'
