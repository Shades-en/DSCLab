install.packages("ggplot2")
install.packages("caTools")
install.packages("Metrics")
library(ggplot2)
library(caTools)
library(Metrics)
weather <- data.frame(
  temp=c(18, 21, 25, 28, 30, 35, 42, 45, 47, 48),
  humidity=c(47, 51, 55, 59, 63, 67, 72, 75, 77, 81),
  rainy_day=c(0,0,0,0,0,0,1,1,1,1)
)

weather

write.csv(weather, "weather.csv", row.names = F)
weather <- read.table("weather.csv", header=T, sep=',')
weather

split = sample.split(weather$humidity, SplitRatio=0.7)
train <- subset(weather, split==T)
test <- subset(weather, split==F)

model <- lm(formula= humidity ~ temp, train)
summary(model)
coef(model)

pred <- predict(model, newdata=train)
pred
mse(pred, train$humidity)   
ggplot() + geom_point(aes(x=train$humidity, y=train$temp)) + geom_line(aes(x=pred, y=train$temp))

pred_ <- predict(model, test)
pred_
mse(pred_, test$humidity)
ggplot() + geom_point(aes(x=test$humidity, y= test$temp)) + geom_line(aes(x=pred_, y= test$temp))

split = sample.split(weather$humidity, SplitRatio=0.7)
train <- subset(weather, split==T)
test <- subset(weather, split==F)


#---------------------------------------------------------------------------------------------------
model2 <- glm(formula= rainy_day ~ temp + humidity, data=train, family=binomial)
summary(model2)

pred = predict(model2, train, type="response")
pred_prob <- ifelse(pred>0.5, 1, 0)
accuracy <- mean(pred_prob == train$rainy_day)
accuracy

pred2 = predict(model2, test, type="response")
pred_prob2 <- ifelse(pred2>0.5, 1, 0)
accuracy2 <- mean(pred_prob2 == test$rainy_day)
accuracy2

ggplot(train) + geom_density(aes(x=pred, color=as.factor(train$rainy_day)))

ggplot(weather, aes(x = temp, y = rainy_day)) +
  geom_point() +
  geom_line() +
  labs(title = "Logistic Regression: Probability of High Humidity vs Temperature")

