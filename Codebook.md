# Project Codebook

## Project output

This project will generate two major data frames and one text file.

### Data frames:

**1. findat**

This data frame is the result of data cleaning. By merging 'test' and 'train' data, renaming variables and assigning value labels, this data frame will contain variables below:

- Subject (Variable 1): the subject number of original data.
- Activity (Variable 2): the activity name of original data.
- Features (Variable 3-20): the format of these 18 variables are "Time/Freq_(FeatureName)\_Mean/Std"
    - Time/Freq: indicates the variable is about time or frequency
    - Feature Names: BodyAccMag, GravityAccMag, BodyAccJerkMag, BodyGyroMag, BodyGyroJerkMag
    - Mean/Std: indicates the variable is mean or standard deviation

**2. grdat**

This data frame is the result of mean calculation within groups based on 'findat'. In 'grdat', data is grouped by subject and activity, and the mean of each variable in 'findat' is calculated by groups.

### Text file:

The text file, "meandata.txt", is the txt version of data frame 'grdat'.
