# Engineering Graduate Salary Prediction using Principal Component Analysis (PCA)




## Dataset Description - 
Dataset Selection plays a significant role in what type of algorithm should be used where it can be supervised, unsupervised or semi-supervised as well as the quantity of valid records and attributes must be taken into account when selecting or importing datasets. The supervised technique is used in this paper on a dataset from Kaggle consisting of 2998 records and 34 attributes out of which 19 appropriate attributes have been selected. The number of records and attributes chosen from the dataset were substantial enough to allow for the development of an efficient model and forecast a conveniently wider spectrum of options. The dataset is saved in CSV format and its dataset's qualities are logical and competent, allowing for a precise and efficient forecast of an engineering graduate's salary. 
<br>
### Attributes of the dataset - 

|Name of the Attribute| Type |Categories|
| ------------- | ------------- | ------------- |
|CollegeGPA |num |73.8 65 61.9 80.4 64.3 ...|
|GraduationYear |int |2013 2014 2011 2013 2012|
|English |int| 650 440 485 675 575|
|Logical| int |665 435 475 620 495 595|
|Quant |int| 810 210 505 635 365 620|
|Domain| num |0.694 0.342 0.825 0.99 0.278 ...|
|ComputerProgramming| int |485 365 -1 655 315 455 -1 465 525 385 ...|
|ElectronicsAndSemicon |int| 366 -1 400 -1 -1 300 -1 -1 -1 -1 ...|
|ComputerScience| int| -1 -1 -1 -1 -1 -1 -1 -1 438 407 ...|
|MechanicalEngg |int |-1 -1 -1 -1 -1 -1 469 -1 -1 -1 ...|
|ElectricalEngg |int |-1 -1 -1 -1 -1 -1 -1 -1 -1 -1 ...|
|TelecomEngg |int| -1 -1 260 -1 -1 313 -1 -1 -1 -1 ...|
|CivilEngg| int |-1 -1 -1 -1 -1 -1 -1 -1 -1 -1 ...|
|conscientiousness| num |-0.159 1.134 0.51 -0.446 ...|
|agreeableness| num |0.3789 0.0459 -0.7473 ...|
|extraversion| num| 1.24 1.24 1.543 0.317 -1.07 ...|
|neuroticism| num| 0.1459 0.2727 0.0622 ...|
|openess_to_experience| num| 0.289 -0.286 0.48 0.186 ...|
|Salary| int| 445000, 110000, 255000 ….|
<br>
Link of dataset - https://www.kaggle.com/datasets/manishkc06/engineering-graduate-salary-prediction

## Workflow
<img src="https://user-images.githubusercontent.com/91374600/229491092-d8e70e80-bd4c-48f8-9df9-d87c60c6c7dd.png" data-canonical-src="https://gyazo.com/eb5c5741b6a9a16c692170a41a49c858.png" width="600"/>

## Dataset Pre-processing
## A. Data Cleaning
The data cleaning method entails finding the data, extracting it, cleaning it, and integrating it into a dataset that can be analyzed as per requirements.


### 1. Visualizing and Removing Outliers in the Salary
On visualizing the data, outliers were discovered in the salary column of the dataset which had to be eliminated since they decrease the correlation by scattering the data and causing R2 to approach zero. As a result, the salary column outliers were removed using their index positions to enhance the R2 value. 

```R
##visualizing the outliers
plot1 <- ggplot(data = salary_df, aes(y = Salary)) + geom_boxplot() + scale_y_continuous(limits = c(0, 1000000))
```
<img src="https://user-images.githubusercontent.com/91374600/229492914-686fafef-470a-4d84-b33d-de8e93ca7d73.png" data-canonical-src="https://gyazo.com/eb5c5741b6a9a16c692170a41a49c858.png" width="600"/>

```R
## Get outliers
out_salary <- boxplot.stats(salary_df_num$Salary)$out

## Get index of outliers
out_idx <- which(salary_df_num$Salary %in% c(out_salary))

## Remove outlier
salary_df_num <- salary_df_num[ -out_idx,]
```



### 2. Corrgram 
It allows to analyse the relationship between each pair of numeric variables in a dataset.

<img src="https://user-images.githubusercontent.com/91374600/229493433-172a77cc-e311-4a52-b8f3-65f06977362a.png" data-canonical-src="https://gyazo.com/eb5c5741b6a9a16c692170a41a49c858.png" width="600"/>


### 3. Imputing the NA values
In the bulk of the dataset, -1 values were likewise a key source of interference since they resemble empty entries hence had to be eliminated too. As part of the data cleansing process, all -1 values in the selected attributes were converted to NA values, which were then subsequently replaced by the mean values of the corresponding columns.

