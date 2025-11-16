
## Introduction
Welcome to my repository SQL_PROJECT where we delved in to the data job market specialy related to data analyst role.

Through this project, I analysed job posting data to answer some key questions such as top-paying roles, in-demand skills, for high deamd and high salry whats the best combinaton.

You can view the full collection of SQL queries of project here:[SQL_PROJECT](/project_sql/)


## Background
The purpose of this project was to learn SQL, and show my understing for SQL laguage, as well to get a clear understanig of the data driven job market.

As a fresher i wanted to get insights and gidence for career opportunities, so I wanted to identify:
- Which data analyst roles offer the highest salaries.
-Which skills are most valued.
- Which skills are both high-paying and high-deamnd, making them ideal to learn
- How SQL can be used to get meaning full insights from any real-world data.

To answer these questions and to learn SQL, I used a course and dataset provided by Luke Barousse's [SQL Course](https://www.lukebarousse.com/products/sql-for-data-analytics/).This data includes details on job titles, salaries, locations, and required skills. 

Using this dataset, I focused on answering five key questions:
1. What are the top-paying data analyst jobs?
2. What skills are required for those top-paying jobs?
3. What skills are most in demand?
4. Which skills correlate with higher salaries?
5. Which skills offer both high salary and high demand — the optimal skills to learn?
## 🛠️ Tools I Used
🛢️ **SQL (Structured Query Language)** : SQL was the core of this project. I used it to query, filter, join, and analyze data efficiently.

🐘 **PostgreSQL** : The PostgreSQL database handled all job, salary, and skills data.
Its stability and powerful SQL support made it ideal for analytical queries.

💻 **Visual Studio Code (VS Code)** : VS Code served as my development environment, offering helpful extensions for SQL formatting, syntax highlighting, database management and Commiting directly to git.

## 📈 The Analysis
This project consists of five SQL queries designed to explore the data analyst job market from multiple angles.
Each query answers a specific question and contributes to understanding salary trends, skill demand, and optimal learning priorities.

**1. Top_Paying_Jobs**

This query identifies the highest-paying data analyst roles that offer remote work or located in London. It filters positions by salary, ensures the job title matches "Data Analyst," and sorts results to highlight the top 10 highest paying opportunities.

```sql
    --Top 10 highest paying data analyst roles that are either remote or local
SELECT
	job_id,
	job_title,
    name AS company_name,
	job_location,
	job_schedule_type,
	salary_year_avg,
	job_posted_date,
    job_via
FROM
	job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE
	job_title = 'Data Analyst'
	AND salary_year_avg IS NOT NULL
	AND (job_location = 'Anywhere' OR job_location = 'London')
ORDER BY
	salary_year_avg DESC 
LIMIT 10;
```
**2. Top_Paying_Skills**

After identifying the top-paying roles, this query digs deeper by joining the job postings with skills data. It reveals which skills employers expect for the highest-paying data analyst positions.
```sql

WITH top_paying_jobs AS (
    --Top 10 highest paying data analyst roles that are either remote or local
    SELECT
        job_id,
        job_title,
        name AS company_name,
        salary_year_avg,
        job_via
    FROM
        job_postings_fact
    LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
    WHERE
        job_title = 'Data Analyst'
        AND salary_year_avg IS NOT NULL
        AND (job_location = 'Anywhere' OR job_location = 'London')
    ORDER BY
        salary_year_avg DESC 
    LIMIT 10
)


SELECT
    top_paying_jobs.*,
    skills
FROM
    top_paying_jobs
	INNER JOIN
    skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
	INNER JOIN
    skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY
    salary_year_avg DESC

```
**3. Top_Skills_In_Demand**

This query identifies the skills mentioned most frequently in data analyst job postings. It helps highlight which tools and technologies employers expect analysts to know.
```sql
-- Identifies the top 5 most demanded skills for Data Analyst job postings
SELECT
  skills_dim.skills,
  COUNT(skills_job_dim.job_id) AS demand_count
FROM
  job_postings_fact
  INNER JOIN
    skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
  INNER JOIN
    skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
  -- Filters job titles for 'Data Analyst' roles
  job_postings_fact.job_title_short = 'Data Analyst'
	-- AND job_work_from_home = True -- optional to filter for remote jobs
GROUP BY
  skills_dim.skills
ORDER BY
  demand_count DESC
LIMIT 5;
```
**4. Top_Skills_On_Salary**

