/* формирование корзины в интернет-магазине */
explain select 	p.name as 'Наименование', od.count as 'Количество', pr.price as 'Цена', (od.count * pr.price) as 'Сумма'
from orders o 
		inner join order_details od on o.id = od.orders_id
		inner join users u on o.users_id = u.id
		inner join products p on od.products_id = p.id
		inner join price_history pr on p.id = pr.products_id
where 	u.username = 'Иван' 
		and o.order_number = 1
		and pr.end_date is null;
+----+-------------+-------+------------+--------+---------------------+----------+---------+--------------------------+------+----------+--------------------------------------------+
| id | select_type | table | partitions | type   | possible_keys       | key      | key_len | ref                      | rows | filtered | Extra                                      |
+----+-------------+-------+------------+--------+---------------------+----------+---------+--------------------------+------+----------+--------------------------------------------+
|  1 | SIMPLE      | u     | NULL       | const  | PRIMARY,id,username | username | 1023    | const                    |    1 |   100.00 | Using index                                |
|  1 | SIMPLE      | pr    | NULL       | ALL    | NULL                | NULL     | NULL    | NULL                     |    7 |    14.29 | Using where                                |
|  1 | SIMPLE      | p     | NULL       | eq_ref | PRIMARY,id          | PRIMARY  | 8       | my_pr_new.pr.products_id |    1 |   100.00 | Using where                                |
|  1 | SIMPLE      | od    | NULL       | ALL    | NULL                | NULL     | NULL    | NULL                     |   12 |    10.00 | Using where; Using join buffer (hash join) |
|  1 | SIMPLE      | o     | NULL       | eq_ref | PRIMARY,id          | PRIMARY  | 8       | my_pr_new.od.orders_id   |    1 |    33.33 | Using where                                |
+----+-------------+-------+------------+--------+---------------------+----------+---------+--------------------------+------+----------+--------------------------------------------+
5 rows in set, 1 warning (0.07 sec)

/* создание индекса Номер заказа - Id пользователя*/
create index index_or_num_us on orders (order_number, users_id);

/* создание индекса Дата окончания действия цены */
create index index_date on price_history (end_date);

+----+-------------+-------+------------+--------+----------------------------+-----------------+---------+--------------------------+------+----------+--------------------------------------------+
| id | select_type | table | partitions | type   | possible_keys              | key             | key_len | ref                      | rows | filtered | Extra                                      |
+----+-------------+-------+------------+--------+----------------------------+-----------------+---------+--------------------------+------+----------+--------------------------------------------+
|  1 | SIMPLE      | u     | NULL       | const  | PRIMARY,id,username        | username        | 1023    | const                    |    1 |   100.00 | Using index                                |
|  1 | SIMPLE      | o     | NULL       | ref    | PRIMARY,id,index_or_num_us | index_or_num_us | 9       | const,const              |    1 |   100.00 | Using where; Using index                   |
|  1 | SIMPLE      | od    | NULL       | ALL    | NULL                       | NULL            | NULL    | NULL                     |   12 |    10.00 | Using where; Using join buffer (hash join) |
|  1 | SIMPLE      | p     | NULL       | eq_ref | PRIMARY,id                 | PRIMARY         | 8       | my_pr_new.od.products_id |    1 |   100.00 | Using where                                |
|  1 | SIMPLE      | pr    | NULL       | ref    | index_date                 | index_date      | 4       | const                    |    4 |    14.29 | Using index condition; Using where         |
+----+-------------+-------+------------+--------+----------------------------+-----------------+---------+--------------------------+------+----------+--------------------------------------------+
5 rows in set, 1 warning (0.04 sec)