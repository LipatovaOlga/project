use my_pr_new;

/* процедура по поиску */
drop procedure if exists proc_find;
delimiter //
create procedure proc_find(in text varchar(255), ctg varchar(255), sup varchar(255), sort smallint, l smallint)
begin
	select p.name, p.note, pr.price
	from products p
		inner join suppliers s on p.suppliers_id = s.id
		inner join price_history pr on p.id = pr.products_id
		inner join categories c on p.categories_id = c.id
	where match(p.name, p.note) against(text) 
		and s.info->>'$.name' = sup
		and c.name = ctg
		and pr.end_date is null
	order by 
		case when sort = 1
			then p.name end,
		case when sort = 2
			then p.name end desc,
		case when sort = 3
			then pr.price end,
		case when sort = 4
			then pr.price end desc
	limit l;
end;
//
delimiter ;

/* вызов */
call proc_find('шоколад 100', 'Продукты', 'поставщик 1', 4, 10);

/* процедура - отчет*/
drop procedure if exists get_orders;
delimiter //
create procedure get_orders(in d smallint, gr smallint)
begin 
	select case
		when gr = 1
			then p.name
		when gr = 2
			then c.name
	end as 'Группировка', sum(or_d.count) 
	from categories c
		inner join products p on p.categories_id = c.id
		inner join order_details or_d on or_d.products_id = p.id
		inner join orders ors on ors.id = or_d.orders_id
		inner join suppliers s on p.suppliers_id = s.id
	where ors.order_date > now() - interval d day
	group by case 
			when gr = 1 then p.name
			when gr = 2 then c.name
		end;
end;
//
delimiter ;

/* вызов */
call get_orders(365, 1);

/* создание пользователей */
create user 'client'@'localhost' identified by '123';
create user 'manager'@'localhost' identified by '123';

/* наделение правами */
grant execute on procedure proc_find to 'client'@'localhost';
grant execute on procedure get_orders to 'manager'@'localhost';