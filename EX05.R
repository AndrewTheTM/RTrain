# Writing functions
#
# Intro: some stuff is too complex to do in-line, so we'll write a function to do RMSE and then use cut and dplyr to 
# group and do RMSE by volume group (and factype, areatype)

rm(list = ls())
library(foreign)

# defining the volume groups
vg = rbind.data.frame(
  cbind(VG = 0, Vol = 0, RMSE_Limit = 200),
  cbind(VG = 1, Vol = 499, RMSE_Limit = 200),
  cbind(VG = 2, Vol = 1499, RMSE_Limit = 100), 
  cbind(VG = 3, Vol = 2499, RMSE_Limit = 62), 
  cbind(VG = 4, Vol = 3499, RMSE_Limit = 54), 
  cbind(VG = 5, Vol = 4499, RMSE_Limit = 48), 
  cbind(VG = 6, Vol = 5499, RMSE_Limit = 45), 
  cbind(VG = 7, Vol = 6999, RMSE_Limit = 42),
  cbind(VG = 8, Vol = 8499, RMSE_Limit = 39),
  cbind(VG = 9, Vol = 9999, RMSE_Limit = 36), 
  cbind(VG = 10, Vol = 12499, RMSE_Limit = 34), 
  cbind(VG = 11, Vol = 14999, RMSE_Limit = 31), 
  cbind(VG = 12, Vol = 17499, RMSE_Limit = 30), 
  cbind(VG = 13, Vol = 19999, RMSE_Limit = 28), 
  cbind(VG = 14, Vol = 24999, RMSE_Limit = 26), 
  cbind(VG = 15, Vol = 34999, RMSE_Limit = 24), 
  cbind(VG = 16, Vol = 54999, RMSE_Limit = 21), 
  cbind(VG = 17, Vol = 74999, RMSE_Limit = 18), 
  cbind(VG = 18, Vol = 119999, RMSE_Limit = 12), 
  cbind(VG = 19, Vol = 249999, RMSE_Limit = 12), 
  cbind(VG = 20, Vol = 9999999, RMSE_Limit = 10)
)

# the function...
rmse = function(aadt, vol){
  mse = sqrt(sum(((vol - aadt)^2)/(length(aadt)-1)))
  cnts = sum(aadt) / (length(aadt))
  pct = 100 * mse/cnts
  return(pct)
}

# the data
hnet = read.dbf("data\\C_D15HASSIGN.DBF")
hnet = hnet[hnet$AADT > 0,]

hnet$VG = cut(hnet$AADT, as.list(vg$Vol), labels = FALSE)

View(hnet[,c("AADT", "VG")])

rmsebyvg = hnet %>%
  group_by(VG) %>%
  summarize(RMSE = rmse(AADT, VOL24_TOT))

# Let's take that one step further...

rmsebyvg = hnet %>%
  group_by(VG) %>%
  summarize(RMSE = rmse(AADT, VOL24_TOT)) %>%
  left_join(vg, by = "VG")

# WE WILL COME BACK TO THIS!
