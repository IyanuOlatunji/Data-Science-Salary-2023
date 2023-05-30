select * from Project1..ds_salaries

--What is the average data science salary in 2023?
SELECT AVG(salary_in_usd) Average_salary2023
FROM Project1..ds_salaries
WHERE work_year = '2023';

--What is the median data science salary in 2023?
WITH cte as (SELECT salary_in_usd, ROW_NUMBER() OVER (ORDER BY salary_in_usd) AS row_num,
           COUNT(*) OVER () AS total_rows
    FROM Project1..ds_salaries where work_year = '2023'
)
SELECT avg(salary_in_usd) as median_salary
FROM cte
WHERE row_num IN ((total_rows + 1) / 2, (total_rows + 2) / 2);

-- What is the highest and lowest salary in the dataset?
SELECT MAX(salary_in_usd) as Highest_salary, MIN(salary_in_usd) as Lowest_salary
FROM Project1..ds_salaries;

--Which region paid the highest salaries?
SELECT TOP 5 company_location, SUM(salary_in_usd) AS Total_Salary
FROM Project1..ds_salaries
WHERE work_year = '2023'
GROUP BY company_location
ORDER BY Total_Salary desc;

--Which region has the most data science jobs?
SELECT TOP 5 company_location, COUNT(job_title) Total_Jobs
FROM Project1..ds_salaries
WHERE work_year = '2023'
GROUP BY company_location
ORDER BY Total_Jobs desc

--What is the average salary for data scientists with different levels of experience?
SELECT experience_level, COUNT(experience_level) AS exlevel, AVG(salary_in_usd) Avg_salary
FROM Project1..ds_salaries
WHERE work_year = '2023'
GROUP BY experience_level
ORDER BY avg_salary DESC;

--Which job titles have the highest salaries?
SELECT TOP 3 job_title, SUM(salary_in_usd) AS Total_Salary, COUNT(job_title) AS Total_no
FROM Project1..ds_salaries
WHERE work_year = '2023'
GROUP BY job_title
ORDER BY Total_Salary DESC;

--How does company size affect salaries for data science roles?
SELECT company_size, SUM(salary_in_usd) AS total_sal, AVG(salary_in_usd) AS avg_sal, COUNT(job_title)AS Total_jobs
FROM Project1..ds_salaries
WHERE work_year = '2023'
GROUP BY company_size
ORDER BY total_sal DESC;

--Total number of job title
SELECT COUNT(DISTINCT job_title) AS Total_no_of_jobs
FROM Project1..ds_salaries;

--Total jobs by remote_ratio
SELECT remote_ratio, COUNT(job_title) AS Total_jobs, 
CASE WHEN remote_ratio = 0 THEN 'Onsite'
     WHEN remote_ratio = 50 THEN 'Hybrid'
	 WHEN remote_ratio = 100 THEN 'Fully Remote'
ELSE 'N/A'
END AS Remote_type
FROM Project1..ds_salaries
WHERE work_year = '2023'
GROUP BY remote_ratio

--Total number of jobs per employment type
SELECT employment_type, COUNT(DISTINCT job_title) AS Total_no_of_jobs
FROM Project1..ds_salaries
WHERE work_year = '2023'
GROUP BY employment_type;



--What is the distribution of salaries in the dataset?
SELECT salary_in_usd, COUNT(*) AS count
FROM Project1..ds_salaries
GROUP BY salary_in_usd
ORDER BY salary_in_usd