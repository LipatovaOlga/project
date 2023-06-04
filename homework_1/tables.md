Интернет-магазин товаров для кондитера. Таблицы:

1. **products - товары**
   - [ ] id - идентификатор
   - [ ] name - наименование
   - [ ] note - описание товара
   - [ ] picture - фотография товара
   - [ ] count - количество на складе
   - [ ] categories.id - id таблицы categories
   - [ ] suppliers.id - id таблицы suppliers
2. **categories - категории товаров**
   - [ ] id - идентификатор
   - [ ] name - наименование категории
3. **price_history - история изменения цен на товары**
   - [ ] id - идентификатор
   - [ ] price - цена за единицу товара в рублях
   - [ ] begin_date - дата начала действия цены
   - [ ] products.id - id таблицы products
4. **suppliers - поставщики**
   - [ ] id - идентификатор
   - [ ] name - наименование поставщика
   - [ ] phone - телефон
5. **users _ пользователи**
   - [ ] id - идентификатор
   - [ ] username - имя пользователя
   - [ ] name - наименование
   - [ ] registratration_date - дата регистрации в магазине
6. **orders - заказы**
   - [ ] id - идентификатор
   - [ ] order_date - дата оформления заказа
   - [ ] order_number - номер заказа
   - [ ] users.id - id таблицы users
   - [ ] discounts.id - id таблицы discounts
7. **order_details - детали заказа**
   - [ ] id - идентификатор
   - [ ] products.id - id таблицы products
   - [ ] count - количество
   - [ ] orders.id - id таблицы orders
8. **discounts - скидки**
   - [ ] id - идентификатор
   - [ ] persent - процент