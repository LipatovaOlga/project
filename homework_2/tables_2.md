Интернет-магазин товаров для кондитера. Таблицы:

1. **products - товары**

   - Реквизиты:

     - [ ] id - идентификатор *PK*

     - [ ] name - наименование *NOT NULL*

     - [ ] note - описание товара

     - [ ] picture - фотография товара

     - [ ] count - количество на складе *NOT NULL CHECK (>=0)*

     - [ ] categories.id - id таблицы categories *FK*

     - [ ] suppliers.id - id таблицы suppliers *FK*

   * *Простой индекс: categories.id. Нужен для быстрого поиска товаров внутри категории*

2. **categories - категории товаров**

   - Реквизиты:

     - [ ] id - идентификатор *PK*

     - [ ] name - наименование категории *NOT NULL*

3. **price_history - история изменения цен на товары**

   - Реквизиты:

     - [ ] id - идентификатор *PK*

     - [ ] price - цена за единицу товара в рублях *NOT NULL CHECK (>0)*

     - [ ] begin_date - дата начала действия цены *NOT NULL DEFAULT*

     - [ ] products.id - id таблицы products *FK*

   - *Композитный индекс: (products.id, begin_date, price). Нужен для быстрого поиска цены за товар на дату*

4. **suppliers - поставщики**

   - Реквизиты:

     - [ ] id - идентификатор *PK*

     - [ ] name - наименование поставщика *NOT NULL*

     - [ ] phone - телефон

5. **users _ пользователи**

   - Реквизиты

     - [ ] id - идентификатор *PK*

     - [ ] username - имя пользователя *NOT NULL UNIQUE*

     - [ ] name - наименование

     - [ ] registratration_date - дата регистрации в магазине *NOT NULL DEFAULT*

6. **orders - заказы**

   - Реквизиты:

     - [ ] id - идентификатор *PK*

     - [ ] order_date - дата оформления заказа *NOT NULL DEFAULT*

     - [ ] order_number - номер заказа *NOT NULL SEQUENCE*

     - [ ] users.id - id таблицы users *FK*

     - [ ] discounts.id - id таблицы discounts *FK* *DEFAULT*

   - *Композитный индекс: (users.id, order_date). Нужен для быстрого построения истории заказов клиента магазина*

7. **order_details - детали заказа**

   - Реквизиты:

     - [ ] id - идентификатор *PK*

     - [ ] products.id - id таблицы products *FK*

     - [ ] count - количество *NOT NULL CHECK (>0)*

     - [ ] orders.id - id таблицы orders *FK*

8. **discounts - скидки**

   - Реквизиты:

     - [ ] id - идентификатор *PK*

     - [ ] persent - процент *NOT NULL CHECK (>=0 и <100)*