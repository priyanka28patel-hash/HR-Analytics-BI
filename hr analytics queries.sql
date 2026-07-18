drop table if exists hr_data;


CREATE TABLE hr_data (
    Age INT,
    Attrition VARCHAR(10),
    BusinessTravel VARCHAR(50),
    DailyRate INT,
    Department VARCHAR(50),
    DistanceFromHome INT,
    Education INT,
    EducationField VARCHAR(50),
    EmployeeCount INT,
    EmployeeNumber INT,
    EnvironmentSatisfaction INT,
    Gender VARCHAR(20),
    HourlyRate INT,
    JobInvolvement INT,
    JobLevel INT,
    JobRole VARCHAR(100),
    JobSatisfaction INT,
    MaritalStatus VARCHAR(20),
    MonthlyIncome INT,
    MonthlyRate INT,
    NumCompaniesWorked INT,
    Over18 VARCHAR(5),
    OverTime VARCHAR(10),
    PercentSalaryHike INT,
    PerformanceRating INT,
    RelationshipSatisfaction INT,
    StandardHours INT,
    StockOptionLevel INT,
    TotalWorkingYears INT,
    TrainingTimesLastYear INT,
    WorkLifeBalance INT,
    YearsAtCompany INT,
    YearsInCurrentRole INT,
    YearsSinceLastPromotion INT,
    YearsWithCurrManager INT
);



----1. Total Employees
SELECT COUNT(*) AS total_employees
FROM hr_data;



---2. Total Employees Who Left
SELECT COUNT(*) AS total_attrition
FROM hr_data
WHERE attrition = 'Yes';



---3. Overall Attrition Rate
SELECT
ROUND(
    COUNT(CASE WHEN attrition='Yes' THEN 1 END) * 100.0 / COUNT(*),
    2
) AS attrition_rate
FROM hr_data;



---4. Average Monthly Income
SELECT
ROUND(AVG(monthlyincome),2) AS avg_monthly_income
FROM hr_data;



---5. Average Years at Company
SELECT
ROUND(AVG(yearsatcompany),2) AS avg_tenure
FROM hr_data;




---6. Department-wise Attrition
SELECT
department,
COUNT(*) AS attrition_count
FROM hr_data
WHERE attrition='Yes'
GROUP BY department
ORDER BY attrition_count DESC;




----7. Employee Count by Department
SELECT
department,
COUNT(*) AS total_employees
FROM hr_data
GROUP BY department
ORDER BY total_employees DESC;




---8. Job Role with Highest Attrition
SELECT
jobrole,
COUNT(*) AS attrition_count
FROM hr_data
WHERE attrition='Yes'
GROUP BY jobrole
ORDER BY attrition_count DESC;




----9. Average Salary by Job Role
SELECT
jobrole,
ROUND(AVG(monthlyincome),2) AS avg_salary
FROM hr_data
GROUP BY jobrole
ORDER BY avg_salary DESC;



----10. Attrition by Gender
SELECT
gender,
COUNT(*) AS attrition_count
FROM hr_data
WHERE attrition='Yes'
GROUP BY gender;



----11. Employee Count by Gender
SELECT
gender,
COUNT(*) AS employees
FROM hr_data
GROUP BY gender;





----12. Education Field-wise Attrition
SELECT
educationfield,
COUNT(*) AS attrition_count
FROM hr_data
WHERE attrition='Yes'
GROUP BY educationfield
ORDER BY attrition_count DESC;




----13. Overtime vs Attrition
SELECT
overtime,
COUNT(*) AS attrition_count
FROM hr_data
WHERE attrition='Yes'
GROUP BY overtime;




----14. Business Travel vs Attrition
SELECT
businesstravel,
COUNT(*) AS attrition_count
FROM hr_data
WHERE attrition='Yes'
GROUP BY businesstravel
ORDER BY attrition_count DESC;




----15. Attrition by Marital Status
SELECT
maritalstatus,
COUNT(*) AS attrition_count
FROM hr_data
WHERE attrition='Yes'
GROUP BY maritalstatus;




-----16. Employees by Age Group
SELECT
CASE
    WHEN age < 25 THEN 'Under 25'
    WHEN age BETWEEN 25 AND 34 THEN '25-34'
    WHEN age BETWEEN 35 AND 44 THEN '35-44'
    WHEN age BETWEEN 45 AND 54 THEN '45-54'
    ELSE 'Over 55'
END AS age_group,
COUNT(*) AS employees
FROM hr_data
GROUP BY age_group
ORDER BY age_group;




----17. Top 10 Highest Paid Employees
SELECT
employeenumber,
jobrole,
monthlyincome
FROM hr_data
ORDER BY monthlyincome DESC
LIMIT 10;




----18. Average Experience by Department
SELECT
department,
ROUND(AVG(totalworkingyears),2) AS avg_experience
FROM hr_data
GROUP BY department
ORDER BY avg_experience DESC;



----19.Attrition Rate by Department

SELECT
department,
COUNT(CASE WHEN attrition='Yes' THEN 1 END) AS attrition_count,
COUNT(*) AS total_employees,
ROUND(
COUNT(CASE WHEN attrition='Yes' THEN 1 END)*100.0/COUNT(*),2
) AS attrition_rate
FROM hr_data
GROUP BY department
ORDER BY attrition_rate DESC;

-----20.Highest Attrition Job Roles (Top 5).
SELECT
jobrole,
COUNT(*) AS attrition_count
FROM hr_data
WHERE attrition='Yes'
GROUP BY jobrole
ORDER BY attrition_count DESC
LIMIT 5;

----21.Rank Departments by Attrition
SELECT
department,
COUNT(*) AS attrition_count,
RANK() OVER(ORDER BY COUNT(*) DESC) AS department_rank
FROM hr_data
WHERE attrition='Yes'
GROUP BY department;




---22.Department with Above Average Salary
WITH dept_salary AS (
SELECT
department,
AVG(monthlyincome) AS avg_salary
FROM hr_data
GROUP BY department
)
SELECT *
FROM dept_salary
WHERE avg_salary >
(
SELECT AVG(monthlyincome)
FROM hr_data
);