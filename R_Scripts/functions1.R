# Celsius to Fahrenheit function

c_to_f <- function(celcius)
  9/5*celcius+32

c_to_f(celcius = 20)

# Multiple argument
c_to_f <- function(celcius, freezing){
  9/5*celcius+freezing
}

c_to_f(20, 33)



