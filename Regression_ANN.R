
#refference libraries
library("neuralnet")
# load library
require(neuralnet)

#Set seed
set.seed(1)

# creating training data set
TKS=c(1,0,0,0,1,1)
CSS=c(1,0,1,0,1,0)
Placed=c(1,0,0,0,1,1)

# Combine arrays in data frame
df=data.frame(TKS,CSS,Placed)


# fit neural network
nn=neuralnet(Placed~TKS+CSS,
             data=df, 
             #one layer with 3 is insufficient, 10 | 10 is ok
             hidden=c(10,10),
             act.fct = "logistic",
             linear.output = FALSE)
#- Placed~TKS+CSS, Placed is label and TKS and CSS are features.

# plot neural network
plot(nn)

# creating test set
TKS=c(0,0,1)
CSS=c(1,0,0)
test=data.frame(TKS,CSS)

# Prediction using neural network
Predict=compute(nn,test)
Predict$net.result

# Converting probabilities into binary classes setting threshold level 0.5
prob <- Predict$net.result
pred <- ifelse(prob>0.5, 1, 0)
pred
