/* выборка всех товаров, по которым заведены цены */
select distinct(prod.name) 
from products prod inner join price_history price
	on price.products_id = prod.id
group by prod.name;

/* выборка данных о поставщиках с указанием их товаров в магазине, в т.ч. поставщиков, которые не осуществляли поставки */
select * 
from suppliers s left join products p 
	on s.id = p.suppliers_id;

/* количество изменений цены по товару 'Кольцо для выпечки' */
select count(*)
from products prod inner join price_history price
	on price.products_id = prod.id
where prod.name= 'Кольцо для выпечки';

/* выборка минимальных цен на товары в магазине */
select prod.name, min(pr.price)
from products prod inner join price_history pr
	on pr.products_id = prod.id
group by pr.products_id;

/* выборка товаров без фото в карточке товара */
select name
from products
where picture is null;

/* количество позиций шоколада на складе */
select sum(count)
from products
where name like 'Шоколад%';

/* товары в категории 'Посуда', доступные к заказу (с ненулевым количеством на складе) */
select p.name
from categories c inner join products p 
	on p.categories_id = c.id
where c.name = 'Посуда' and count !=0;






