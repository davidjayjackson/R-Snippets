#
# Arpan Gupta, Random Forest R Example
#
library(MASS)
library(randomForest)
library(caTools)
library(pROC)
#
set.seed(123456789)
DataFrame <-birthwt
str(DataFrame)
dim(DataFrame)
summary(DataFrame)
apply(DataFrame,2,function(x) length(unique(x)))
hist(DataFrame$age,main="Pregnancy by Age")
col <- c("low","race","smoke","ptl","ht","ui","ftv")
for (i in col) {
  DataFrame[,i]=as.factor(DataFrame[,i])
}
str(DataFrame)
ind <- sample.split(Y= DataFrame$low,SplitRatio = 0.7)
trainDF <- DataFrame[ind,]
testDF <- DataFrame[!ind,]
# Fitting the model
modelRandom <- randomForest(low~.,data=trainDF,mtry=3,mtree=20)
modelRandom
#
# Predict
importance(modelRandom)
varImpPlot(modelRandom)
PredictsWithClass <- predict(modelRandom,testDF,type="class")
t <- table(predictions=PredictsWithClass,actual=testDF$low)
# Accuray metric
sum(diag(t))/sum(t)
#
PredictionWithProbs <- predict(modelRandom,testDF,type='prob')
auc <- auc(testDF$low,PredictionWithProbs[,2])
plot(roc(testDF$low,PredictionWithProbs[,2]))
# 
# To find best mtry
bestmtry <- tuneRF(trainDF,trainDF$low,ntreeTry=20,stepFactor=1.2,
                   improve= 0.01,
                   trace=T,plot=T)
bestmtry
##
# Random forest in R Classisification and Prediction Example
#  Bharatendra Rai
# Measurements of fetal heard rate(FHR) and uterine contraction(UC).
# CTG's classification label as Normal, Suspect or Pathologic
##
rm(list=ls())
data <- read.csv("./CTG.csv")
str(data)    
data$NSP <-as.factor(data$NSP)
table(data$NSP)
#
set.seed(123)
ind <- sample(2,nrow(data),replace= TRUE,prob = c(0.7,0.3))
train <- data[ind==1,]
test <- data[!ind ==1,]
#
# Random Forest
library(randomForest)
set.seed(222)
rf <- randomForest(NSP~.,data=train,ntree = 300,mtry=8,
                   importance= TRUE, proximity=TRUE )
attributes(rf)
library(caret)
p1 <- predict(rf,train)
head(p1)
head(train$NSP)
# Caret
confusionMatrix(p1,train$NSP)
# Predict on test data:
p2 <- predict(rf,test)
confusionMatrix(p2,test$NSP)
# Error Rate
plot(rf)
t <-tuneRF(train[,-22],train[,22],
       stepFactor = 0.5,
       plot = TRUE,
       ntreeTry = 300,
       trace= TRUE,
       imporove= 0.05)
# No. of nodes for the trees
hist(treesize(rf),
     main="No. of Nodes for the Trees",
     col="green")
varImpPlot(rf,
           sort=T,
           n.var=10,
           main="Top 10 Variable Importance")
importance(rf)
varUsed(rf)
# Partial DEpendence Plot
partialPlot(rf, train, ASTV,"1")
partialPlot(rf, train, ASTV,"2")
# EXtract Single Tree
getTree(rf,1,labelVar= TRUE)
# Multi-dimensional Scalling Plot
MDSplot(rf,train$NSP)
