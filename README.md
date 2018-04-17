### Description: DDSAnalytics is an analytics company that specializes in talent management solutions for Fortune 1000 companies. Talent management is defined as the iterative process of developing and retaining employees. It may include workforce planning, employee training programs, identifying high-potential employees and reducing/preventing voluntary employee turnover (attrition). To gain a competitive edge over its competition, DDSAnalytics is planning to leverage data science for talent management. The executive leadership has identified predicting employee turnover as its first application of data science for talent management. Before the business green lights the project, they have tasked your data science team to conduct an analysis of existing employee data. 

### Your team has been given a dataset (CaseStudy2Data.zip) to conduct exploratory data analysis (EDA) to determine factors that lead to attrition.  You should identify (at least) the top three factors that contribute to turnover. There may or may not be a need to create derived attributes/variables. The business is also interested in learning about any job role specific trends that may exist in the data set (e.g., “Data Scientists have the highest job satisfaction”). You can also provide any other interesting trends and observations from your analysis. The analysis should be backed up by robust experimentation and (where applicable) appropriate visualization. Experiments and analysis must be conducted in R. If needed, consult with the business owner to get clarifications on the dataset or business goals. 



### Summary of Data
#### Data Set has 1,470 observations with 35 variables. Nine of the variables are categorial, while the remaining 26 are numeric. 

#### Changed DistanceFromHome, RelationshipSatisfaction and WorkLifeBalance to categorical variable to satisfy the requirement of having a Life Satisfaction variable. 

#### Is there a relationship between Age and Income. Color each point based on the Gender of the participant. 
#### What about Life Satisfaction?  

#### Changed Attrition variable to a factor from a string to prepare for logistic regression analysis. 

#### The fundamental idea behind a random forest is to combine many decision trees into a single model.

#### To understand the random forest model, we must first learn about the decision tree, the basic building block of a random forest

#### Confusion Matrix info: http://cs229.stanford.edu/section/evaluation_metrics.pdf

# Random Forest info: https://medium.com/@williamkoehrsen/random-forest-simple-explanation-377895a60d2d


#### How to interpret confusion matrix for Random Forest https://stats.stackexchange.com/questions/30691/how-to-interpret-oob-and-confusion-matrix-for-random-forest