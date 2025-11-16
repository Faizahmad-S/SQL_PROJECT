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


** Result  **
[
  {
    "job_id": 712473,
    "job_title": "Data Analyst",
    "company_name": "Get It Recruit - Information Technology",
    "salary_year_avg": "165000.0",
    "job_via": "via Get.It",
    "skills": "sql"
  },
  {
    "job_id": 712473,
    "job_title": "Data Analyst",
    "company_name": "Get It Recruit - Information Technology",
    "salary_year_avg": "165000.0",
    "job_via": "via Get.It",
    "skills": "python"
  },
  {
    "job_id": 712473,
    "job_title": "Data Analyst",
    "company_name": "Get It Recruit - Information Technology",
    "salary_year_avg": "165000.0",
    "job_via": "via Get.It",
    "skills": "r"
  },
  {
    "job_id": 712473,
    "job_title": "Data Analyst",
    "company_name": "Get It Recruit - Information Technology",
    "salary_year_avg": "165000.0",
    "job_via": "via Get.It",
    "skills": "sas"
  },
  {
    "job_id": 712473,
    "job_title": "Data Analyst",
    "company_name": "Get It Recruit - Information Technology",
    "salary_year_avg": "165000.0",
    "job_via": "via Get.It",
    "skills": "matlab"
  },
  {
    "job_id": 712473,
    "job_title": "Data Analyst",
    "company_name": "Get It Recruit - Information Technology",
    "salary_year_avg": "165000.0",
    "job_via": "via Get.It",
    "skills": "pandas"
  },
  {
    "job_id": 712473,
    "job_title": "Data Analyst",
    "company_name": "Get It Recruit - Information Technology",
    "salary_year_avg": "165000.0",
    "job_via": "via Get.It",
    "skills": "tableau"
  },
  {
    "job_id": 712473,
    "job_title": "Data Analyst",
    "company_name": "Get It Recruit - Information Technology",
    "salary_year_avg": "165000.0",
    "job_via": "via Get.It",
    "skills": "looker"
  },
  {
    "job_id": 712473,
    "job_title": "Data Analyst",
    "company_name": "Get It Recruit - Information Technology",
    "salary_year_avg": "165000.0",
    "job_via": "via Get.It",
    "skills": "sas"
  },
  {
    "job_id": 1246069,
    "job_title": "Data Analyst",
    "company_name": "Plexus Resource Solutions",
    "salary_year_avg": "165000.0",
    "job_via": "via LinkedIn",
    "skills": "python"
  },
  {
    "job_id": 1246069,
    "job_title": "Data Analyst",
    "company_name": "Plexus Resource Solutions",
    "salary_year_avg": "165000.0",
    "job_via": "via LinkedIn",
    "skills": "mysql"
  },
  {
    "job_id": 1246069,
    "job_title": "Data Analyst",
    "company_name": "Plexus Resource Solutions",
    "salary_year_avg": "165000.0",
    "job_via": "via LinkedIn",
    "skills": "aws"
  },
  {
    "job_id": 456042,
    "job_title": "Data Analyst",
    "company_name": "Get It Recruit - Healthcare",
    "salary_year_avg": "151500.0",
    "job_via": "via Get.It",
    "skills": "sql"
  },
  {
    "job_id": 456042,
    "job_title": "Data Analyst",
    "company_name": "Get It Recruit - Healthcare",
    "salary_year_avg": "151500.0",
    "job_via": "via Get.It",
    "skills": "python"
  },
  {
    "job_id": 456042,
    "job_title": "Data Analyst",
    "company_name": "Get It Recruit - Healthcare",
    "salary_year_avg": "151500.0",
    "job_via": "via Get.It",
    "skills": "r"
  },
  {
    "job_id": 479485,
    "job_title": "Data Analyst",
    "company_name": "Level",
    "salary_year_avg": "145000.0",
    "job_via": "via Indeed",
    "skills": "sql"
  },
  {
    "job_id": 479485,
    "job_title": "Data Analyst",
    "company_name": "Level",
    "salary_year_avg": "145000.0",
    "job_via": "via Indeed",
    "skills": "python"
  },
  {
    "job_id": 479485,
    "job_title": "Data Analyst",
    "company_name": "Level",
    "salary_year_avg": "145000.0",
    "job_via": "via Indeed",
    "skills": "r"
  },
  {
    "job_id": 479485,
    "job_title": "Data Analyst",
    "company_name": "Level",
    "salary_year_avg": "145000.0",
    "job_via": "via Indeed",
    "skills": "golang"
  },
  {
    "job_id": 479485,
    "job_title": "Data Analyst",
    "company_name": "Level",
    "salary_year_avg": "145000.0",
    "job_via": "via Indeed",
    "skills": "elasticsearch"
  },
  {
    "job_id": 479485,
    "job_title": "Data Analyst",
    "company_name": "Level",
    "salary_year_avg": "145000.0",
    "job_via": "via Indeed",
    "skills": "aws"
  },
  {
    "job_id": 479485,
    "job_title": "Data Analyst",
    "company_name": "Level",
    "salary_year_avg": "145000.0",
    "job_via": "via Indeed",
    "skills": "bigquery"
  },
  {
    "job_id": 479485,
    "job_title": "Data Analyst",
    "company_name": "Level",
    "salary_year_avg": "145000.0",
    "job_via": "via Indeed",
    "skills": "gcp"
  },
  {
    "job_id": 479485,
    "job_title": "Data Analyst",
    "company_name": "Level",
    "salary_year_avg": "145000.0",
    "job_via": "via Indeed",
    "skills": "pandas"
  },
  {
    "job_id": 479485,
    "job_title": "Data Analyst",
    "company_name": "Level",
    "salary_year_avg": "145000.0",
    "job_via": "via Indeed",
    "skills": "scikit-learn"
  },
  {
    "job_id": 479485,
    "job_title": "Data Analyst",
    "company_name": "Level",
    "salary_year_avg": "145000.0",
    "job_via": "via Indeed",
    "skills": "looker"
  },
  {
    "job_id": 479485,
    "job_title": "Data Analyst",
    "company_name": "Level",
    "salary_year_avg": "145000.0",
    "job_via": "via Indeed",
    "skills": "kubernetes"
  },
  {
    "job_id": 405581,
    "job_title": "Data Analyst",
    "company_name": "CyberCoders",
    "salary_year_avg": "145000.0",
    "job_via": "via Indeed",
    "skills": "python"
  },
  {
    "job_id": 405581,
    "job_title": "Data Analyst",
    "company_name": "CyberCoders",
    "salary_year_avg": "145000.0",
    "job_via": "via Indeed",
    "skills": "java"
  },
  {
    "job_id": 405581,
    "job_title": "Data Analyst",
    "company_name": "CyberCoders",
    "salary_year_avg": "145000.0",
    "job_via": "via Indeed",
    "skills": "r"
  },
  {
    "job_id": 405581,
    "job_title": "Data Analyst",
    "company_name": "CyberCoders",
    "salary_year_avg": "145000.0",
    "job_via": "via Indeed",
    "skills": "javascript"
  },
  {
    "job_id": 405581,
    "job_title": "Data Analyst",
    "company_name": "CyberCoders",
    "salary_year_avg": "145000.0",
    "job_via": "via Indeed",
    "skills": "c++"
  },
  {
    "job_id": 405581,
    "job_title": "Data Analyst",
    "company_name": "CyberCoders",
    "salary_year_avg": "145000.0",
    "job_via": "via Indeed",
    "skills": "tableau"
  },
  {
    "job_id": 405581,
    "job_title": "Data Analyst",
    "company_name": "CyberCoders",
    "salary_year_avg": "145000.0",
    "job_via": "via Indeed",
    "skills": "power bi"
  },
  {
    "job_id": 405581,
    "job_title": "Data Analyst",
    "company_name": "CyberCoders",
    "salary_year_avg": "145000.0",
    "job_via": "via Indeed",
    "skills": "qlik"
  },
  {
    "job_id": 1090975,
    "job_title": "Data Analyst",
    "company_name": "Uber",
    "salary_year_avg": "140500.0",
    "job_via": "via ZipRecruiter",
    "skills": "sql"
  },
  {
    "job_id": 1090975,
    "job_title": "Data Analyst",
    "company_name": "Uber",
    "salary_year_avg": "140500.0",
    "job_via": "via ZipRecruiter",
    "skills": "python"
  },
  {
    "job_id": 1090975,
    "job_title": "Data Analyst",
    "company_name": "Uber",
    "salary_year_avg": "140500.0",
    "job_via": "via ZipRecruiter",
    "skills": "r"
  },
  {
    "job_id": 1090975,
    "job_title": "Data Analyst",
    "company_name": "Uber",
    "salary_year_avg": "140500.0",
    "job_via": "via ZipRecruiter",
    "skills": "swift"
  },
  {
    "job_id": 1090975,
    "job_title": "Data Analyst",
    "company_name": "Uber",
    "salary_year_avg": "140500.0",
    "job_via": "via ZipRecruiter",
    "skills": "excel"
  },
  {
    "job_id": 1090975,
    "job_title": "Data Analyst",
    "company_name": "Uber",
    "salary_year_avg": "140500.0",
    "job_via": "via ZipRecruiter",
    "skills": "tableau"
  },
  {
    "job_id": 1090975,
    "job_title": "Data Analyst",
    "company_name": "Uber",
    "salary_year_avg": "140500.0",
    "job_via": "via ZipRecruiter",
    "skills": "looker"
  },
  {
    "job_id": 1482852,
    "job_title": "Data Analyst",
    "company_name": "Overmind",
    "salary_year_avg": "138500.0",
    "job_via": "via Web3 Jobs",
    "skills": "sql"
  },
  {
    "job_id": 1482852,
    "job_title": "Data Analyst",
    "company_name": "Overmind",
    "salary_year_avg": "138500.0",
    "job_via": "via Web3 Jobs",
    "skills": "python"
  },
  {
    "job_id": 1326467,
    "job_title": "Data Analyst",
    "company_name": "EPIC Brokers",
    "salary_year_avg": "135000.0",
    "job_via": "via Indeed",
    "skills": "excel"
  },
  {
    "job_id": 479965,
    "job_title": "Data Analyst",
    "company_name": "InvestM Technology LLC",
    "salary_year_avg": "135000.0",
    "job_via": "via LinkedIn",
    "skills": "sql"
  },
  {
    "job_id": 479965,
    "job_title": "Data Analyst",
    "company_name": "InvestM Technology LLC",
    "salary_year_avg": "135000.0",
    "job_via": "via LinkedIn",
    "skills": "excel"
  },
  {
    "job_id": 479965,
    "job_title": "Data Analyst",
    "company_name": "InvestM Technology LLC",
    "salary_year_avg": "135000.0",
    "job_via": "via LinkedIn",
    "skills": "power bi"
  }
]