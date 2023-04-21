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
--duur van de query: 0,328 sec

--Het aantal verkochte producten per gebied:
SELECT SUM(product.quantity) AS "totaal verkochte producten", gebied.name 
FROM f_product_sold AS product 
JOIN d_area AS gebied ON product.Area_id= gebied.id
GROUP BY gebied.name
--duur van de query: 0,016 sec

--De totale omzet van de functie cashier:
SELECT SUM(product.price_total) AS "totale omzet", employee.function
FROM f_product_sold AS product 
JOIN d_employee AS employee ON product.Employee_id=employee.id
WHERE employee.function = "cashier"
GROUP BY employee.function
--duur van de query: 0,016 sec

--Het toevoegen van een nieuw verkochte product waarbij iedere attribute/dimensie nieuw is
INSERT INTO `d_area` (`id`, `name`, `lon`, `lat`) VALUES (3, 'Amsterdam', 4.8951679, 52.3702157);
INSERT INTO `d_customer` (`id`, `firstname`, `surname`, `IBAN`, `postalcode`) VALUES (5, 'Anja', 'van der Broek', NULL, '2675BL');
INSERT INTO `d_employee` (`id`, `firstname`, `surname`, `function`) VALUES (5, 'Sophie', 'de Vries', 'cashier');
INSERT INTO `d_pos` (`id`, `store`, `location`, `name`) VALUES (6, 'Appie to go', 'Amsterdam', 'Zelfscan1');
INSERT INTO `d_sku` (`id`, `product_name`, `hasUPC`, `UPC`, `category`) VALUES (7, 'Old Amsterdam kaas', 0, NULL, 'cheese');
INSERT INTO `f_product_sold` (`id`, `price_total`, `quantity`, `SKU_id`, `POS_id`, `Area_id`, `customer_id`, `Employee_id`) VALUES (27, 25, 10, 7, 6, 3, 5, 5);
--duur van de query: 0,702 sec 

--Het toevoegen van een verkocht product waarbij iedere attribute/dimensie al bestaat
INSERT INTO `f_product_sold` (`id`, `price_total`, `quantity`, `SKU_id`, `POS_id`, `Area_id`, `customer_id`, `Employee_id`) VALUES (28, 25, 10, 7, 6, 3, 5, 5);
--duur van de query: 0,062 sec

--Het verwijderen van een verkocht product
DELETE FROM `f_product_sold` WHERE `id`=28;
--duur van de query: 0,078 sec

