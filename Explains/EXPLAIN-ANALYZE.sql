EXPLAIN ANALYZE SELECT * FROM staff;
/*
"Seq Scan on staff  (cost=0.00..24.00 rows=1000 width=75) (actual time=0.013..0.140 rows=1000 loops=1)"
"Planning Time: 0.065 ms"
"Execution Time: 0.200 ms"
*/
EXPLAIN ANALYZE SELECT last_name FROM staff;
/*
"Seq Scan on staff  (cost=0.00..24.00 rows=1000 width=7) (actual time=0.019..0.181 rows=1000 loops=1)"
"Planning Time: 0.045 ms"
"Execution Time: 0.305 ms"
*/