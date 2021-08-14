set enable_nestloop=false;
set enable_hashjoin=true;
set enable_mergejoin=true;
explain analyze
select
	s.id,
	s.last_name,
	s.job_title,
	cr.country 
from
	staff s
join company_regions cr on (s.region_id = cr.region_id);
/*
Hash Join  (cost=22.38..49.02 rows=1000 width=88) (actual time=0.321..1.183 rows=1000 loops=1)
  Hash Cond: (s.region_id = cr.region_id)
  ->  Seq Scan on staff s  (cost=0.00..24.00 rows=1000 width=34) (actual time=0.019..0.258 rows=1000 loops=1)
  ->  Hash  (cost=15.50..15.50 rows=550 width=62) (actual time=0.191..0.192 rows=7 loops=1)
        Buckets: 1024  Batches: 1  Memory Usage: 9kB
        ->  Seq Scan on company_regions cr  (cost=0.00..15.50 rows=550 width=62) (actual time=0.011..0.016 rows=7 loops=1)
Planning Time: 0.289 ms
Execution Time: 1.306 ms
*/
set enable_nestloop=true;
set enable_hashjoin=false;
set enable_mergejoin=false;
explain analyze
select
	s.id,
	s.last_name,
	s.job_title,
	cr.country
from
	staff s
join company_regions cr on
	(s.region_id = cr.region_id);
/*
Nested Loop  (cost=0.15..239.37 rows=1000 width=88) (actual time=0.042..3.201 rows=1000 loops=1)
  ->  Seq Scan on staff s  (cost=0.00..24.00 rows=1000 width=34) (actual time=0.018..0.263 rows=1000 loops=1)
  ->  Index Scan using company_regions_pkey on company_regions cr  (cost=0.15..0.22 rows=1 width=62) (actual time=0.002..0.002 rows=1 loops=1000)
        Index Cond: (region_id = s.region_id)
Planning Time: 0.187 ms
Execution Time: 3.323 ms
*/

