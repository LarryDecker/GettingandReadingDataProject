#Set the working directory to where the UCI HAR Dataset folder is
setwd("c:/coursera/readingdata/Course Project/UCI HAR Dataset/")

#load the dplyr package
library("dplyr")

# read in the necessary data sets
activity_labels<-read.table("activity_labels.txt")
features<-read.table("features.txt")
subject_train<-read.table("./train/subject_train.txt")
X_train<-read.table("./train/X_train.txt")
Y_train<-read.table("./train/Y_train.txt")
subject_test<-read.table("./test/subject_test.txt")
X_test<-read.table("./test/X_test.txt")
Y_test<-read.table("./test/Y_test.txt")

#Two steps in one. 1) Combine X_train and X_test into X_total. 2) Only pull mean and std features.
X_total<-rbind(X_train[,grep("mean\\(\\)|std\\(\\)",features$V2)],X_test[,grep("mean\\(\\)|std\\(\\)",features$V2)])

#Combine Y_train and Y_test into Y_total
Y_total<-rbind(Y_train,Y_test)

#Combine subject_train and subject_test into subject_total
subject_total<-rbind(subject_train,subject_test)

#Merge Y_total with the activity labels and only keep the 2nd column with the labels.
Y_total<-as.data.frame(merge(Y_total,activity_labels,by="V1")[,2])

#replace the cryptic V? feature names with the ones in the features data frame.
names(X_total)<-features$V2[grep("mean\\(\\)|std\\(\\)",features$V2)]
#Give the Y_total column a descriptive name
names(Y_total)<-"Activity"
#Give the Subject column a descriptive name
names(subject_total)<-"Subject"

#combine the sets together into a tibble
fullset<-as_tibble(cbind(subject_total,Y_total,X_total))

#create the tidyset for the project by obtaining the mean of the numeric variables by Subject and Activity
tidyset<-summarise_at(group_by(fullset,Subject,Activity),names(fullset)[3:68],mean)

#Beginning of cleaning up the names

#Looks like BodyBody was just a typo so replacing with Body
names(tidyset)<-gsub("BodyBody","Body",names(tidyset))

#f and t replaced by freq- and time- so not so cryptic
names(tidyset)<-gsub("^f","freq-",names(tidyset))
names(tidyset)<-gsub("^t","time-",names(tidyset))
#getting rid of parentheses so looks cleaner
names(tidyset)<-gsub("\\(\\)","",names(tidyset))
#delineating with a dash
names(tidyset)<-gsub("Body","Body-",names(tidyset))
names(tidyset)<-gsub("Gravity","Gravity-",names(tidyset))
names(tidyset)<-gsub("Mag","-Mag",names(tidyset))
#rearranging so that mean or std is at end of name. 
#Also replacing X, Y, and Z with dimX, dimY, and dimZ to indicate dimension and make less cryptic.
names(tidyset)<-gsub("-mean-X","-dimX-mean",names(tidyset))
names(tidyset)<-gsub("-mean-Y","-dimY-mean",names(tidyset))
names(tidyset)<-gsub("-mean-Z","-dimZ-mean",names(tidyset))
names(tidyset)<-gsub("-std-X","-dimX-std",names(tidyset))
names(tidyset)<-gsub("-std-Y","-dimY-std",names(tidyset))
names(tidyset)<-gsub("-std-Z","-dimZ-std",names(tidyset))
#Put mean() around mean or std to show this is a mean of those measures from the original data.
names(tidyset)<-gsub("mean","mean\\(mean\\)",names(tidyset))
names(tidyset)<-gsub("std","mean\\(std\\)",names(tidyset))
#Replace the dashes with underscores. 
names(tidyset)<-gsub("-","_",names(tidyset))
#End of cleaning up the names
#Now each name has 5 parts:
#the domain (time,freq),
#signal type (Body, Gravity),
#signal source or associated Jerk (Acc, Gyro, AccJerk, GyroJerk),
#Dimension or Magnitude measure (dimX, dimY, dimZ, Mag)
#measure used (mean(mean), mean(std))

#inspect the names to make sure they are what is desired
names(tidyset)
#take a look at the tidy data set to verify it looks ok
View(tidyset)

#write the table out
write.table(tidyset,file="tidyset.txt",row.names = FALSE)
#read the table in 
tidysetread<-read.table(file="tidyset.txt",header=TRUE)

#verify what was written in matches what was written out.
#Check that numbers match. Should be 0.
max(round(as.data.frame(tidyset[3:68])-tidysetread[3:68],10))
min(round(as.data.frame(tidyset[3:68])-tidysetread[3:68],10))
#check that factors match. Should be 0.
max(as.data.frame(tidyset[1:2])!=tidysetread[1:2])

