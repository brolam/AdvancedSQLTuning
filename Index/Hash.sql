create index idx_staff_email_hash on staff using hash (email);
explain
select
	*
from
	staff s
where
	email = 'bphillips5@time.com';
/*
Index Scan using idx_staff_email on staff s  (cost=0.28..8.29 rows=1 width=75)
  Index Cond: ((email)::text = 'bphillips5@time.com'::text)
*/
