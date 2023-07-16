set random_page_cost = 0.25;

---индекс на FK пользователь в таблице "Заказы"
create index on project_schema.orders(users_id);
analyze project_schema.orders;

explain (costs, verbose, format json, analyze) 
select * from project_schema.orders
	where users_id = '50';
	
Index Scan using orders_users_id_idx1 on project_schema.orders as orders (cost=0.13..0.95 rows=4 width=20) (actual=0.112..0.116 rows=4 loops=1)
Index Cond: (orders.users_id = 50)

---индекс для полнотекстового поиска по наименованию товара
alter table project_schema.products 
	add column name_lexeme tsvector;
update project_schema.products
set name_lexeme = to_tsvector(name)
returning name, name_lexeme;

create index search_name
	on project_schema.products
	using gin (name_lexeme);
analyze project_schema.products;

explain
select name
	from project_schema.products
	where name_lexeme @@ to_tsquery('шоколад'); 	

"Bitmap Heap Scan on products  (cost=0.79..2.35 rows=5 width=39)"
"  Recheck Cond: (name_lexeme @@ to_tsquery('шоколад'::text))"
"  ->  Bitmap Index Scan on search_name  (cost=0.00..0.79 rows=5 width=0)"
"        Index Cond: (name_lexeme @@ to_tsquery('шоколад'::text))"

--- индекс на поле наименование в таблице "Поставщики"
create index name_lower 
	on project_schema.suppliers (lower(name));

explain
select * from project_schema.suppliers 
	where lower(name) = 'поставщик кастрюлька';

"Index Scan using name_lower on suppliers  (cost=0.13..0.65 rows=1 width=1036)"
"  Index Cond: (lower((name)::text) = 'поставщик кастрюлька'::text)"

---индекс на наименование и описание товара
create index name_note 
	on project_schema.products (name, note);
	
explain
select count(*) from project_schema.products
where lower(name) like 'кольцо%' and note like '%фиксированный%';

"Aggregate  (cost=1.11..1.12 rows=1 width=8)"
"  ->  Index Only Scan using name_note on products  (cost=0.14..1.11 rows=1 width=0)"
"        Filter: (((note)::text ~~ '%фиксированный%'::text) AND (lower((name)::text) ~~ 'кольцо%'::text))"
