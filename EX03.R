# IMPORTING AND EXPORTING DATA
#
# Intro: data comes in all formats, let's import some!
# 
# CSV is built-in to R, DBF is part of the foreign library (which will also import SPSS, SAS, Weka, Stata, and several others), and 
# XLSX is part of the openxlsx library. Other libraries can import XLS, Google Sheets, Shapefiles, Open Matrix (OMX), and many others.

rm(list = ls())

hh = read.csv("data\\HHList.csv")

summary(hh)

hh[,c("hhid", "homeTaz")]
hh[1:10] # First 10 columns
hh[1:10,] #First 10 rows, all columns - note the comma!
hh[1:10,c("hhid", "homeTaz")]
hh[1:10, 1:10] #rows 1-10, columns 1-10

hh[hh$hhsize < 2] #ERROR! "Undefined columns selected"
hh[hh$hhsize < 2,]

nrow(hh[hh$hhsize < 2,])
nrow(hh)

hh.subset = hh[hh$hhsize < 2,] # Dumping all this out on the screen is a pain!

# Read a DBF file
rm(list = ls())
library(foreign)

hnet = read.dbf("data\\C_D15HASSIGN.DBF")
summary(hnet)
summary(hnet$VOL24TOT) # Incorrect column name
summary(hnet$VOL24_TOT)

nrow(hnet[hnet$VOL24_TOT == 0,])
nrow(hnet)

# We will come back to this later and do some cool things with this highway network

# Read an Excel file
rm(list = ls())
library(openxlsx)
tnet = read.xlsx("data\\amtimecompare.xlsx")
summary(tnet)
plot(tnet) #explosion of data
plot(tnet$autotime, tnet$trtime)
cor(tnet$autotime, tnet$trtime)

# Export Data ####
#
# In almost all cases, write.{format}(df, filename)
# A trick is to use file.choose() for the filename.

write.dbf(tnet, file.choose()) # Note that you **must** include the '.dbf' on the file!
