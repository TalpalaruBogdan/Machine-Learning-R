#Install libraries
#install.packages("keras")
#install_keras()
#install.packages("neuralnet")

#refference libraries
#library("keras")
library("neuralnet")
# load library
require(neuralnet)


set.seed(1)

#Citesc din csv intr-un dataset
#irisData <- read.csv("C:/Users/bogdant/Desktop/iris.csv", header = FALSE, col.names=c("sepal.length","sepal.width","petal.length","petal.width","species"))

# creating training data set
TKS=c(1,0,0,0,1,1)
CSS=c(1,0,1,0,1,0)
Placed=c(1,0,0,0,1,1)
# Here, you will combine multiple columns or features into a single set of data
df=data.frame(TKS,CSS,Placed)


# fit neural network
nn=neuralnet(Placed~TKS+CSS,
             data=df, 
             #one layer with 3 is insufficient, 10 | 10 is ok
             hidden=c(10,10),
             act.fct = "logistic",
             linear.output = FALSE)

#- Placed~TKS+CSS, Placed is label annd TKS and CSS are features.
#- df is dataframe,
#- hidden=3: represents single layer with 3 neurons respectively.
#- act.fct = "logistic" used for smoothing the result.
#- linear.ouput=FALSE: set FALSE for apply act.fct otherwise TRUE

# plot neural network
plot(nn)

# creating test set
TKS=c(0,0,1)
CSS=c(1,0,0)
test=data.frame(TKS,CSS)

## Prediction using neural network
Predict=compute(nn,test)
Predict$net.result

# Converting probabilities into binary classes setting threshold level 0.5
prob <- Predict$net.result
pred <- ifelse(prob>0.5, 1, 0)
pred