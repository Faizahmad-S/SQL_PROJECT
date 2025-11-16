/*
**Question: What are the top-paying data analyst jobs, and what skills are required?** 

- Identify the top 10 highest-paying Data Analyst jobs and the specific skills
     required for these roles.
- Filters for roles with specified salaries that are remote
- Why? It provides a detailed look at which high-paying jobs demand certain skills, 
    helping job seekers understand which skills to develop that align with top salaries
*/


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




/*
* The data highlights a strong demand for skills that cover the entire data analysis pipeline:

- Coding is Essential: Python (7), SQL (6), and R (5) are the top skills for data cleaning,
    manipulation, and advanced analysis.

-Visualization is Key: Analysts must use Tableau(3), Looker(3), and Power BI(2) to present data in 
    reports and dashboards.

-Basic Tools Endure: Excel (3) remains a core requirement for foundational data work and 
    quick tasks.
*/