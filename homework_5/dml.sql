create sequence table_id_seq;

alter table project_schema.categories
    alter column id 
        set default nextval('table_id_seq');

alter table project_schema.products
    alter column id 
        set default nextval('table_id_seq');
		
--- insert
insert into project_schema.categories
(name)
values 	('Посуда'), 
	('Продукты'),
	('Оформление')
returning *;

insert into project_schema.products 
(name, note, picture, count, categories_id, suppliers_id)
values ('Кольцо для выпечки', 'кольцо для выпечки разъемное', 
		'\picture\picture1.jpeg', 10, 15, 20),
		('Кольцо для выпечки 20 см', 'кольцо для выпечки 20 см, фиксированный размер', 
		'\picture\picture2.jpeg', 20, 15, 20),
		('Лопатка кондитерская', null, 
		'\picture\picture3.jpeg', 30, 15, 21),
		('Шоколад темный 100г', null, 
		'\picture\picture4.jpeg', 0, 16, 20),
		('Шоколад темный 200г', null, 
		null, 10, 16, 21),
		('Шоколад темный 100г', null, 
		null, 10, 16, 21),
		('Шоколад молочный, 100г', null, 
		'\picture\picture5.jpeg', 40, 16, 20),
		('Глазурь кондитерская, 100г', null, 
		null, 50, 16, 20),
		('Шоколад молочный, 50г', null, 
		null, 10, 16, 20),
		('Глазурь кондитерская, 100г', null, 
		null, 50, 16, 20)
returning *;

---update
update project_schema.products
set count = count+100
where name = 'Лопатка кондитерская'
returning count;

---select
---поиск шоколада в наличии на складе, расфасованного по 100г или 50г
select *
from project_schema.products 
where name similar to 'шоколад%(100|50)%' and count !=0;

---выборка наименований товаров в магазине с указанием категории
select cat.name,prod.name
from project_schema.categories cat inner join project_schema.products prod   
		on  cat.id = prod.categories_id;
		
---выборка всех категорий с указанием товаров в них, в т.ч. категории без товаров
select cat.name,prod.name
from project_schema.categories cat left join project_schema.products prod   
		on  cat.id = prod.categories_id;

---delete
--- удаление категории, в которой нет товаров
delete from project_schema.categories cat
	using project_schema.products prod
where not exists (
    select 1 
    from project_schema.products prod
    where cat.id = prod.categories_id)
returning cat.name;