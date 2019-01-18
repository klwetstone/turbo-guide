rm(list = ls())
dat <- read.csv(file = "data/inflammation-01.csv", header = FALSE) 

# new fxn to provide summary statistics of data
analyze <- function(file_name) {
  # read in data at file_name
  dat <- read.csv(file = file_name, header = FALSE)
  
  # get average, minimum, maximum along columns 
  col_min = apply(dat, 2, min)
  col_max = apply(dat, 2, max)
  col_avg = apply(dat, 2, mean)
  
  # output
  # returns <- 0
  # returns["col_min"] <- col_min
  # returns["col_max"] <- col_max
  # returns["col_avg"] <- col_avg
  
  #use rbind or cbind
  rbind(col_avg, col_max, col_min) #each vector is a row of the resulting data structure
  # cbind (col_avg, col_max, col_min)   #each vector is a column of the resulting data structure
}

# summary <- analyze("data/inflammation-01.csv")

list.files()
list.files(path="data")
inflammation_files <- list.files(path = "data", pattern = "inflammation", 
                                 full.names = TRUE)

# for loop for iteration
#use a list. each element can be anything
inflammation_results <- vector("list", length(inflammation_files))
# i <- 1 don't need to do this when you use seq_along instead
# seq_along(inflammation_results) #returns a sequence along its length
#here seq_along returns 1:12
#lists are indexed by double brackets. inflammation_results[[3]] gives third one
for (file_index in seq_along(inflammation_results)) { 
  #make sure for loop is working right, should print a list of all the names in inflammation_files
  file = inflammation_files[file_index]
  print(paste("Analyzing", file)) #paste basically concatenates contents into one character
  inflammation_results[[file_index]] <- analyze(file_name = file)
  # i = i+1
}

#####

?lapply #output always is a list

#write lapply to make it do exactly what's in the for loop
inflammation_results2 <-
  lapply(X = seq_along(inflammation_results), 
         FUN = function(file_index) {
           file <- inflammation_files[file_index]
           out <- analyze(file_name = file)
           return(out)
         })

all.equal(inflammation_results, inflammation_results2) #returns true!
