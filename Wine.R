library(tidyverse)
library(caret)
library(readr)

overfit <- read_csv("overfit.csv")

myControl <- trainControl(
  method = "cv", number = 10,
  summaryFunction = twoClassSummary,
  classProbs = TRUE, # Super important!
  verboseIter = TRUE
)

set.seed(42)
  model <- train(y ~ ., overfit, method = "glmnet",
                 trControl = myControl)
# Plot results
  plot(model)
  
  expand.grid(alpha = 0:1,
              lambda = seq(0.0001, 1, length = 100))
  
  # Train glmnet with custom trainControl and tuning: model
  model <- train(
    y ~ ., overfit,
    tuneGrid = expand.grid(alpha = 0:1,
                           lambda = seq(0.0001, 1, length = 20)),
    method = "glmnet",
    trControl = myControl
  )
  
  # Print model to console
  model
  
  # Print maximum ROC statistic
  max(model[["results"]][["ROC"]])
  