# GettingandCleaningDataCourseProject

In order to obtain a tidy, readable and informative dataset from raw data, I first parsed some files with read.table() in R:

X_test.txt and X_train.txt are the actual datasets.

y_test.txt and y_train.txt contain informations about activity performed, for each row in the datasets.

subject_test.txt and subject_train.txt contain  informations about the subject who performed the activity, for each row in the datasets.

features.txt provides column labels.

activity_labels.txt provides the caption needed to interpret y_test.txt and y_train.txt.

Then, using dplyr package, I worked on the 2 datasets separately, selecting only mean and standard deviation features for each of the signals and adding some extra columns containing informations about activity, subject, and "group" ("test"" or "train).

I also gave a descriptive name to the columns (with the help of features.txt) as well as to the activity levels.

Subsequently, I merged the 2 datasets binding them by rows and I created an extra column with a unique id for each measurement. So, a tidy_dataset.txt was generated and saved.

Finally, I grouped the tidy dataset by activity and subject id, and calculated the mean for each of the measurement values using the summarize_all() function. I renamed the involved columns according to this last operation, and I eventually saved a SummarizedDataset.txt file.



