install.packages("ClusterR")
install.packages("cluster")
library(ClusterR)
library(cluster)

x <- c(2,2,8,5,7,6,1,4,3);
y <- c(10,5,4,8,5,4,2,9,9);

data <- data.frame(x, y)
data

write.csv(data, "km.csv", row.names = F)

data <- read.csv("km.csv", header=TRUE, sep=",")
data

model <- kmeans(data, nstart=20, centers=3)
summary(model)

model$cluster
clusplot(data, model$cluster)

plot(data,  
     col = model$cluster,  
     main = "K-means with 3 clusters") 
## Plotiing cluster centers 
model$centers 
# cex is font size, pch is symbol 
points(model$centers, pch=4, col="blue")  
