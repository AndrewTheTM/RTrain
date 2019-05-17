# EX04: dplyr
# 
# Intro: dplyr is a Swiss Army Knife of utilities that make a lot of things easier in R, including
# calculations, joins, and aggregation. The statements will 'stack' allowing for very complex operations in just
# a few lines of code.

rm(list = ls())

library(dplyr)

hh = read.csv("data\\HHList.csv")
per = read.csv("data\\PerList.csv")

# Filter Data ####

HH.big = hh %>%
  filter(hhsize >= 4)

HH.big.zerocar = hh %>%
  filter(hhsize >= 4 & numAuto == 0)

# Group and Summarize ####

hh.size = hh %>%
  group_by(hhsize) %>%
  summarize(nHH = n())

hh.size.auto = hh %>%
  group_by(hhsize) %>%
  summarize(nHH = n(), 
            meanAuto = mean(numAuto), 
            sdAuto = sd(numAuto),
            totAuto = sum(numAuto))

# You can use any aggregate statistic function here:
#  min, max, mean, median, sd (standard deviation), var (variance), sum, cor (Pearson correlation), cov (Pearson covariance)...

hh.size.auto = hh %>%
  group_by(hhsize) %>%
  summarize(nHH = n(), 
            meanAuto = mean(numAuto), 
            sdAuto = sd(numAuto),
            totAuto = sum(numAuto),
            r2sizeauto = cor(numAuto, hhIncomeDollars))

# Mutations ####

hh.size = hh %>%
  group_by(hhsize) %>%
  summarize(nHH = n()) %>%
  mutate(pctHH = nHH / sum(nHH))

# Joins ####

hhper = per %>%
  left_join(hh, by = "hhid")

# the above results in a large table, we probably don't need all

hhper = per %>%
  left_join(hh %>%
              select(hhid, numAuto, homeTaz, dwellingType),
            by = "hhid")

# This has 40 variables (37 in the person table + 3 from the select statement), way easier to handle!

hh.u18 = hh %>%
  select(hhid, hhsize) %>%
  left_join(per %>%
              group_by(hhid) %>%
              summarize(nU18 = sum(ifelse(age < 18, 1, 0))),
            by = "hhid")

# Rename a column ####
hh.u18 = hh.u18 %>%
  rename(under18 = nU18)
