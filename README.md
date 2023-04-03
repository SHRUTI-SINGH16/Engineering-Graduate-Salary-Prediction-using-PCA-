# Engineering Graduate Salary Prediction using Principal Component Analysis (PCA)




## Dataset Description - 
Dataset Selection plays a significant role in what type of algorithm should be used where it can be supervised, unsupervised or semi-supervised as well as the quantity of valid records and attributes must be taken into account when selecting or importing datasets. The supervised technique is used in this paper on a dataset from Kaggle consisting of 2998 records and 34 attributes out of which 19 appropriate attributes have been selected. The number of records and attributes chosen from the dataset were substantial enough to allow for the development of an efficient model and forecast a conveniently wider spectrum of options. The dataset is saved in CSV format and its dataset's qualities are logical and competent, allowing for a precise and efficient forecast of an engineering graduate's salary. 
<br>
### Attributes of the dataset - 
* ID: A unique ID to identify a candidate
* Salary: Annual CTC offered to the candidate (in INR)
* Gender: Candidate's gender
* DOB: Date of birth of the candidate
* 10percentage: Overall marks obtained in grade 10 examinations
* 10board: The school board whose curriculum the candidate followed in grade 10
* 12graduation: Year of graduation - senior year high school
* 12percentage: Overall marks obtained in grade 12 examinations
* 12board: The school board whose curriculum the candidate followed
* CollegeID: Unique ID identifying the university/college which the candidate attended for her/his undergraduate
* CollegeTier: Each college has been annotated as 1 or 2. The annotations have been computed from the average AMCAT scores obtained by the students in the college/university. Colleges with an average score above a threshold are tagged as 1 and others as 2.
* Degree: Degree obtained/pursued by the candidate
* Specialization: Specialization pursued by the candidate
* CollegeGPA: Aggregate GPA at graduation
* CollegeCityID: A unique ID to identify the city in which the college is located in.
* CollegeCityTier: The tier of the city in which the college is located in. This is annotated based on the population of the cities.
* CollegeState: Name of the state in which the college is located
* GraduationYear: Year of graduation (Bachelor's degree)
* English: Scores in AMCAT English section
* Logical: Score in AMCAT Logical ability section
* Quant: Score in AMCAT's Quantitative ability section
* Domain: Scores in AMCAT's domain module
* ComputerProgramming: Score in AMCAT's Computer programming section
* ElectronicsAndSemicon: Score in AMCAT's Electronics & Semiconductor Engineering section
* ComputerScience: Score in AMCAT's Computer Science section
* MechanicalEngg: Score in AMCAT's Mechanical Engineering section
* ElectricalEngg: Score in AMCAT's Electrical Engineering section
* TelecomEngg: Score in AMCAT's Telecommunication Engineering section
* CivilEngg: Score in AMCAT's Civil Engineering section
* conscientiousness: Scores in one of the sections of AMCAT's personality test
* agreeableness: Scores in one of the sections of AMCAT's personality test
* extraversion: Scores in one of the sections of AMCAT's personality test
* nueroticism: Scores in one of the sections of AMCAT's personality test
* openess_to_experience: Scores in one of the sections of AMCAT's personality test
<br>
Link of dataset - https://www.kaggle.com/datasets/manishkc06/engineering-graduate-salary-prediction

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
Among the five algorithms that were applied, the performance of Support Vector Machine (SVM) Regression was found to be the best with R-square value as 0.9350692 and root mean square error (RMSE) 29929.55.
The performance order of different algorithms starting with the best results on our dataset is as follows: Support Vector Machine(SVM), Xgboost, Random Forest, Linear Regression, Decision Tree.
Hence we conclude for the given dataset Support Vector Machine(SVM) and Xgboost are the best algorithms to apply.
