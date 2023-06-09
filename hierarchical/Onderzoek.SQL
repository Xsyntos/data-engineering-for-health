--Verkrijg alle data:
SELECT * 
FROM f_product_sold AS product 
JOIN d_customer AS customer ON product.d_customer_id= customer.id
JOIN d_employee AS employee ON product.d_employee_id= employee.id
JOIN d_pos AS pos ON product.d_POS_id= pos.id
JOIN d_sku AS sku ON product.d_SKU_id= sku.id
JOIN d_catagory AS category ON sku.d_catagory_id=category.id
JOIN d_store AS store ON pos.d_store_id=store.id
JOIN d_area AS gebied ON store.d_area_id=gebied.id
JOIN d_function AS `function` ON employee.d_function_id=`function`.id
JOIN d_postalcode AS postalcode ON customer.d_postalcode_id=postalcode.id
--duur van de query: 0,016 sec

--Het aantal verkochte producten per gebied:
SELECT SUM(product.quantity), gebied.name
FROM f_product_sold AS product 
JOIN d_pos AS pos ON product.d_POS_id= pos.id
JOIN d_store AS store ON pos.d_store_id=store.id
JOIN d_area AS gebied ON store.d_area_id=gebied.id
GROUP BY gebied.name
--duur van de query: 0,016 sec

--De totale omzet van de functie cashier:
SELECT SUM(product.price_total) AS "totale omzet", `function`.`function`
FROM f_product_sold AS product 
JOIN d_employee AS employee ON product.d_employee_id= employee.id
JOIN d_function AS `function` ON employee.d_function_id=`function`.id
WHERE `function`.`function`='cashier'
GROUP BY `function`.`function`
--duur van de query: 0,015 sec

--Het toevoegen van een nieuw verkochte product waarbij iedere attribute/dimensie nieuw is
INSERT INTO `d_area` (`id`, `name`, `lon`, `lat`) VALUES (3, 'Amsterdam', 4.8951679, 52.3702157);
INSERT INTO `d_store` (`id`, `name`, `d_area_id`) VALUES (5, 'Appie to Go', 3);
INSERT INTO `d_pos` (`id`, `name`, `d_store_id`) VALUES (8, 'zelfscan1', 5);

INSERT INTO `d_catagory` (`id`, `catagory`) VALUES (5, 'cheese');
INSERT INTO `d_sku` (`id`, `product_name`, `hasUPC`, `UPC`, `d_catagory_id`) VALUES (7, 'Old Amsterdam kaas', 0, NULL, 5);

INSERT INTO `d_postalcode` (`id`, `postalcode`) VALUES (3, '5647HS');
INSERT INTO `d_customer` (`id`, `firstname`, `surname`, `IBAN`, `d_postalcode_id`) VALUES (4, 'Anja', 'van der Broek', NULL, 3);

INSERT INTO `d_function` (`id`, `function`) VALUES (4, 'department manager');
INSERT INTO `d_employee` (`id`, `firstname`, `surname`, `d_function_id`) VALUES (5, 'Sophie', 'de Vries', 4);

INSERT INTO `f_product_sold` (`id`, `price_total`, `quantity`, `d_SKU_id`, `d_customer_id`, `d_Employee_id`, `d_POS_id`) VALUES (8, 25, 10, 7, 4, 5, 8);

--duur van de query: 1,328 sec 

--Het toevoegen van een verkocht product waarbij iedere attribute/dimensie al bestaat
--Kan niet

--Het verwijderen van een verkocht product
DELETE FROM `f_product_sold` WHERE `id`=9
--duur van de query: 0,109 sec

--update
UPDATE `f_product_sold` SET `id`=7, `price_total`=25, `quantity`=10, `d_sku_id`=1, `d_employee_id`=3, `d_customer_id`=3, `d_pos_id`=4 WHERE `id`=7;


