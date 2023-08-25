ddl_old.txt - cоздание БД - аналога БД из pg
ddl_new.txt - создание БД после вебинара

1. Все id -> тип serial 
(цель: авто последовательность)

2. Таблица "Скидки": 
persent integer check (persent>0 and persent<100) 
	-> persent tinyint unsigned check (persent<100)
(цель: оптимальное хранение)

3. Таблица "Товары": 
count integer not null check (count>=0)
	-> count integer unsigned not null
(цель: оптимальное хранение, увеличение размера для хранения)

4. Таблица "История цен": 
price integer not null check (price>0)
	-> price decimal(10,2) unsigned not null
(цель: оптимальное хранение)

5. Таблица "Детали заказа": 
count integer not null check (count>0)
	-> count integer unsigned not null
(цель: оптимальное хранение, увеличение размера для хранения)

6. Таблица "Поставщики":
create table suppliers (
	id integer primary key,
	name varchar(255) not null,
	phone varchar(255)
);
	->
	create table suppliers (
		id serial primary key,
		info json not null
	);

insert into suppliers (info) values 
	('{"name": "Поставщик 1", "phone": "235-85-74"}'),
	('{"name": "Поставщик 2", "phone": "147852"}'),
	('{"name": "Поставщик 3", "phone": "89131478596"}');
(использование json)