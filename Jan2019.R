##### 1. INTRO TO FILES #####

setwd("~/Desktop/r-novice-inflammation")
read.csv(file = "data/inflammation-01.csv")

# ?read.csv
# to get R documentation

# header is true by default, need to include if we want to change it
read.csv(file = "data/inflammation-01.csv", header = FALSE)
read.csv(file = "data/inflammation-01.csv", header = TRUE)

##### 2. INTRO TO VARIABLES, TYPES, ETC #####

weight_kg <- 55 # will show up in global environment section (top right)
#to get value of variable, just enter weight_kg in console. arrow is assignment operator
weight_lb <- weight_kg * 2.2
#the one next to the value returned is the index
# if you do weight_kg <- 60, weight_kg changes but weight_lb does not. does not dynamically update variables.
(weight_kg <- 60) #assigns the value, and R automatically prints the value
class(weight_kg) #checks variable type, returns "numeric" in this case

string_cheese <- "CHEESE, GROMET"
class(string_cheese) # returns "character"

##### 3. VARIABLES, DATA, AND TYPES #####

dat <- read.csv(file = "data/inflammation-01.csv", header = FALSE) 
#read.csv("data/inflammation-01.csv", FALSE) also works, as long as the order is correct
#if you name them, you don't need to worry about the order
head(dat)
head(dat, n = 10)
class(dat) # returns "data.frame"
# a data frame doesn't have to be all the same type of data. BUT everything in a row has to be same type
dim(dat) #gives us dimensions as rows by columns, returns 60 40
dat[1,1] #return value in row 1, column 1

#NOTE: indexing starts at 1, not at 0

dat[c(1,2,5), c(7, 8, 9)] # function c is for combine/concatenate
# look at 1st, 2nd, and 5th row, and columns 7, 8, and 9. returns that submatrix
dat[1, ] #all values in the first row. all of the columns and the first row
dat[, 1]
dat[, c(1,2)]
dat[c(1,2,3,4,5),] #first five rows
dat[1:5, ] #an easier way to do it. colon creates a vector out of the sequence
#1:5 generates all integers from 1 to 5 and returns that vector

##### 4. FUNCTIONS FOR SUMMARIZING DATA #####
patient_10 <- dat[10, ]
min(patient_10)
max(patient_10)
# mean(patient_10) --> this doesn't work
class(patient_10) #data.frame --> mean can't work with data frames. patient_10 is 1 obs of 40 variables
#fix this by forcing a type conversion. make it treat patient_10 as a vector of values
patient_10
as.numeric(patient_10) #no longer has the headers, is just a numeric vector
mean(as.numeric(patient_10))
#data frame vs matrix: data frame can have columns that are different types. matrix has to be all same type

#instead of assigning patients to each row:
apply(dat, 1, mean) #look at all of the rows and run mean across them.
#when it looks at a row, it sees them all as numeric, rather than a data frame
#what we're getting back is the mean of each row. runs mean across every row in the dataframe
row_means <- apply(dat, 1, mean)
length(row_means)
col_means <- apply(dat, 2, mean)
class(col_means) #returns "numeric", didn't keep it as a data frame

##### ExerciseA: use apply to summarize dat with functions min, max, sd #####
row_min <- apply(dat, 1, min)
row_max <- apply(dat, 1, max)
row_sd <- apply(dat, 1, sd)
col_min <- apply(dat, 2, min)
col_max <- apply(dat, 2, max)
col_sd <- apply(dat, 2, sd)

row_mins2 <- 0
for(i in 1:10) {
  row_mins2[i] <- min(dat[i, ])
}
rm(row_mins2) #get rid of this from workspace

summary(dat)
summary(dat[4:6, 1])

##### 5. PLOTTING #####

plot(row_max) #girl you ugly
plot(row_max, type = "l") #default type is p for points
plot(col_sd, type="l")

##### ExerciseB: make a plot of mean value across patients 1-10 for all columns #####
#means of each row
row_means1to10 <- apply(dat[1:10], 1, mean)
plot(row_means1to10, type="l")

#means of each column
# col_means1to10 <- apply(dat[1:10, ], 2, mean)
# plot(col_means1to10, type = "l", ylab = "Mean", xlab = "Days")
plot(apply(dat[1:10, ], 2, mean), type="l", ylab = "Mean", 
     xlab = "Days", main = "Mean inflammation across days") 