This procedure was done on 8 attributes namely Domain, ComputerProgramming, ElectronicsAndSemicon, Computer Science, MechanicalEngg, ElectricalEngg, TelecomEngg and CivilEngg.

```R
#Change NA to Mean (Domain)
salary_df_num$Domain[salary_df_num$Domain==-1]=NA

## get index of NAs
idx_na_d <- which(is.na(salary_df_num$Domain))

## compute mean
mean_d <- mean(salary_df_num$Domain, na.rm = TRUE)

## input NAs with mean
salary_df_num$Domain[ idx_na_d ] <- mean_d
```

After all the data cleaning the number of records remaing were 2920 along with 19 attributes.


## B. Principal Component Analysis

Principal components analysis (PCA) is used for the dimension reduction of data and helps in determining the most significant features in the dataset through a statistical approach. It ensures minimum loss of information and increases the interpretability of the data. Principal components are the orthogonal projections which map a data having high dimension onto a low dimensional space. Thus, a principal component represents a line that encapsulates the majority of the data variance such that the first principal component captures most of the variance and for the *i*th principal component contribution decreases as the *i* value increases.
<br>
<br>
Firstly, The raw data matrix X<sub>R</sub> with 19 features is centered to the mean, then the centered data matrix X is used to compute the covariance matrix C which is given as, 
<img src="https://user-images.githubusercontent.com/91374600/229578165-f9f51788-c446-4fe8-97ad-a646e0399e0c.png" data-canonical-src="https://gyazo.com/eb5c5741b6a9a16c692170a41a49c858.png" width="60"/>


## Results
The results obtained after application of various machine learning algorithms on the columns before and after preprocessing are depicted in the form of a line chart where the black line represents the actual values.

<img src="https://user-images.githubusercontent.com/91374600/229485210-17bb904b-65a2-4b67-bca0-db5bea944d94.png" data-canonical-src="https://gyazo.com/eb5c5741b6a9a16c692170a41a49c858.png" width="600"/>

From the above line chart it can be seen that none of the algorithms performed up to the mark and hence the PCA was applied in order to improve the results. The line chart is as follows:

<img src="https://user-images.githubusercontent.com/91374600/229486206-5260dfae-7a0d-4687-9ade-d0dc9079b06a.png" data-canonical-src="https://gyazo.com/eb5c5741b6a9a16c692170a41a49c858.png" width="600"/>

The green line represents the SVM predictions. The green line is the closest to the black line. This indicates that SVM predictions are closer to the actual predictions when compared to other models’ predictions. Hence the accuracy of prediction was increased after applying PCA .

The results of machine learning algorithms on these modified columns are

| Algorithm     | MAE           |  RMSE         | R-Square      |
| ------------- | ------------- | ------------- | ------------- |
| Linear Regression | 18997  |  104348.5 | 0.5875523 |
| SVM |19405.87| 29929.55 |0.9350692|
|Xgboost |26151.12 |34827.99 |0.9138152|
|Random Forest| 32130.12 |42319.56| 0.8275663|
|Decision Tree |60571.13 |77397.29 |0.5008397|

After comparing the results the best R-squared value of 0.9350692 was obtained by applying the Support Vector Machine(SVM) Regression. The following is the graph of
the comparison:

<img src="https://user-images.githubusercontent.com/91374600/229487719-478d97ba-773b-43b9-ba53-46fdef535194.png" data-canonical-src="https://gyazo.com/eb5c5741b6a9a16c692170a41a49c858.png" width="600"/>

In the above chart the values of respective columns have been scaled between a range from 0 to 125 for a proper view of the graph representing comparison.

## Conclusion
Various algorithms have been applied on the data so as to get the best possible results. Firstly the data was preprocessed by imputing null values with the mean values and all the unnecessary columns were removed. Then the correlation between the variables were found and those variables which are highly correlated were
removed and then different algorithms were applied. However, the obtained results were not satisfactory. Hence, finally the concept of Principal components analysis (PCA) was used and the principal components for the data were found. Total 19 principal components were obtained. Out of theses 19 principal components, 15 principal components were selected whose cumulative value of variance explained for the respective PCs is less than the threshold value 0.93 Then the algorithms were again applied on this modified data which in turned improved the results.
<br>
<br>
Among the five algorithms that were applied, the performance of Support Vector Machine (SVM) Regression was found to be the best with R-square value as 0.9350692 and root mean square error (RMSE) 29929.55.
<br>
<br>
The performance order of different algorithms starting with the best results on our dataset is as follows: Support Vector Machine(SVM), Xgboost, Random Forest, Linear Regression, Decision Tree.
<br>
<br>
Hence we conclude for the given dataset Support Vector Machine(SVM) and Xgboost are the best algorithms to apply.
