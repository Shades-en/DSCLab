install.packages("dplyr")
install.packages("ggplot2")
library(dplyr)
library(ggplot2)

data <- data.frame( x=c(2,2,8,5,7,6,1,4,3),
                    y=c(10,5,4,8,5,4,2,9,9))

data
write.csv(data, "hclust.csv", row.names = F)

data <- read.table("hclust.csv", header=T, sep=",")
data

dm <- dist(data, method="euclidean")
hm <- hclust(dm, method="ward.D2")

summary(hm)

plot(hm)

rect.hclust(hm, k=3)

fit <- cutree(hm, k=3)
print(fit)
