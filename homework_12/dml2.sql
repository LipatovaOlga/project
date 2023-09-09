/* информация о доступности единиц товара для заказа */
select name as 'Наименование товара', 
case
	when count = 0
        then 'Товар отсутствует'
    when count <= 5
        then 'Товар заканчивается'
    when count > 5 and count <=10
        then 'Мало товара'
    when count > 10 and count <=50
        then 'Есть в наличии'
    else 'Много товара'
end as 'Наличие'
from products;

/* выборка поставщиков, которые поставили в магазин более 1 наименования товара */
select info->>'$.name'
from suppliers s 
	inner join products p on p.suppliers_id = s.id
group by p.suppliers_id
having count(*) > 1;

/* выборка количества товаров в магазине в каждой категории с итогом */
select case
	when c.name is null
		then 'Итого'
	else c.name
end as 'Категория', sum(count) as 'Количество единиц товаров'
from categories c 
	inner join products p on c.id = p.categories_id
group by c.name with rollup;

/* выборка количества товаров в магазине в каждой категории с итогом количества
по всему магазину и подитогами внутри каждой категории */
select categories_id, name, sum(count) as sum, grouping(categories_id), grouping(name)
from products
group by categories_id, name 
	with rollup;

/* выборка с самым дорогим и самым дешевым товаром в каждой категории и внутри каждого товара*/
select c.name, p.name, max(pr.price), min(pr.price)
from categories c 
	inner join products p on c.id = p.categories_id
	inner join price_history pr on p.id = pr.products_id
group by c.name, p.name
	with rollup;
