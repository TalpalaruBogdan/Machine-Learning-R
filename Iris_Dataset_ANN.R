#refference libraries
#library("keras")
library(neuralnet)
# load library
require(neuralnet)

set.seed(1)

#import iris as frame
irisData <- as.data.frame(iris)

##Normalization
#turn labels to binary values
labels <- class.ind(as.factor(irisData$Species))

#create columns for binary output
irisData <- cbind(irisData, irisData$Species == 'setosa')
irisData <- cbind(irisData, irisData$Species == 'versicolor')
irisData <- cbind(irisData, irisData$Species == 'virginica')

#rename columns friendly
names(irisData)[6] <- 'setosa'
names(irisData)[7] <- 'versicolor'
names(irisData)[8] <- 'virginica'

#set a sample size for training
size.sample <- 50
trainSize.sample <- 10

#create a sample for training purposes
iristrain <- irisData[sample(1:nrow(irisData), size.sample),] # get a training sample from iris
nnet_iristrain <- iristrain

#carete a sample for test purposes
iristest <- irisData[sample(1:nrow(irisData), trainSize.sample),] # get a test sample from iris
nnet_iristest <- iristest

#visualize head for test and for train data
head(nnet_iristest)
head(nnet_iristrain)

#create neural network
#setosa, versicolor and virginica are output neurons
#data source is nnet_iristrain frame
#hidden layer size is 2, with 10 each 
nn <- neuralnet(setosa+versicolor+virginica ~ Sepal.Length+Sepal.Width+Petal.Length+Petal.Width, 
                data=nnet_iristrain, 
                hidden=c(10,10))

#plot the network
plot(nn)

#create predictions from the test set
Predict <- compute(nn,nnet_iristest)

#store net result in a variable
result <- as.data.frame(Predict$net.result)

#label the columns of the result
names(result)[1] <- "setosa"
names(result)[2] <- "versicolor"
names(result)[3] <- "virginica"

#store column index with max value in final list
pr.nn_2 <- max.col(result)

#replace numerical values with labels
setosa <- replace(pr.nn_2, pr.nn_2 == 1, "setosa") 
versicolor <- replace(setosa, pr.nn_2 == 2, "versicolor") 
FinalPrediction <- replace(versicolor, pr.nn_2 == 3, "virginica")

#append final prediction to the ireis est data
iristest <- cbind(iristest, FinalPrediction)

#remove binary columns from output
iristest = subset(iristest, select = -c(6,7,8))
iristest
