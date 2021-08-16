CREATE TABLE products(
prod_id int NOT NULL,
prod_name text NOT NULL,
prdo_sort_name_descr text NOT NULL,
prod_long_name_descr text NOT NULL,
prod_category varchar NOT NULL
)
PARTITION by LIST (prod_category);

create table products_clothing partition of products
for
values in ('casual_clothing', 'business_attire');

create table products_eletronics partition of products
for
values in ('laptop', 'mouse');

select * from products_clothing;
select * from products_eletronics;

explain analyse select * from products where prod_category = 'casual_clothing';