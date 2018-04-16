# Load libraries
library(keras)
library(lime)
library(tidyquant)
library(rsample)
library(recipes)
library(yardstick)
library(corrr)
library(readxl)

DDSA <- read_excel("CaseStudy2-data.xlsx")

# Convert data to tbl class to make data easier to manage
DDSA <- tbl_df(DDSA)

glimpse(DDSA)
