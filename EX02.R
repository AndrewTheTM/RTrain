# INTRO
# Data frames!
rm(list = ls())

# Data frame from -100 to 100, and an example of a quadratic function

df = data.frame(x = -100:100)
df$y = df$x^2 + 4 * df$x + 3
plot(df) # Since we used x and y in the dataframe, we don't need to tell the plot function which is which
cor(df$x, df$y) #correlation coefficient
mean(df$x)
mean(df$y)
summary(df)
quantile(df$y)

# Calculus - integrate the above curve for 0 - 50

f = function(x) x^2 + 4 * x + 3
integrate(f, 0, 50)

# adding columns - cbind and cbind.data.frame
df = cbind(x = 1:10)
df = rbind(x = 1:10)
View(t(df))

df1 = data.frame(x = 1:10)
df2 = data.frame(x = 11:20)

df = rbind(df1, df2)
# WE WILL COME BACK TO SOME OF THESE!!!