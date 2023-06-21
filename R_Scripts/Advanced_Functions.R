Titanic1 <- read.csv("https://raw.githubusercontent.com/mariocastro73/ML2020-2021/master/datasets/Titanic.csv")

View(Titanic1)
str(Titanic1)
summary(Titanic1)

#Remove NA values 
Titanic2 <- Titanic1[!is.na(Titanic1$Age),]

View(Titanic2)

#Function to remove NA 
Titanic3 <- na.omit(Titanic1)

#with: void repetitive typing
Titanic3$Survived <- as.factor(Titanic3$Survived)
plot(Titanic3$Age ~ Titanic3$Survived)

#Telling R to do some stuff
with(Titanic3, plot(Age~Survived))

with(Titanic3,
     {plot(Age~Survived);
       plot(Age~Sex)}
)



#Custom function
#Create a function that calculates the mean and sd for a vector

c(mean(Titanic3$Age,sd(Titanic3$Age)))

My_Function <- function(V){
  return(c(mean(V),sd(V)))
}

My_Function(Titanic3$Age)


#by

#CHECK WITH YOUR FUNCTION THE MEAN AND SD FOR SURVIVED VS NOT 
My_Function(Titanic3$Age[Titanic3$Survived==0])
My_Function(Titanic3$Age[Titanic3$Survived==1])

#by  
by(Titanic3$Age, Titanic3$Survived, My_Function)

#use by function with, with function
with(Titanic3,
     by(Age, Survived, My_Function))



