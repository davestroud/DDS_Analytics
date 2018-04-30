library(tidyverse)
library(caret)
library(readr)

winequality_red <- read_csv("winequality-red.csv")
View(winequality_red)

# Create custom trainControl: myControl
myControl <- trainControl(
  method = "cv", number = 10,
  summaryFunction = twoClassSummary,
  classProbs = TRUE, # IMPORTANT!
  verboseIter = TRUE
)

