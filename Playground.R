# Load the following packages
library(tidyverse)
library(caret)

DDSA <- read_excel("CaseStudy2-data.xlsx")

nrow(DDSA)

table(DDSA$Attrition)

prop.table(table(DDSA$Attrition))

summary(DDSA$MonthlyIncome)

summary(DDSA$TotalWorkingYears)


table(DDSA$JobRole)
