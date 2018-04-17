# Load the following packages
library(keras)
library(lime)
library(tidyquant)
library(rsample)
library(recipes)
library(yardstick)
library(corrr)
library(readxl)
library(tidyverse)
library(glmnet)
library(rpart)
library(rpart.plot)
library(randomForest)

# Load raw data
raw_DDSA <- read_excel("CaseStudy2-data.xlsx")

# Change characters to factors for more meaningfull analysis
DDSA <- raw_DDSA%>%
  mutate_if(is.character, as.factor) %>%
  select(Attrition, everything())

# Glimpse is a better way to view the data
glimpse(DDSA)


# Build training and test sets
set.seed(101)
library(caTools)

# Split ratio for training and test sets
split = sample.split(DDSA$Attrition, SplitRatio = 0.60)

# Create training and testing sets
train = subset(DDSA, split == TRUE)
test = subset(DDSA, split == FALSE)

# Random Forrest model
modelRf = randomForest(Attrition ~ ., data=train, ntree = 100, mtry = 5, importance = TRUE, method="class")
print(modelRf)

#OOB vs No. Of Trees
# Out-of-bag (OOB) error ~ a method of measuring the prediction error of random forests, 
# boosted decision trees, and other machine learning models utilizing bootstrap aggregating 
#(bagging) to sub-sample data samples used for training.
plot(modelRf, main="")
legend("topright", c("OOB", "0", "1"), text.col=1:6, lty=1:3, col=1:3)
title(main="Error Rates Random Forest")


## List the importance of the variables.
impVar <- round(randomForest::importance(modelRf), 2)
impVar[order(impVar[,3], decreasing=TRUE),]


# Focus on critical features of attrition
attrition_critical_features <- DDSA %>%
  tibble::as_tibble() %>%
  select(Attrition, OverTime,TotalWorkingYears,Age) %>%
  rowid_to_column(var = "Case")
attrition_critical_features
