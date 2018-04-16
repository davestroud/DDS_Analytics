# Load the following packages
library(tidyquant)  # Loads tidyverse and several other pkgs 
library(readxl)     # Super simple excel reader
library(h2o)        # Professional grade ML pkg
library(lime)       # Explain complex black-box ML models

DDSA <- read_excel("CaseStudy2-data.xlsx")

# View first 10 rows
DDSA[1:10,] %>%
  knitr::kable(caption = "First 10 rows")

