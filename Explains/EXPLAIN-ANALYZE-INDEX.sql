CREATE INDEX idx_staff_salary ON staff(salary);

explain analyze select * from staff;
/*
Seq Scan on staff  (cost=0.00..24.00 rows=1000 width=75) (actual time=0.012..0.165 rows=1000 loops=1)
Planning Time: 1.157 ms
Execution Time: 0.349 ms
*/
explain analyze select * from staff where salary > 75000;
/*
Seq Scan on staff  (cost=0.00..26.50 rows=715 width=75) (actual time=0.013..0.210 rows=717 loops=1)
  Filter: (salary > 75000)
  Rows Removed by Filter: 283
Planning Time: 0.207 ms
Execution Time: 0.271 ms
*/
explain analyze select * from staff where salary > 150000;
/*
Fisrt time:
Index Scan using idx_staff_salary on staff  (cost=0.28..8.29 rows=1 width=75) (actual time=0.008..0.008 rows=0 loops=1)
  Index Cond: (salary > 150000)
Planning Time: 0.382 ms
Execution Time: 0.031 ms
second time:
Index Scan using idx_staff_salary on staff  (cost=0.28..8.29 rows=1 width=75) (actual time=0.006..0.006 rows=0 loops=1)
  Index Cond: (salary > 150000)
Planning Time: 0.291 ms
Execution Time: 0.025 ms
*/