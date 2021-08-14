explain select distinct job_title from staff s;
/*
HashAggregate  (cost=26.50..28.36 rows=186 width=19)
  Group Key: job_title
  ->  Seq Scan on staff s  (cost=0.00..24.00 rows=1000 width=19)
*/
create index idx_staff_job_title on staff(job_title);
explain select * from staff s where job_title = 'Operator';
/*
Bitmap Heap Scan on staff s  (cost=4.36..18.36 rows=11 width=75)
  Recheck Cond: ((job_title)::text = 'Operator'::text)
  ->  Bitmap Index Scan on idx_staff_job_title  (cost=0.00..4.36 rows=11 width=0)
        Index Cond: ((job_title)::text = 'Operator'::text)
*/
