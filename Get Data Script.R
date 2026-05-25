install.packages("insuranceData")
library(insuranceData)
data(dataCar)
write.csv(dataCar, "dataCar.csv", row.names = FALSE)

