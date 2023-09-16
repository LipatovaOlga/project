/* обновление количества товара и установка новой цены, начиная с сегодняшнего дня */
delimiter //
create procedure update_count_price(in id_p integer, c integer, p decimal(10,2))
begin
	update products
		set count = count + c
		where id = id_p;
	insert into price_history (price, begin_date, products_id) 
		values (p, curdate(), id_p);
end
//
delimiter ;

/* создание таблицы и загрузка из csv */
create table test_load (
	Handle text,
	Title text,
	Body text,
	Vendor text,
	Type text,
	Tags text,
	Published text,
	Option1_Name text,
	Option1_Value text,
	Option2_Name text,
	Option2_Value text,
	Option3_Name text,
	Option3_Value text,
	Variant_SKU text,
	Variant_Grams text,
	Variant_Inventory_Tracker text,
	Variant_Inventory_Qty text,
	Variant_Inventory_Policy text,
	Variant_Fulfillment_Service text,
	Variant_Price text,
	Variant_Compare_At_Price text,
	Variant_Requires_Shipping text,
	Variant_Taxable text,
	Variant_Barcode text,
	Image_Src text,
	Image_Alt_Text text,
	Gift_Card text,
	SEO_Title text,
	SEO_Description text,
	Google_Product_Category text,
	Gender text,
	Age_Group text,
	MPN text,
	AdWords_Grouping text,
	AdWords_Labels text,
	Condition_t text,
	Custom_Product text,
	Label_0 text,
	Label_1 text,
	Label_2 text,
	Label_3 text,
	Label_4 text,
	Variant_Image text,
	Variant_Weight_Unit text
);
load data infile 'C:\\ProgramData\\MySQL\\MySQL Server 8.1\\Uploads\\Apparel_copy.csv'
	into table test_load
	fields terminated by ','
	lines terminated by '\n'
	(Handle,
	Title,
	Body,
	Vendor,
	Type,
	Tags,
	Published,
	Option1_Name,
	Option1_Value,
	Option2_Name,
	Option2_Value,
	Option3_Name,
	Option3_Value,
	Variant_SKU,
	Variant_Grams,
	Variant_Inventory_Tracker,
	Variant_Inventory_Qty,
	Variant_Inventory_Policy,
	Variant_Fulfillment_Service,
	Variant_Price,
	Variant_Compare_At_Price,
	Variant_Requires_Shipping,
	Variant_Taxable,
	Variant_Barcode,
	Image_Src,
	Image_Alt_Text,
	Gift_Card,
	SEO_Title,
	SEO_Description,
	Google_Product_Category,
	Gender,
	Age_Group,
	MPN,
	AdWords_Grouping,
	AdWords_Labels,
	Condition_t,
	Custom_Product,
	Label_0,
	Label_1,
	Label_2,
	Label_3,
	Label_4,
	Variant_Image,
	Variant_Weight_Unit)
;