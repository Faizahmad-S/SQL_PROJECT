/*
**Answer: What are the top skills based on salary?** 

- Look at the average salary associated with each skill for Data Analyst positions.
- Focuses on roles with specified salaries, regardless of location.
- Why? It reveals how different skills impact salary levels for Data Analysts and helps 
    identify the most financially rewarding skills to acquire or improve.
*/

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


/*

** Key Insight Summary **
-High-Paying Skills are Niche or Operational: The absolute highest salaries are for 
    hyper-specialized (Solidity) or complex operational skills (DevOps/Cloud tools).
-Cloud Competency is a Major Booster: Knowing AWS, Azure, or GCP—combined with tools 
    like Snowflake, Databricks, and Kubernetes—is key to breaking the six-figure barrier.
-Python is the Foundation: Python is present in many high-salary stacks, confirming 
    it's the most valuable general-purpose data language.
-SQL is a Baseline: The fundamental data query language, while its average salary
    $(\$96,435.33)$ is lower than the cutting-edge tech, it remains a non-negotiable 
    prerequisite for nearly all data roles.
*/


