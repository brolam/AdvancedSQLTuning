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
join company_regions cr on (s.region_id = cr.region_id);
/*
  ->  Seq Scan on staff s  (cost=0.00..24.00 rows=1000 width=34) (actual time=0.025..11.404 rows=1000 loops=1)
  ->  Index Scan using company_regions_pkey on company_regions cr  (cost=0.15..0.22 rows=1 width=62) (actual time=0.015..0.015 rows=1 loops=1000)
        Index Cond: (region_id = s.region_id)
Planning Time: 0.173 ms
Execution Time: 74.366 ms
*/
set enable_nestloop=false;
set enable_hashjoin=false;
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
Merge Join  (cost=114.36..132.11 rows=1000 width=88) (actual time=24.722..58.523 rows=1000 loops=1)
  Merge Cond: (s.region_id = cr.region_id)
  ->  Sort  (cost=73.83..76.33 rows=1000 width=34) (actual time=24.488..35.892 rows=1000 loops=1)
        Sort Key: s.region_id
        Sort Method: quicksort  Memory: 103kB
        ->  Seq Scan on staff s  (cost=0.00..24.00 rows=1000 width=34) (actual time=0.047..11.853 rows=1000 loops=1)
  ->  Sort  (cost=40.53..41.91 rows=550 width=62) (actual time=0.195..0.282 rows=7 loops=1)
        Sort Key: cr.region_id
        Sort Method: quicksort  Memory: 25kB
        ->  Seq Scan on company_regions cr  (cost=0.00..15.50 rows=550 width=62) (actual time=0.022..0.102 rows=7 loops=1)
Planning Time: 0.340 ms
Execution Time: 69.468 ms
*/

