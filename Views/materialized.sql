CREATE materialized VIEW mv_staff AS 
SELECT
	s.last_name,
	s.department,
	s.job_title,
	cr.company_regions
FROM
	staff AS s
INNER JOIN company_regions AS cr ON
(
s.region_id = cr.region_id
);


refresh materialized view mv_staff;

select * from mv_staff where last_name like 'Kelley%'; 
select * from staff s where last_name like 'Kelley%';



