rm(list = ls())
library(ggplot2)
library(corrgram)
library(gridExtra)
library(naniar)
library(dplyr)
library(randomForest)
library(xgboost)
library(rpart)
library(e1071)
library(Metrics)
#library(caret)

salary_df <- read.csv("Engineering_graduate_salary.csv")

#cat(summary(salary_df))

#visualizing outliers in the salary
plot1 <- ggplot(data = salary_df, aes(y = Salary)) + geom_boxplot() + scale_y_continuous(limits = c(0, 1000000))

print(plot1)

plot2 <- ggplot(data = salary_df, aes(x = openess_to_experience,y = Salary)) + geom_point() +  scale_y_continuous(limits = c(0, 1000000))

print(plot2)

salary_df_num <- salary_df[ ,c(13, 17:34)]
r <- cor(salary_df_num)
print(r)
print(corrgram(salary_df_num, order = TRUE,upper.panel = panel.cor))


## Get outliers
out_salary <- boxplot.stats(salary_df_num$Salary)$out

## Get index of outliers
out_idx <- which(salary_df_num$Salary %in% c(out_salary))

## remove outlier
salary_df_num <- salary_df_num[ -out_idx,]
plot3 <- boxplot.stats(salary_df_num$Salary)
print(plot3)


#Change NA to Mean (Domain)
salary_df_num$Domain[salary_df_num$Domain==-1]=NA
## get index of NAs
idx_na_d <- which(is.na(salary_df_num$Domain))
## compute mean
mean_d <- mean(salary_df_num$Domain, na.rm = TRUE)
## input NAs with mean
salary_df_num$Domain[ idx_na_d ] <- mean_d


#Change NA to Mean (ComputerProgramming) 2
salary_df_num$ComputerProgramming[salary_df_num$ComputerProgramming==-1]=NA
## get index of NAs
idx_na_cp <- which(is.na(salary_df_num$ComputerProgramming))
## compute mean
mean_cp <- mean(salary_df_num$ComputerProgramming, na.rm = TRUE)
## input NAs with mean
salary_df_num$ComputerProgramming[ idx_na_cp ] <- mean_cp


#Change NA to Mean (ElectronicsAndSemicon) 3
salary_df_num$ElectronicsAndSemicon[salary_df_num$ElectronicsAndSemicon==-1]=NA 
## get index of NAs
idx_na_electro <- which(is.na(salary_df_num$ElectronicsAndSemicon))
## compute mean
mean_electro <- mean(salary_df_num$ElectronicsAndSemicon, na.rm = TRUE)
## input NAs with mean
salary_df_num$ElectronicsAndSemicon[ idx_na_electro ] <- mean_electro


#Change NA to Mean (Computer Science) 4
salary_df_num$ComputerScience[salary_df_num$ComputerScience==-1]=NA
## get index of NAs
idx_na_cmptr <- which(is.na(salary_df_num$ComputerScience))
## compute mean
mean_cmptr <- mean(salary_df_num$ComputerScience, na.rm = TRUE)
## input NAs with mean
salary_df_num$ComputerScience[ idx_na_cmptr ] <- mean_cmptr


#Change NA to Mean (MechanicalEngg) 5
salary_df_num$MechanicalEngg[salary_df_num$MechanicalEngg==-1]=NA
## get index of NAs
idx_na_me <- which(is.na(salary_df_num$MechanicalEngg))
## compute mean
mean_me <- mean(salary_df_num$MechanicalEngg, na.rm = TRUE)
## input NAs with mean
salary_df_num$MechanicalEngg[ idx_na_me ] <- mean_me


#Change NA to Mean (ElectricalEngg) 6
salary_df_num$ElectricalEngg[salary_df_num$ElectricalEngg==-1]=NA
## get index of NAs
idx_na_ee <- which(is.na(salary_df_num$ElectricalEngg))
## compute mean
mean_ee <- mean(salary_df_num$ElectricalEngg, na.rm = TRUE)
## input NAs with mean
salary_df_num$ElectricalEngg[ idx_na_ee ] <- mean_ee


#Change NA to Mean (TelecomEngg) 7
salary_df_num$TelecomEngg[salary_df_num$TelecomEngg==-1]=NA
## get index of NAs
idx_na_te <- which(is.na(salary_df_num$TelecomEngg))
## compute mean
mean_te <- mean(salary_df_num$TelecomEngg, na.rm = TRUE)
## input NAs with mean
salary_df_num$TelecomEngg[ idx_na_te ] <- mean_te


#Change NA to Mean (CivilEngg) 8
salary_df_num$CivilEngg[salary_df_num$CivilEngg==-1]=NA
## get index of NAs
idx_na_ce <- which(is.na(salary_df_num$CivilEngg))
## compute mean
mean_ce <- mean(salary_df_num$CivilEngg, na.rm = TRUE)
## input NAs with mean
salary_df_num$CivilEngg[ idx_na_ce ] <- mean_ce



salary_df$ID <- NULL
salary_df$DOB <- NULL


