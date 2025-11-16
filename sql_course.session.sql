-- practice sql queries for the sql course

SELECT AVG(salary_year_avg) as yearly,
     AVG(salary_hour_avg) as hourly
FROM job_postings_fact
WHERE job_posted_date:: DATE > '2023-07-01'
GROUP BY job_schedule_type
ORDER BY job_schedule_type
LIMIT 10 ;



SELECT COUNT(job_id) Total_jobs,
    EXTRACT(MONTH FROM job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'America/New_York') as months
FROM job_postings_fact
GROUP BY months
ORDER BY months
;

SELECT * FROM job_postings_fact LIMIT 10;

SELECT name, 
    COUNT(job_id) jobs
FROM company_dim cm
JOIN job_postings_fact  jb ON cm.company_id = jb.company_id
WHERE job_health_insurance = TRUE  and
        EXTRACT(MONTH FROM job_posted_date) in (4,5,6)
GROUP BY name 
ORDER BY jobs desc;

SELECT job_title_short, count(job_id) count_2nd_high
FROM job_postings_fact
GROUP BY job_title_short
having count(job_id) <(
                    SELECT job_title_short ,COUNT(job_id) as jobs
                    FROM job_postings_fact
                    WHERE lower(job_title_short) like '%analyst%' 
                    GROUP BY job_title_short
                    ORDER BY jobs DESC 
                    LIMIT 1)
LIMIT 1


SELECT job_title_short ,COUNT(job_id) as jobs
FROM job_postings_fact
WHERE lower(job_title_short) like '%analyst%' 
GROUP BY job_title_short
ORDER BY jobs DESC 

SELECT job_id, 
    job_title, 
    salary_year_avg,
    CASE 
        WHEN salary_year_avg >= 100000 then 'High Salary'
        WHEN salary_year_avg Between 60000 AND 100000 then 'Standard Salary'
        else 'Low Salary'
    END
FROM job_postings_fact
WHERE job_title = 'Data Analyst' and salary_year_avg is not null
ORDER BY salary_year_avg DESC;


SELECT * FROM job_postings_fact LIMIT 10


SELECT count(distinct(company_id)),
    CASE 
        when job_work_from_home = true then 'remote'
        else 'on site'
    end as type_of_jobs
FROM job_postings_fact
GROUP BY type_of_jobs



SELECT job_id,
        salary_year_avg,
        CASE 
            when job_title ILIKE '%senior%' then 'senior'
            when job_title ILIKE '%manager%' or job_title ILIKE '%Lead%' then 'Lead/Manager'
            when job_title ILIKE '%junior%' or job_title ILIKE '%Entry%' then 'Junior/Entry'
            else 'Not Specified'
        END as experience_lavel,
        CASE
            WHEN job_work_from_home = true then 'Yes'
            else 'No'
        END as remote_optuon
FROM job_postings_fact
WHERE salary_year_avg is not null
ORDER BY job_id;



SELECT 
    count(distinct(CASE WHEN job_work_from_home = true then company_id END)) as WFH,
    count(distinct(CASE WHEN job_work_from_home = false then company_id END)) as NOT_WFH
FROM job_postings_fact;




SELECT job_id

SELECT count(job_id) Total_jobs,
        skills
FROM skills_job_dim sj 
JOIN skills_dim sd on sj.skill_id = sd.skill_id
GROUP BY skills
ORDER BY Total_jobs DESC
LIMIT 5


with skills_total_jobs as(
SELECT count(job_id) as Total_jobs,
    skill_id
FROM skills_job_dim
GROUP BY skill_id
ORDER BY Total_jobs DESC
LIMIT 5
)

SELECT 
        skills
FROM skills_total_jobs sdj
JOIN skills_dim sd on sd.skill_id = sdj.skill_id
ORDER BY Total_jobs DESC



SELECT 
    skills
FROM skills_dim sd
JOIN (SELECT count(job_id) as Total_jobs,
    skill_id
FROM skills_job_dim
GROUP BY skill_id
ORDER BY Total_jobs desc
LIMIT 5) as sub
on sd.skill_id = sub.skill_id
ORDER BY Total_jobs DESC

SELECT Total_jobs,company_dim.company_id, name,
    CASE
        WHEN Total_jobs > 50 then 'large'
        WHEN Total_jobs Between 10 and 50 then 'Medium'
        else 'small'
    END as company_size
FROM (    
SELECT company_id,
    COUNT(job_id) as Total_jobs
FROM job_postings_fact
GROUP BY company_id) as count_on_company
JOIN company_dim on company_dim.company_id = count_on_company.company_id
ORDER BY company_id



SELECT 
    name as company_name,
    avg(salary_year_avg) company_avg
FROM job_postings_fact jpf
JOIN company_dim  cd on jpf.company_id = cd.company_id
GROUP BY company_name 
having avg(salary_year_avg) > (SELECT avg(salary_year_avg) 
                    from job_postings_fact)
ORDER BY company_avg desc


with company_title_count as (
    SELECT count(distinct(job_title)) title_count,
            company_id
    from job_postings_fact
    GROUP BY company_id
)

SELECT name as company_name, title_count
from company_title_count ctc
JOIN company_dim  cd on ctc.company_id = cd.company_id
ORDER BY title_count DESC
LIMIT 10



with country_avg_cte as(
SELECT job_country,
        AVG(salary_year_avg) country_avg
FROM job_postings_fact
GROUP BY  job_country)


SELECT job_id, job_title, name as company_name, salary_year_avg,
    CASE
    WHEN country_avg < salary_year_avg then 'Above Avg'
    else 'Below Avg'
    END category,
    EXTRACT(MONTH from job_posted_date) as months
FROM country_avg_cte cte
JOIN job_postings_fact jp on cte.job_country = jp.job_country
JOIN company_dim cd on cd.company_id = jp.company_id
WHERE job_id = 1246069 
ORDER BY months DESC;



with required_skills as(
SELECT cd.company_id,
        count(distinct skill_id) unique_skills
from company_dim cd
left JOIN job_postings_fact jf on cd.company_id = jf.company_id
left JOIN skills_job_dim sd on jf.job_id = sd.job_id
GROUP BY cd.company_id  
),
 max_salary as(
SELECT max(salary_year_avg) highest_salary,
       company_id
from job_postings_fact jf
GROUP BY company_id)

SELECT name as company_name,
    unique_skills,
    highest_salary
from company_dim cd
JOIN required_skills rs on rs.company_id = cd.company_id
JOIN max_salary ms on ms.company_id= rs.company_id
ORDER BY company_name;