This query calculates the average salary associated with each skill.
By grouping salaries by skill, it reveals which technical abilities tend to be the highest paying.
```sql
-- Calculates the average salary for job postings by individual skill 
SELECT
  skills_dim.skills AS skill, 
  ROUND(AVG(job_postings_fact.salary_year_avg),2) AS avg_salary
FROM
  job_postings_fact
	INNER JOIN
	  skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
	INNER JOIN
	  skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
  job_postings_fact.job_title_short = 'Data Analyst' 
  AND job_postings_fact.salary_year_avg IS NOT NULL 
GROUP BY
  skills_dim.skills 
ORDER BY
  avg_salary DESC; 
```
**5. Most_Optimal_Skills**
This query combines job demand and average salary to identify the most valuable skills for a data analyst to learn. It highlights the skills that are both frequently requested and highly paid — offering the best return on learning investment.

```sql

-- Identifies skills in high demand for Data Analyst roles
WITH skills_demand AS (
  SELECT
    skills_dim.skill_id,
		skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count
  FROM
    job_postings_fact
	  INNER JOIN
	    skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
	  INNER JOIN
	    skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
  WHERE
    job_postings_fact.job_title_short = 'Data Analyst'
		AND job_postings_fact.salary_year_avg IS NOT NULL
    AND job_postings_fact.job_work_from_home = True
  GROUP BY
    skills_dim.skill_id
),
-- Skills with high average salaries for Data Analyst roles
average_salary AS (
  SELECT
    skills_job_dim.skill_id,
    AVG(job_postings_fact.salary_year_avg) AS avg_salary
  FROM
    job_postings_fact
	  INNER JOIN
	    skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
  WHERE
    job_postings_fact.job_title_short = 'Data Analyst'
		AND job_postings_fact.salary_year_avg IS NOT NULL
    AND job_postings_fact.job_work_from_home = True
  GROUP BY
    skills_job_dim.skill_id
)
-- Return high demand and high salaries for 10 skills 
SELECT
  skills_demand.skills,
  skills_demand.demand_count,
  ROUND(average_salary.avg_salary, 2) AS avg_salary --ROUND to 2 decimals 
FROM
  skills_demand
	INNER JOIN
	  average_salary ON skills_demand.skill_id = average_salary.skill_id
WHERE demand_count > 10
ORDER BY
  demand_count DESC, 
	avg_salary DESC
Limit 10
; 
```

​
Each query not only served to answer a specific question but also to improve my understanding of SQL and database analysis. Through this project, I learned to leverage SQL's powerful data manipulation capabilities to derive meaningful insights from complex datasets.


## 💡 What I Learned
Analyzing the job postings data provided several meaningful insights into the data analyst job market, especially regarding salaries, skill demand, and the technologies that offer the greatest career advantage.
**1. High-Paying Opportunities Exist in Both Remote and London Roles** : The highest-paying data analyst jobs are not limited to remote positions — several competitive roles are located in London, offering strong salaries comparable to fully remote positions.

**2. Top-Paying Jobs Often Come From Well-Established Companies** : By joining job postings with company data, the results showed that high-paying positions frequently originate from larger or more reputable companies.

**3. SQL Is the Most Consistently In-Demand Skill** : Across all job postings, SQL appears more frequently than any other skill.
This confirms that SQL is a core requirement for data analyst roles regardless of company size, industry, or salary level.

**4. Niche Skills Can Command Higher Salaries** : While common tools like SQL and Excel appear everywhere, specialized skills such as version control tools or blockchain-related technologies   show up in fewer roles but with significantly higher average salaries.

**5. The Best Skills to Learn Are Those With Both High Demand and Strong Salaries** : By combining salary averages and demand counts, the “optimal skills” analysis reveals which skills offer the best career return.
Skills that consistently rank highly in both demand and salary are SQL and Python.

**6. Job Platforms Influence How High-Paying Roles Are Found** :Including the ``` job_via ``` field in the first query revealed which job posting platforms tend to host the highest-paying opportunities. This insight helps job seekers focus their efforts on the most effective job boards.

**7. Salary Transparency Varies Widely** : Many job postings do not include salary data — which is why filtering for ```salary_year_avg IS NOT NULL``` is important.
## Conclusions
This project allowed me to deepen my SQL skills while gaining valuable insights into the data driven job market. Through a series of targeted queries, I explored the highest-paying roles, the skills required to obtain them, and the technologies that are most in demand.

By combining salary data with skill data, I was able to identify the skills that provide the strongest career advantage the ones that offer both high earning potential and high demand across job postings. This approach not only strengthened my technical SQL abilities but also helped me better understand how data-driven thinking can guide strategic career decisions.