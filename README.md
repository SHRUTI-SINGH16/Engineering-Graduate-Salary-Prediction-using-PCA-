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
