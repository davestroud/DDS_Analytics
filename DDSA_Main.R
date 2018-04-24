library(rsample)
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

# Change characters to factors for more meaningful analysis
DDSA <- raw_DDSA%>%
  mutate_if(is.character, as.factor) %>%
  select(Attrition, everything())
# attach so we don't have to keep writing DDSA$
attach(DDSA)

# View observations and variables
glimpse(DDSA)

# View summary statistics
summary(DDSA)


# Changed the following variables to categorical to eventually have a LifeSatisfaction variable
DDSA$DistanceFromHome <- cut(DDSA$DistanceFromHome, breaks = c(-Inf, 9, 21, Inf), labels=c("Poor", "Fair", "Good"))

DDSA$RelationshipSatisfaction <- cut(DDSA$RelationshipSatisfaction, breaks = c(-Inf, 2, 3, Inf), labels=c("Poor", "Fair", "Good"))

DDSA$WorkLifeBalance <- cut(DDSA$WorkLifeBalance, breaks = c(-Inf, 2, 3, Inf), labels=c("Poor", "Fair", "Good"))


ggplot(data = DDSA) +
  geom_bar(mapping = aes(x=DistanceFromHome))

ggplot(data = DDSA) +
  geom_bar(mapping = aes(x=RelationshipSatisfaction))

ggplot(data = DDSA) +
  geom_bar(mapping = aes(x=WorkLifeBalance))


# Is there a relationship between Age and Income. 
# Color each point based on the Gender of the participant
ggplot(data=DDSA) +
  geom_point(mapping = aes(x = Age, y = MonthlyIncome, color=Gender)) +
  geom_smooth(mapping = aes(x = Age, y = MonthlyIncome)) + 
  xlab('Age') + ylab('Income') +
  ggtitle('Age vs Income') +
  theme(plot.title = element_text(hjust = 0.5))

# Split test/training sets ~ uses the rsample package
set.seed(100)
train_test_split <- initial_split(DDSA, prop = 0.8)
train_test_split

# Retrieve train and test sets
train_tbl <- training(train_test_split)
test_tbl <- testing(train_test_split)

table(test_tbl$Attrition)

237/nrow(test_tbl)

modelCart = rpart(Attrition ~ ., data=train_tbl, method="class")
#Plot the model
prp(modelCart)

#Predict the test data
predictionCart <- predict(modelCart, newdata=test_tbl, type="class")

#CART Accuracy
#Confusion matrix 
t1 <- table(test_tbl$Attrition, predictionCart)
print(t1)

# Confusion Matrix info: http://cs229.stanford.edu/section/evaluation_metrics.pdf


#CART model accuracy
(t1[1]+t1[4])/(nrow(test_tbl))

### Need to plot ROC curve

# Random Forest model
modelRf = randomForest(Attrition ~ ., data=train_tbl, ntree = 100, mtry = 5, importance = TRUE, method="class")
print(modelRf)

# Random Forest info: https://medium.com/@williamkoehrsen/random-forest-simple-explanation-377895a60d2d
# OOB estimate of  error rate: 13.34% ~ 


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

# Most important variables of attrition
attrition_variables <- DDSA %>%
  tibble::as_tibble() %>%
  select(Attrition, OverTime,Age, MonthlyIncome) %>%
  rowid_to_column(var = "Case")
attrition_variables


ggplot(DDSA, aes(JobRole, ..count.., fill = factor(Attrition))) + 
  geom_bar(position="dodge")+
  theme(axis.text.x = element_text(angle = 90)) +
  ggtitle('Attrition Based on Job Role') +
  theme(plot.title = element_text(hjust = 0.5))
 

ggplot(DDSA, aes(DistanceFromHome, ..count.., fill = factor(Attrition))) + 
  geom_bar(position="dodge") +
  theme(axis.text.x = element_text(angle = 90)) +
  ggtitle('Attrition Based on Distance from Home') +
  theme(plot.title = element_text(hjust = 0.5))


ggplot(DDSA, aes(RelationshipSatisfaction, ..count.., fill = factor(Attrition))) + 
  geom_bar(position="dodge") +
  theme(axis.text.x = element_text(angle = 90)) +
  ggtitle('Attrition Based on Relationship Status') +
  theme(plot.title = element_text(hjust = 0.5))


ggplot(DDSA, aes(WorkLifeBalance, ..count.., fill = factor(Attrition))) + 
  geom_bar(position="dodge") +
  theme(axis.text.x = element_text(angle = 90)) +
  ggtitle('Attrition Based on Work/Life Balance') +
  theme(plot.title = element_text(hjust = 0.5))


ggplot(DDSA, aes(Gender, ..count.., fill = factor(Attrition))) + 
  geom_bar(position="dodge") +
  theme(axis.text.x = element_text(angle = 90)) +
  ggtitle('Attrition Based on Gender') +
  theme(plot.title = element_text(hjust = 0.5))
  