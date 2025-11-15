CREATE TABLE data_science_job(
    job_id INT PRIMARY KEY,
    job_title TEXT,
    company_name TEXT,
    post_date DATE 
);



insert INTO data_science_job
VALUES(1,'Data scientist','Tech Innovation','2023-01-01'),
    (2, 'Machine Learning','Data Driven Co', '2023-01-15'),
    (3, 'AI Specilist','Future Tech','2023-02-01');


SELECT * FROM data_science_job;

ALTER TABLE data_science_job
ADD remote BOOLEAN ;

ALTER TABLE data_science_job
RENAME  posted_on_1 TO posted_on; ALTER


SELECT column_name
FROM information_schema.columns
where table_name = 'data_science_job';


ALTER TABLE data_science_job
ALTER column remote
set default False; 

INSERT INTO data_science_job
VALUES(4,'Data','Google','20213-02-05', true);


INSERT INTO data_science_job
VALUES (5,'Data me','Google','20213-02-05');



UPDATE  data_science_job
set remote = true
WHERE job_id = 1;


ALTER TABLE data_science_job
DROP company_name;


drop TABLE data_science_job;