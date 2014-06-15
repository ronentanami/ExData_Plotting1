==================================================================
run_analysis.R
Analysis as part of course project based on "Human Activity Recognition Using Smartphones Dataset"
==================================================================
The aim of this program is to take the results of the Human Activity Recognition experiment and simplify the data.

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. 
Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing 
a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, the experiment captured 3-axial linear 
acceleration and 3-axial angular velocity at a constant rate of 50Hz.

Program steps:
======================================
1. Read the Training  and Test data. Each record contains 561 - features !!!
2. Read the subject ID file - This file contains the person ID for each record in above results (there are 30 persons in the experiment)
3. Read the Activity ID file - This file contains the Activity ID for each record in above results (There are 6 activities in the experiment)
4. Read the Activity reference table to link the activity ID to activity Name
5. Read the feature name list - This table describe the names of all the 561 features

6. Merge the Training and the Test data into one Data Frame. This DF has 10,299 rows and 561 columns
7. Enrich the combined DF with the Subject ID
8. Enrich the Combined DF with the Activity ID
9. Enrich the combined DF with the Activity Name

10. We would like to reduce the 561 features to only the ones include "mean()" and "std()". For this we created a new tidy DF called "Tidy_DF".
Note, there are other features including the name "mean" (e.g. "angle (Z,gravityMean)") that I decided to ignore. I am taking only
the features that are ended either by "mean()" or "std()"

11. Saving "Tidy_DF" Data Frame in file "Tidy_data.CSV"

12. Calculating the average of all features in the tidy DF per Subject ID and Activity Name

13. Saving the results (Average) in a new file


The output includes the following files:
=========================================

- 'README.txt' / 'README.md'

- 'New_feature_list.txt': Cook book shows information about the variables used on the new feature vector.

- 'Tidy_data.csv': file containing the data of the tidy DF (Subject Id, Activity Id, Activity Name, Features inclding mean() and std() )

- 'Tidy_average.txt': file containing the calculated average for all features in the tidy DF per Subject ID and Activity Name

- 'Tidy_average.CSV': Same as above with CSV format

- 'Read_tidy_avarate.R': Script to read "Tidy_average.txt" file into Data Frame

Note:
=========================================
- Since 'Tidy_data.csv' file is too big I loaded the ZIP format of it
- All data files are extracted with headers