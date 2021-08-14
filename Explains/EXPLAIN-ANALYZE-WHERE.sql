EXPLAIN ANALYSE SELECT * FROM staff WHERE salary > 75000;
/*
"Seq Scan on staff  (cost=0.00..26.50 rows=715 width=75) (actual time=0.013..0.189 rows=717 loops=1)"
"  Filter: (salary > 75000)"
"  Rows Removed by Filter: 283"
"Planning Time: 0.572 ms"
"Execution Time: 0.352 ms"
*/
EXPLAIN ANALYSE SELECT * FROM staff;
/*
"Seq Scan on staff  (cost=0.00..24.00 rows=1000 width=75) (actual time=0.018..0.204 rows=1000 loops=1)"
"Planning Time: 0.068 ms"
"Execution Time: 0.291 ms"
*/