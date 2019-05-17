# INTRO
# 
# Basic list examples

# rm means "remove", the command below removes all data in memory
rm(list = ls())

# Ordered list - 1 through 25 (inclusive)
x = 1:25
median(x)
mean(x)
sd(x)
var(x)

# 'Unordered' list (it'a actually the Fibbonacci Sequence)
rm(list = ls())
x = c(1, 2, 3, 5, 8, 13, 21, 34, 55)
median(x)
mean(x)
sd(x)
var(x)

# Repetitive lists
rm(list = ls())

x = rep(1, 100)
median(x)
mean(x)
sd(x)
var(x)

# Lists can also be text
rm(list = ls())
x = c("Andrew", "was", "here")
mean(x) # try it! 
x[1]

for(i in 1:3){
  print(x[i])
}

for(i in seq(1, 3)){
  print(x[i])
}

for(y in x){
  print(y)
}
