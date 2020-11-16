# Preliminaries
#-------------------------------------------------
rm(list = ls())
setwd("[SET YOUR WORKING DIRECTORY]")

#-------Difference in Difference-------
fastfood <- read.csv('fastfood.csv')
#Question 1 - 5
model1 <- lm(empft ~ state, data = fastfood)
model2 <- lm(emppt ~ state, data = fastfood)
model3 <- lm(wage_st ~ state, data = fastfood)
summary(model1) #gives output for Question 1
summary(model2) 
summary(model3) #gives output for Question 3
4.62863 - 0.02123 #Question 4

#Question 9
fastfood$diff_empft <- fastfood$empft2-fastfood$empft
model5 <- lm(diff_empft ~ state, data = fastfood)
summary(model5)

#-------Regression Discontinuity-------
install.packages("rdd")
library(rdd)
indiv <- read.csv('indiv_final.csv')
#Question 11
#Note: there are many ways to do this
indiv$dummy <- as.numeric(data$difshare > 0)
summary(indiv$dummy) 

#Question 12-13
DCdensity(indiv$difshare, 0, ext.out=TRUE)

#Question 14-15
#Parametric Regression
matrix_coef <- matrix(NA, nrow = 2, ncol = 11)

model <- lm(myoutcomenext ~ above, data = indiv, subset = abs(difshare) <= 0.5)
matrix_coef[1, 1] <- model$coefficients[2]
pvalue <- summary(model)
matrix_coef[2, 1] <- pvalue$coefficients[2, 4]

model <- lm(myoutcomenext ~ above + X1, data = indiv, subset = abs(difshare) <= 0.5)
matrix_coef[1, 2] <- model$coefficients[2]
pvalue <- summary(model)
matrix_coef[2, 2] <- pvalue$coefficients[2, 4]

model <- lm(myoutcomenext ~ above + X1 + X4, data = indiv, subset = abs(difshare) <= 0.5)
matrix_coef[1, 3] <- model$coefficients[2]
pvalue <- summary(model)
matrix_coef[2, 3] <- pvalue$coefficients[2, 4]

model <- lm(myoutcomenext ~ above + X1 + X2, data = indiv, subset = abs(difshare) <= 0.5)
matrix_coef[1, 4] <- model$coefficients[2]
pvalue <- summary(model)
matrix_coef[2, 4] <- pvalue$coefficients[2, 4]

model <- lm(myoutcomenext ~ above + X1 + X2 + X4 + X5, data = indiv, 
            subset = abs(difshare) <= 0.5)
matrix_coef[1, 5] <- model$coefficients[2]
pvalue <- summary(model)
matrix_coef[2, 5] <- pvalue$coefficients[2, 4]

model <- lm(myoutcomenext ~ above + X1 + X2 + X3, data = indiv, 
            subset = abs(difshare) <= 0.5)
matrix_coef[1, 6] <- model$coefficients[2]
pvalue <- summary(model)
matrix_coef[2, 6] <- pvalue$coefficients[2, 4]

model <- lm(myoutcomenext ~ above + X1 + X2 + X3 + X4 + X5 + X6, data = indiv, 
            subset = abs(difshare) <= 0.5)
matrix_coef[1, 7] <- model$coefficients[2]
pvalue <- summary(model)
matrix_coef[2, 7] <- pvalue$coefficients[2, 4]

matrix_coef

#Question 16-17
model <- RDestimate(myoutcomenext~difshare, data=indiv, subset = abs(indiv$difshare) <=0.5)
summary(model)

#Question 18
#Plot A
model1 <- RDestimate(myoutcomenext ~ difshare, data = indiv, subset = abs(indiv$difshare) <=0.5)
plot(model1)
#Plot B
model2 <- RDestimate(myoutcomenext ~ difshare, data = indiv, subset=abs(indiv$difshare) <=0.5,
                     kernel = "rectangular", bw = 3)
plot(model2)
#Plot C
model3 <- RDestimate(myoutcomenext ~ difshare, data = indiv, subset=abs(indiv$difshare) <=0.5,
                     kernel = "rectangular", bw = (1/3))
plot(model3)