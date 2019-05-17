#
# EX08.R
#
# OMX!

install.packages("devtools")

devtools::install_github("gregmacfarlane/omxr")

source("http://bioconductor.org/biocLite.R")
biocLite("rhdf5")

library(omxr)
library(tidyverse)

list_omx("data/DC_Skim.omx")

distSkim = read_omx("data/DC_Skim.omx", "Length (Skim)") %>%
  long_matrix(value = "length")

ptrips.hbwsov = read_omx("data/PA_Trips.omx", "HBWSOV") %>%
  long_matrix(value = "HBWSOV")

ptrips.hbwhov = read_omx("data/PA_Trips.omx", "HBWHOV") %>%
  long_matrix(value = "HBWHOV")

ptrips.hov = ptrips.hbwsov %>%
  left_join(ptrips.hbwhov, by = c("origin", "destination")) %>%
  left_join(distSkim, , by = c("origin", "destination")) %>%
  mutate(HBW = HBWSOV + HBWHOV)
  
simptlf = ptrips.hov %>%
  group_by(dist = as.integer(length)) %>%
  summarize(tripshbw = sum(HBW)) %>%
  mutate(pctTLF = tripshbw/sum(tripshbw))

ggplot(simptlf, aes(x = dist, y = pctTLF)) + geom_line()
