# Quick Plotting
#
# Intro: Visualization of data is important (see t-rex animation from https://www.autodeskresearch.com/publications/samestats).

rm(list = ls())
source('EX05.R') #we're going to use data from the last exercise

# Simple Quick Plots ####
plot(hnet$AADT, hnet$VOL24_TOT)

hist(hnet$AADT)

hist(hnet$AADT, breaks = 1000)

# Scatter Plots Using ggplot2 ####
library(ggplot2)
ggplot(hnet, aes(x = AADT, y = VOL24_TOT)) + geom_point()

# Lets improve on this...
ggplot(hnet, aes(x = AADT, y = VOL24_TOT)) + geom_point(alpha = 0.1)

ggplot(hnet, aes(x = AADT, y = VOL24_TOT)) + geom_point(alpha = 0.1) +
  geom_abline(slope = 1, intercept = 0, color = "red")

ggplot(hnet, aes(x = AADT, y = VOL24_TOT, color = FACTYPE)) + geom_point(alpha = 0.1) +
  geom_abline(slope = 1, intercept = 0, color = "red")

# the above has an issue - factype is being seen as a continuous number variable, we need to convert it to factors

ggplot(hnet, aes(x = AADT, y = VOL24_TOT, color = as.factor(FACTYPE))) + geom_point(alpha = 0.1) +
  geom_abline(slope = 1, intercept = 0, color = "red")

# the default colors aren't great, let's add ColorBrewer...
library(RColorBrewer)
ggplot(hnet, aes(x = AADT, y = VOL24_TOT, color = as.factor(FACTYPE))) + geom_point(alpha = 1.0) +
  scale_color_brewer(palette = "Accent") +
  geom_abline(slope = 1, intercept = 0, color = "red") 

# For ColorBrewer palettes, see http://www.cookbook-r.com/Graphs/Colors_(ggplot2)/#rcolorbrewer-palette-chart

# Titles and stuff? 
library(scales)
ggplot(hnet, aes(x = AADT, y = VOL24_TOT)) + geom_point(alpha = 0.1) +
  geom_abline(slope = 1, intercept = 0, color = "red") +
  ggtitle("Count - Model Assignment Comparison", "2015 C_D Model") +
  xlab("Annualized Average Daily Traffic") +
  ylab("Model Assignment") +
  scale_x_continuous(label = comma) + 
  scale_y_continuous(label = comma)


# Line Plot ####
ggplot(rmsebyvg, aes(x = VG, y = RMSE / 100)) + geom_line() +
  geom_line(aes(y = RMSE_Limit / 100), color = "red") +
  ggtitle("Root Mean Square Error by Volume Group") +
  xlab("Volume Group") + ylab("RMSE") +
  scale_y_continuous(label = percent)

# Histogram ####

trip = read.csv("data\\trips.csv")
trip$tripTime = trip$finalArriveMinute - trip$finalDepartMinute

ggplot(trip, aes(x = tripTime)) + geom_histogram(binwidth = 1)

# Frequency polyline - standard for TLF charts ####

ggplot(trip, aes(x = tripTime, y = stat(density))) + geom_freqpoly(binwidth = 1) +
  scale_y_continuous(label = percent)

# NOTE: there is a new feature I'm using here, if you get the error 
# "Error in stat(density): could not find function "stat"", try replacing stat with calc, if that doesn't work, 
# either use devtools to update ggplot2 or remove the y aesthetic and don't show it as density

# Box and whisker plots ####

hh = read.csv("data\\HHList.csv")

ggplot(hh, aes(x = as.factor(hhsize), y = hhIncomeDollars)) + geom_boxplot() +
  scale_y_continuous(label = dollar)

# themes
ggplot(trip, aes(x = tripTime)) + geom_freqpoly(binwidth = 1) + theme_grey() #default!
ggplot(trip, aes(x = tripTime)) + geom_freqpoly(binwidth = 1) + theme_bw()
ggplot(trip, aes(x = tripTime)) + geom_freqpoly(binwidth = 1) + theme_linedraw()
ggplot(trip, aes(x = tripTime)) + geom_freqpoly(binwidth = 1) + theme_light()
ggplot(trip, aes(x = tripTime)) + geom_freqpoly(binwidth = 1) + theme_dark()
ggplot(trip, aes(x = tripTime)) + geom_freqpoly(binwidth = 1) + theme_minimal()
ggplot(trip, aes(x = tripTime)) + geom_freqpoly(binwidth = 1) + theme_classic()
ggplot(trip, aes(x = tripTime)) + geom_freqpoly(binwidth = 1) + theme_void()
ggplot(trip, aes(x = tripTime)) + geom_freqpoly(binwidth = 1) + theme_test()

# See https://ggplot2.tidyverse.org/reference/ggtheme.html

