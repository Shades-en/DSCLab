install.packages("arules")
install.packages("arulesViz")
library(arules)
library(arulesViz)

data <- read.transactions("Market_Basket_Optimisation.csv", sep=',', rm.duplicates = T)
str(data)

rules = apriori(data, parameter=list(confidence=0.7, support=0.0004))

itemFrequencyPlot(data, topN=10)

inspect(sort(rules, by="lift")[1:10])
new_rules <-sort(rules, by="lift")[1:10]

plot(new_rules, method="graph", measure="confidence", shading="lift")
