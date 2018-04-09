crime = crime_rate[c(1:20),c(1:20)]
crime[8,1]=2001
crime[19,1]=2012

crime[,3]=as.numeric(crime[,3])
colnames(crime)

crime[, 3] <- sapply(crime[, 3], as.numeric)
is.numeric(crime[,3])

cbind(crime, crime[,3]/crime[,2])
summary(crime)







