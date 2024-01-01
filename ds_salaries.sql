#We begin by importing our data from a CSV file.
#We then take a look at our data to ensure it was imported correctly.
SELECT * FROM ds_salaries;

#Let's check our data types.
DESCRIBE ds_salaries;

#Let's correct some of our data types.
ALTER TABLE ds_salaries
MODIFY COLUMN work_year YEAR,  
MODIFY COLUMN experience_level VARCHAR(5), 
MODIFY COLUMN employment_type VARCHAR(5), 
MODIFY COLUMN job_title VARCHAR(100),  
MODIFY COLUMN salary INT,  
MODIFY COLUMN salary_currency VARCHAR(5), 
MODIFY COLUMN salary_in_usd INT,  
MODIFY COLUMN employee_residence VARCHAR(5),  
MODIFY COLUMN remote_ratio INT,  
MODIFY COLUMN company_location VARCHAR(5),  
MODIFY COLUMN company_size VARCHAR(5);  

#Check the updated data types.
DESCRIBE ds_salaries;

#add a primary key column named id
ALTER TABLE ds_salaries
ADD COLUMN id INT AUTO_INCREMENT PRIMARY KEY FIRST;

#Let's get some basic descriptive information.
#We'll take a look at salary ranges and Sandard deviation
SELECT MIN(salary_in_usd) AS min_salary,
       MAX(salary_in_usd) AS max_salary,
       AVG(salary_in_usd) AS avg_salary,
       STD(salary_in_usd) AS std_dev_salary
FROM ds_salaries;

#We look at how many experience levels there are in our data set and the frequency of each.
SELECT COUNT(DISTINCT experience_level) FROM ds_salaries;
SELECT experience_level, COUNT(*) AS frequency
FROM ds_salaries
GROUP BY experience_level
ORDER BY frequency DESC;

#We look at how many employment types there are in our data set and the frequency of each.
SELECT COUNT(DISTINCT employment_type) FROM ds_salaries;
SELECT employment_type, COUNT(*) AS frequency
FROM ds_salaries
GROUP BY employment_type
ORDER BY frequency DESC;

#We look at how many distinct job titles there are in our data set and the frequency of each.
SELECT COUNT(DISTINCT job_title) FROM ds_salaries;
SELECT job_title, COUNT(*) AS frequency
FROM ds_salaries
GROUP BY job_title
ORDER BY frequency DESC;

#We look at how many currancies there are in our data set and the frequency of each.
SELECT COUNT(DISTINCT salary_currency) FROM ds_salaries;
SELECT salary_currency, COUNT(*) AS frequency
FROM ds_salaries
GROUP BY salary_currency
ORDER BY frequency DESC;

#We look at how many employee residence locations there are in our data set and the frequency of each.
SELECT COUNT(DISTINCT employee_residence) FROM ds_salaries;
SELECT employee_residence, COUNT(*) AS frequency
FROM ds_salaries
GROUP BY employee_residence
ORDER BY frequency DESC;

#We look at how many distinct company locations there are in our data set and the frequency of each.
SELECT COUNT(DISTINCT company_location) FROM ds_salaries;
SELECT company_location, COUNT(*) AS frequency
FROM ds_salaries
GROUP BY company_location
ORDER BY frequency DESC;

#We look at how many distinct company sizes there are in our data set and the frequency of each.
SELECT COUNT(DISTINCT company_size) FROM ds_salaries;
SELECT company_size, COUNT(*) AS frequency
FROM ds_salaries
GROUP BY company_size
ORDER BY frequency DESC;

#Check for missing values
SELECT COUNT(*) - COUNT(work_year) AS missing_work_year FROM ds_salaries;
SELECT COUNT(*) - COUNT(experience_level) AS missing_experience_level FROM ds_salaries;
SELECT COUNT(*) - COUNT(employment_type) AS missing_employment_type FROM ds_salaries;
SELECT COUNT(*) - COUNT(job_title) AS missing_job_title FROM ds_salaries;
SELECT COUNT(*) - COUNT(salary) AS missing_salary FROM ds_salaries;
SELECT COUNT(*) - COUNT(salary_currency) AS missing_salary_currency FROM ds_salaries;
SELECT COUNT(*) - COUNT(salary_in_usd) AS missing_salary_in_usd FROM ds_salaries;
SELECT COUNT(*) - COUNT(employee_residence) AS missing_employee_residence FROM ds_salaries;
SELECT COUNT(*) - COUNT(remote_ratio) AS missing_remote_ratio FROM ds_salaries;
SELECT COUNT(*) - COUNT(company_location) AS missing_company_location FROM ds_salaries;
SELECT COUNT(*) - COUNT(company_size) AS missing_company_size FROM ds_salaries;
#It appears this data set has no missing values 

#Let's find the average salary by experience level
SELECT experience_level, 
AVG(salary_in_usd) AS average_salary
FROM ds_salaries
GROUP BY experience_level
ORDER BY average_salary DESC;

#Now average salary by job title
SELECT job_title,
AVG(salary_in_usd) AS average_salary
FROM ds_salaries
GROUP BY job_title
ORDER BY average_salary DESC;

#Average salary by job title, only US
SELECT job_title,
    AVG(salary_in_usd) AS average_salary,
    STD(salary_in_usd) AS salary_std_dev,
    COUNT(job_title) AS title_count
FROM ds_salaries
WHERE company_location = 'US' AND employee_residence = 'US'
GROUP BY job_title
ORDER BY average_salary DESC;

#Most common entry level job tittles
SELECT job_title,
	COUNT(*) AS frequency
FROM ds_salaries
WHERE experience_level = 'EN'  
GROUP BY job_title
ORDER BY frequency DESC;
    
#Job tittle by avg remote ratio
SELECT job_title,
AVG(remote_ratio) AS average_remote_ratio
FROM ds_salaries
GROUP BY job_title
ORDER BY average_remote_ratio DESC;

#Salary distribution by experience
SELECT experience_level, MIN(salary_in_usd) AS min_salary, 
AVG(salary_in_usd) AS avg_salary, MAX(salary_in_usd) AS max_salary, 
STD(salary_in_usd) AS std_deviation
FROM ds_salaries
GROUP BY experience_level
ORDER BY avg_salary DESC;

#Average salary by company size
SELECT company_size, 
AVG(salary_in_usd) AS avg_salary, 
STD(salary_in_usd) AS salary_std_dev
FROM ds_salaries
GROUP BY company_size
ORDER BY avg_salary DESC;

#Top ten jobs with highest salary
SELECT *
FROM ds_salaries
ORDER BY salary_in_usd DESC
LIMIT 10;