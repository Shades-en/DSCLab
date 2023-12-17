install.packages("caTools")
install.packages("randomForest")

library(caTools)
library(randomForest)

patientId <- 1:1000
age<- sample(20:70, 1000, replace = T)
bloodP <- sample(90:140, 1000, replace=T)
chol <- sample(150:250, 1000, replace=T)
disease <- sample(c(T, F), 1000, replace=T)
gender <- sample (c("M", "F"), 1000, replace=T)

data <- data.frame(patientId, age, bloodP, gender, chol, disease)
head(data)

data$gender <- as.factor(data$gender)
data$disease <- as.factor(data$disease)
head(data)

split <- sample.split(data, SplitRatio = 0.9)
train <- subset(data, split==T)
test <- subset(data, split==F)

dim(train)
dim(test)

input <- train[, 2:5]
head(train[, 2:5])

model <- randomForest(input, train$disease, ntree = 500, class.f=T)
plot(model)

pred <- predict(model, input)
pred_val <- ifelse(pred>0.5, 1, 0)
cm <- table(pred_val, train$disease)
cm

varImpPlot(model)
importance(model)