print(dim(salary_df_num))

set.seed(2021)
m <- nrow(salary_df_num)
print(m)
m_train <- m * 0.7

train_idx <- sample(m, m_train)
train_df <- salary_df_num[ train_idx, ]
test_df <- salary_df_num[ -train_idx, ] 

###SIMPLE LINEAR REGRESSION
model.slr <- lm(formula = Salary ~ openess_to_experience,data = train_df)
print(summary(model.slr))

model.slr2 <- lm(formula = Salary ~ agreeableness,data = train_df)
print(summary(model.slr2))

model.slr3 <- lm(formula = Salary ~ Quant,data = train_df)
print(summary(model.slr3))


###Polynomial Regression
model.poly <- lm(formula = Salary ~ openess_to_experience + I(openess_to_experience^2),data = train_df)
summary(model.poly)


###MLR
model.mlr1 <- lm(formula = Salary ~ openess_to_experience + agreeableness + extraversion + Quant + Logical + English + ComputerScience + ElectronicsAndSemicon + TelecomEngg + MechanicalEngg + ComputerProgramming + ElectricalEngg + CivilEngg + conscientiousness + extraversion + nueroticism + Domain,data = train_df)
print(summary(model.mlr1))


###MLR with Interaction
model.int <- lm(formula = Salary ~ openess_to_experience + agreeableness + openess_to_experience:agreeableness,data = train_df)
print(summary(model.int))


###PROPOSED MODEL
mymodel <- lm(formula = Salary ~ openess_to_experience + agreeableness + Quant + I(openess_to_experience^2) + I(agreeableness^2) + I(Quant^2) + openess_to_experience:agreeableness + openess_to_experience:Quant + agreeableness:Quant,
              data = train_df)
print(summary(mymodel))


##Actual value from test data
actual <- test_df$Salary
## Predicted values using SLR model
pred.slr <- predict(model.slr, test_df)
pred.slr2 <- predict(model.slr2, test_df)
pred.slr3 <- predict(model.slr3, test_df)
pred.poly <- predict(model.poly, test_df)
pred.mlr1 <- predict(model.mlr1, test_df)
pred.int <- predict(model.int, test_df)
pred.mymodel <- predict(mymodel, test_df)
## create dataframe for actual and prediction values
prediction_df <- data.frame(actual, pred.slr, pred.slr2, pred.slr3,pred.poly, pred.mlr1, pred.int, pred.mymodel)

perform<-function(model){
  mse = mse(actual,model)
  mae = mae(actual,model)
  rmse = rmse(actual,model)
  r2 = R2(actual,model, form = "traditional")
  cat(" MAE:", mae, "\n", "MSE:", mse, "\n", 
      "RMSE:", rmse, "\n", "R-squared:", r2)
}
performance <- function(actual, predicted, model){
  # Root Mean Square Error (RMSE)
  e <- predicted - actual 
  se <- e^2 # square error
  sse <- sum(se) # sum of square error
  mse <- mean(se) # mean squared error
  rmse <- sqrt(mse) # root mean squared error
  
  r <- cor(predicted, actual)
  
  result <- paste("=== Model: ", model,"\nRoot Mean Squared Error (RMSE): ", round(rmse, 2), "\nCorrelation Coefficient (R): ", round(r,5), "\n\n")
  cat(result)
  #return (rmse)
}

## changes----
model_mlr <- lm(formula = Salary ~.,data = train_df)
print(summary(model_mlr))
a<-predict(model_mlr,test_df)
perform(a)

rf <- randomForest(Salary ~ .,data=train_df,ntree=1000,importance=TRUE)
print(rf)
b<-predict(rf,test_df)
perform(b)

svm <- svm(Salary~., kernel="radial", data=train_df)
print(svm)
c<-predict(svm,test_df)
perform(c)

dt<- rpart(Salary~., method = "anova", data = train_df)
print(dt)
d<-predict(dt, train_df, method = "anova")
perform(d)

xgb <-
  xgboost(
    data =data.matrix(train_df[, -1]),
    label = train_df[, 1],
    nrounds = 1000,
    objective = "reg:squarederror",
    early_stopping_rounds = 3,
    max_depth = 6,
    eta = .25
  )

e<- predict(xgb,data.matrix(test_df[, -1]))
perform(e)


performance(actual, pred.slr, "Single Regression Openess_to_experience")

performance(actual, pred.slr2, "Single Regression agreeableness")

performance(actual, pred.slr3, "Single Regression Quant")

performance(actual, pred.poly, "Polynominal Regression")

performance(actual, pred.mlr1, "Multivariate Regression")

performance(actual, pred.int, "Multivariate Intersaction")

performance(actual, pred.mymodel, "Proposed Model")



###Principal Component Analysis (PCA)
pr.out <- prcomp(salary_df_num, scale = TRUE)
names(pr.out)

## Variant Explained
sdev <- pr.out$sdev
ve <- sdev ^ 2
print(ve)

