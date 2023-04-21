--Verkrijg alle data:
SELECT * 
FROM f_product_sold AS product 
JOIN d_customer AS customer ON product.customer_id= customer.id
JOIN d_employee AS employee ON product.Employee_id= employee.id
JOIN d_pos AS pos ON product.POS_id= pos.id
JOIN d_sku AS sku ON product.SKU_id= sku.id
JOIN d_catagory AS category ON sku.catagory_id=category.id
JOIN d_store AS store ON pos.store_id=store.id
JOIN d_area AS gebied ON store.area_id=gebied.id
JOIN d_function AS `function` ON employee.function_id=`function`.id
JOIN d_postalcode AS postalcode ON customer.postalcode_id=postalcode.id
--duur van de query: 0,625 sec

--Het aantal verkochte producten per gebied:
SELECT SUM(product.quantity), gebied.name
FROM f_product_sold AS product 
JOIN d_pos AS pos ON product.POS_id= pos.id
JOIN d_store AS store ON pos.store_id=store.id
JOIN d_area AS gebied ON store.area_id=gebied.id
GROUP BY gebied.name
--duur van de query: 0,017 sec

--De totale omzet van de functie cashier:
SELECT SUM(product.price_total) AS "totale omzet", `function`.`function`
FROM f_product_sold AS product 
JOIN d_employee AS employee ON product.Employee_id= employee.id
JOIN d_function AS `function` ON employee.function_id=`function`.id
WHERE `function`.`function`='cashier'
GROUP BY `function`.`function`
--duur van de query: 0,032 sec

--Het toevoegen van een nieuw verkochte product waarbij iedere attribute/dimensie nieuw is
INSERT INTO `d_area` (`id`, `name`, `lon`, `lat`) VALUES (3, 'Amsterdam', 4.8951679, 52.3702157);
INSERT INTO `d_store` (`id`, `name`, `area_id`) VALUES (5, 'Appie to Go', 3);
INSERT INTO `d_pos` (`id`, `name`, `store_id`) VALUES (8, 'zelfscan1', 5);

INSERT INTO `d_catagory` (`id`, `catagory`) VALUES (5, 'cheese');
INSERT INTO `d_sku` (`id`, `product_name`, `hasUPC`, `UPC`, `catagory_id`) VALUES (7, 'Old Amsterdam kaas', 0, NULL, 5);

INSERT INTO `d_postalcode` (`id`, `postalcode`) VALUES (3, '5647HS');
INSERT INTO `d_customer` (`id`, `firstname`, `surname`, `IBAN`, `postalcode_id`) VALUES (4, 'Anja', 'van der Broek', NULL, 3);

INSERT INTO `d_function` (`id`, `function`) VALUES (4, 'department manager');
INSERT INTO `d_employee` (`id`, `firstname`, `surname`, `function_id`) VALUES (5, 'Sophie', 'de Vries', 4);

INSERT INTO `f_product_sold` (`id`, `price_total`, `quantity`, `SKU_id`, `customer_id`, `Employee_id`, `POS_id`) VALUES (8, 25, 10, 7, 4, 5, 8);
--duur van de query: 1,938 sec 

--Het toevoegen van een verkocht product waarbij iedere attribute/dimensie al bestaat
INSERT INTO `f_product_sold` (`id`, `price_total`, `quantity`, `SKU_id`, `customer_id`, `Employee_id`, `POS_id`) VALUES (9, 10, 6, 7, 3, 2, 8);
--duur van de query: 0,922 sec

--Het verwijderen van een verkocht product
DELETE FROM `f_product_sold` WHERE `id`=9
--duur van de query: 0,110 sec

