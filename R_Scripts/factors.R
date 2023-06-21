library(tidyverse)
(x1 <- 1:3)
(y <- 1:9)

(df1 <- cbind.data.frame(x1, y))

typeof(df1$x1)
str(df1)

(x2 <- as.factor(c(1:3)))
(df2 <- cbind.data.frame(x2, y)) 
typeof(df2$x2)
str(df2)

# how to define your data as numeric by coercing it to factors

# 3 options escaped/not escaped/unclear
x3 <- c(1:3)
# colony of 9 mole-rats
(y <- 1:9)

df3 <- cbind.data.frame(x3, y)
df3$x3 <- factor(df3$x3,
                 levels = c(1,2,3),
                 labels = c("escaped", "unclear", "definetly not"))
df3

# seq generation
x3 <- seq(10)
(x4 <- seq(30, 0, by = -3))
#enter values fast
x6 <- scan()
x6

x7 <- rep(T, 5)
x7




