---
title: "Getting and Cleaning Data Course Project"
author: "Andrea Mazzanti"
date: "December 21, 2015"
---

## Data source

The dataset is derived from [1], downloaded from [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)


## The data
	
The dataset includes the following files:
	
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

Training and the test files were merged to create two datasets
_____________________________________________________________

- subject_train.txt, Y_train.txt and X_train.txt were merged in the data_train dataset
- subject_test.txt, Y_test.txt and X_test.txt were merged in the data_test dataset

These two datasets were merged in a unique dataset called dataset.

The features.txt file provided the names for the columns of the variables of dataset.
From the column names, variables with the expressions mean() and std() were extracted.
Then, names from activity_labels.txt were used to replace the numerical values for the variable Activity.

New variables names were defined using descriptive variable names.
Finally, a new dataset were extracted by taking the average for each measurament grouped by subject and activity.

Variable names (columns):
_________________________

- Subject: 
.. range of values [1:30]
.. each value corresponds to a different person
- Activity Name:
.. Name of activity performed
.. one of: WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING

The rest of the columns corespond to averages of the variables describing mean and standard deviation measurements. 


```r
names(data)[3:ncol(data)]
```

```
##  [1] "TimeBodyAccelerometer-mean()-X"                
##  [2] "TimeBodyAccelerometer-mean()-Y"                
##  [3] "TimeBodyAccelerometer-mean()-Z"                
##  [4] "TimeBodyAccelerometer-std()-X"                 
##  [5] "TimeBodyAccelerometer-std()-Y"                 
##  [6] "TimeBodyAccelerometer-std()-Z"                 
##  [7] "TimeGravityAccelerometer-mean()-X"             
##  [8] "TimeGravityAccelerometer-mean()-Y"             
##  [9] "TimeGravityAccelerometer-mean()-Z"             
## [10] "TimeGravityAccelerometer-std()-X"              
## [11] "TimeGravityAccelerometer-std()-Y"              
## [12] "TimeGravityAccelerometer-std()-Z"              
## [13] "TimeBodyAccelerometerJerk-mean()-X"            
## [14] "TimeBodyAccelerometerJerk-mean()-Y"            
## [15] "TimeBodyAccelerometerJerk-mean()-Z"            
## [16] "TimeBodyAccelerometerJerk-std()-X"             
## [17] "TimeBodyAccelerometerJerk-std()-Y"             
## [18] "TimeBodyAccelerometerJerk-std()-Z"             
## [19] "TimeBodyGyroscope-mean()-X"                    
## [20] "TimeBodyGyroscope-mean()-Y"                    
## [21] "TimeBodyGyroscope-mean()-Z"                    
## [22] "TimeBodyGyroscope-std()-X"                     
## [23] "TimeBodyGyroscope-std()-Y"                     
## [24] "TimeBodyGyroscope-std()-Z"                     
## [25] "TimeBodyGyroscopeJerk-mean()-X"                
## [26] "TimeBodyGyroscopeJerk-mean()-Y"                
## [27] "TimeBodyGyroscopeJerk-mean()-Z"                
## [28] "TimeBodyGyroscopeJerk-std()-X"                 
## [29] "TimeBodyGyroscopeJerk-std()-Y"                 
## [30] "TimeBodyGyroscopeJerk-std()-Z"                 
## [31] "TimeBodyAccelerometerMagnitude-mean()"         
## [32] "TimeBodyAccelerometerMagnitude-std()"          
## [33] "TimeGravityAccelerometerMagnitude-mean()"      
## [34] "TimeGravityAccelerometerMagnitude-std()"       
## [35] "TimeBodyAccelerometerJerkMagnitude-mean()"     
## [36] "TimeBodyAccelerometerJerkMagnitude-std()"      
## [37] "TimeBodyGyroscopeMagnitude-mean()"             
## [38] "TimeBodyGyroscopeMagnitude-std()"              
## [39] "TimeBodyGyroscopeJerkMagnitude-mean()"         
## [40] "TimeBodyGyroscopeJerkMagnitude-std()"          
## [41] "FrequencyBodyAccelerometer-mean()-X"           
## [42] "FrequencyBodyAccelerometer-mean()-Y"           
## [43] "FrequencyBodyAccelerometer-mean()-Z"           
## [44] "FrequencyBodyAccelerometer-std()-X"            
## [45] "FrequencyBodyAccelerometer-std()-Y"            
## [46] "FrequencyBodyAccelerometer-std()-Z"            
## [47] "FrequencyBodyAccelerometerJerk-mean()-X"       
## [48] "FrequencyBodyAccelerometerJerk-mean()-Y"       
## [49] "FrequencyBodyAccelerometerJerk-mean()-Z"       
## [50] "FrequencyBodyAccelerometerJerk-std()-X"        
## [51] "FrequencyBodyAccelerometerJerk-std()-Y"        
## [52] "FrequencyBodyAccelerometerJerk-std()-Z"        
## [53] "FrequencyBodyGyroscope-mean()-X"               
## [54] "FrequencyBodyGyroscope-mean()-Y"               
## [55] "FrequencyBodyGyroscope-mean()-Z"               
## [56] "FrequencyBodyGyroscope-std()-X"                
## [57] "FrequencyBodyGyroscope-std()-Y"                
## [58] "FrequencyBodyGyroscope-std()-Z"                
## [59] "FrequencyBodyAccelerometerMagnitude-mean()"    
## [60] "FrequencyBodyAccelerometerMagnitude-std()"     
## [61] "FrequencyBodyAccelerometerJerkMagnitude-mean()"
## [62] "FrequencyBodyAccelerometerJerkMagnitude-std()" 
## [63] "FrequencyBodyGyroscopeMagnitude-mean()"        
## [64] "FrequencyBodyGyroscopeMagnitude-std()"         
## [65] "FrequencyBodyGyroscopeJerkMagnitude-mean()"    
## [66] "FrequencyBodyGyroscopeJerkMagnitude-std()"
```

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012




