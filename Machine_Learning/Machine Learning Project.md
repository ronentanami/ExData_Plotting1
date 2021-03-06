Practical Machine Learning Project
========================================================
Sing devices such as Jawbone Up, Nike FuelBand, and Fitbit it is now possible to collect a large amount of data about personal activity relatively inexpensively.  

In this project we use data from accelerometers on the belt, forearm, arm, and dumbell of 6 participants. They were asked to perform barbell lifts correctly and incorrectly in 5 different ways. More information is available from the website here: http://groupware.les.inf.puc-rio.br/har (see the section on the Weight Lifting Exercise Dataset).  

The goal of this project is to predict the manner in which they did the exercise. This is the "classe" variable in the training set.  



```r
setwd("~/Data Science/Practical Machine Learning/Work")  # set working directory
library(caret)
set.seed(3333)
```

# Reading data, Initital cleaning and Partitioning


```r
# Read training data from file
trainingIn = read.table("~/Data Science/Practical Machine Learning/Work/pml-training.csv", sep = ",", header = TRUE , na.strings = c("","NA"))

# Since the first 6 columns are not segnificant for prediction (timestamps and user name) I decided to remove them:
trainingIn1 = trainingIn[,7:160]

# Let's pratition the data  to training and testing set
trainIndex = createDataPartition(y = trainingIn1$classe, p = 0.7,list=FALSE)
training = trainingIn1[trainIndex,]
testing = trainingIn1[-trainIndex,]
```

# Cleaning the data
After removing the first 6 columns we are left with 154 columns. Apparently this data frame is sparse. there
are many columns with most rows "NA". I would like to remove those columns to ease the calculation. I choose to remove
columns with more than 90% "NA":


```r
# Cleaning NA
b = colSums(is.na(training))  # counts "NA"s in every column
c = b/ nrow(training) 
training1 = training[, c < 0.1]  ## Remove all columns with 90% NA for training data
testing1 = testing[, c < 0.1]    ## Remove all columns with 90% NA for testing data
```


# Random Forest & Finding Important Variables

I decided to use Random Forest algorithm since it is very good in dealing with many parameters data. In addition the algorithm generates a list with the importance of the parameters so I can reduce the amount of variables to speed running time.  

Since my computational resources are limited I will run the Random Forest algorithm on 5% of the training population. Then I will analyse the importance of variables. I will choose the most important variables and will reduce the population from 54 variables to 15 variables. Then I will run again the algorithm on the rest 95% of training population.




```r
# Spliting training to 5% and 95% data frames
trainIndex1 <- createDataPartition(y = training1$classe, p = 0.05, list = F)
training1Sub <- training1[trainIndex1, ]  ##  5% of training population
training2Sub <- training1[-trainIndex1, ] ## 95% of training population

# Running the RF model on 5% poulation
modFit <- train(classe ~ ., data = training1Sub, method = "rf")
# finding the Variable importance
varImp1 <- varImp(modFit)
```

Lets plot the most 15 importent variables


```r
# Ploting top 15 variables
plot(varImp1, main = "Top 15 Training Variables", top = 15)
```

![plot of chunk unnamed-chunk-2](figure/unnamed-chunk-2.png) 

As I stated above we would like to run the model on a subset of variables due to performance considerations. I will select all variables that give the most 25% of importance.


```r
#Top 25% variables
VarImp25 <- quantile(varImp1$importance[, 1], 0.75)
VarImpSelect <- varImp1$importance[, 1] >= VarImp25
training3 <- training2Sub[, VarImpSelect]
dim(training3)  ## check the size of final training DF to run the model
```

```
## [1] 13048    15
```

# Running the final model

```r
modFit1 <- train(classe ~ ., data = training3, method = "rf")
```


```r
# Checking the model on test data
testing3 <- testing1[, VarImpSelect]  # Reducing test data variables
prediction <- predict(modFit1, testing3)
missClass = function(values, prediction) {
        sum(prediction != values)/length(values)
}
modelError = missClass(testing3$classe, prediction)
cat("Model Error = ",round(modelError * 100,1),"%")
```

```
## Model Error =  0.2 %
```

It seems that the error is 0.2% for the testing set, meaning the model is accurate.

# Prediction

Lets run the model on the PMI-TESTING file:


```r
# Read training data
pmi.testing = read.table("~/Data Science/Practical Machine Learning/Work/pml-testing.csv", sep = ",", header = TRUE , na.strings = c("","NA"))

pmi.testing1 = pmi.testing[,7:160]  # Removing columns as above
pmi.testing2 = pmi.testing1[, c < 0.1] # Removing columns as above
pmi.testing3 <- pmi.testing2[, VarImpSelect] # Removing columns as above
prediction1 <- predict(modFit1, pmi.testing3)
prediction1
```

```
##  [1] B A B A A E D B A A B C B A E E A B B B
## Levels: A B C D E
```