## Proportion of Variance Explained (PVE)
pve <- ve / sum(ve)
print(pve)

plot(pve,xlab = "Principal Component",ylab = "PVE",type = "b",ylim = c(0,1))

plot(cumsum(pve),xlab = "Principal Component",ylab = "Cumulative PVE",type = "b",ylim = c(0,1))


k <- 15
features_df <- pr.out$x[ , 1:k] 
features_df <- data.frame( features_df )
print(pve)
cumsum(pve)

### combine features and target
salary_pca_df <- cbind( salary_df_num$Salary, features_df)
colnames(salary_pca_df)[1] <- "salary"
# for reproducible result
set.seed(2021)
## PCA
m <- nrow(salary_pca_df)
print(m)

m_train <- m * 0.7

train_idx <- sample(m, m_train)

train_pca_df <- salary_pca_df[ train_idx, ] 
test_pca_df <- salary_pca_df[ -train_idx, ] 


model.slr_pca <- lm(formula = salary ~ .,data = train_pca_df)
print(summary(model.slr_pca))

pred.slr_pca <- predict(model.slr_pca, test_pca_df)
performance(actual, pred.slr_pca, "LR PCA")


## Create dataframe PCA
prediction_df_pca <- data.frame(pred.slr_pca)


## Visualize PCA
pca <- ggplot(data = prediction_df_pca,aes(x=actual,y=pred.slr_pca)) + geom_point() + geom_smooth() + scale_x_continuous(limits = c(0, 750000), breaks = c(250000, 500000, 750000), labels = c("250000INR", "500000INR", "$750000INR")) + scale_y_continuous(limits = c(0, 750000), breaks = c(250000, 500000, 750000), labels = c("250000INR", "500000INR", "$750000INR")) + labs(title = "PCA Visualize")
print(pca)


#random forest
model.rf_pca <- randomForest(formula = salary ~ .,
                             data = train_pca_df)
print(summary(model.rf_pca))

pred.rf_pca <- predict(model.rf_pca, test_pca_df)
performance(actual, pred.rf_pca, "RF PCA")


## Create dataframe PCA
prediction_df_pca <- data.frame(pred.rf_pca)


## Visualize PCA
pca <- ggplot(data = prediction_df_pca,aes(x=actual,y=pred.rf_pca)) + geom_point() + geom_smooth() + scale_x_continuous(limits = c(0, 750000), breaks = c(250000, 500000, 750000), labels = c("250000INR", "500000INR", "$750000INR")) + scale_y_continuous(limits = c(0, 750000), breaks = c(250000, 500000, 750000), labels = c("250000INR", "500000INR", "$750000INR")) + labs(title = "PCA Visualize")
print(pca)

rss <- sum((pred.rf_pca - actual) ^ 2)
tss <- sum((actual - mean(actual)) ^ 2)
rsq <- 1 - rss/tss
print(rsq)


###decision trees
set.seed(1234)

model.dt_pca <- rpart(formula = salary ~ .,data = train_pca_df, method='anova')
print(summary(model.dt_pca))

pred.dt_pca <- predict(model.dt_pca, test_pca_df)
performance(actual, pred.dt_pca, "DT PCA")


## Create dataframe PCA
prediction_df_pca <- data.frame(pred.dt_pca)


## Visualize PCA
pca <- ggplot(data = prediction_df_pca,aes(x=actual,y=pred.dt_pca)) + geom_point() + geom_smooth() + scale_x_continuous(limits = c(0, 750000), breaks = c(250000, 500000, 750000), labels = c("250000INR", "500000INR", "$750000INR")) + scale_y_continuous(limits = c(0, 750000), breaks = c(250000, 500000, 750000), labels = c("250000INR", "500000INR", "$750000INR")) + labs(title = "PCA Visualize")
print(pca)

rss <- sum((pred.dt_pca - actual) ^ 2)
tss <- sum((actual - mean(actual)) ^ 2)
rsq <- 1 - rss/tss
print(rsq)

##SVM PCA
modl<-svm(salary~., kernel='radial',data=train_pca_df)
pred.svm_pca <- predict(modl, test_pca_df)
print(summary(modl))
performance(actual, pred.svm_pca, "SVM PCA")

## Create dataframe PCA
prediction_df_pca <- data.frame(pred.dt_pca)
rss <- sum((pred.svm_pca - actual) ^ 2)
tss <- sum((actual - mean(actual)) ^ 2)
rsq <- 1 - rss/tss
print(rsq)
pca <- ggplot(data = prediction_df_pca,aes(x=actual,y=pred.svm_pca)) + geom_point() + geom_smooth() + scale_x_continuous(limits = c(0, 750000), breaks = c(250000, 500000, 750000), labels = c("250000INR", "500000INR", "$750000INR")) + scale_y_continuous(limits = c(0, 750000), breaks = c(250000, 500000, 750000), labels = c("250000INR", "500000INR", "$750000INR")) + labs(title = "PCA Visualize")
print(pca)

