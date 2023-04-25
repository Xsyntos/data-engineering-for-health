--Verkrijg alle data:
SELECT * FROM product_sold
--duur van de query: 0,010 sec

--Het aantal verkochte producten per gebied:
SELECT SUM(quantity), `area` 
FROM product_sold
GROUP BY (`area`)
--duur van de query: 0,017 sec

--De totale omzet van de functie cashier:
SELECT SUM(price_total) AS 'Totale omzet', `employee_function` 
FROM product_sold
WHERE `employee_function`= 'cashier'
GROUP BY (`employee_function`)
--duur van de query: 0,017 sec

--Het toevoegen van een nieuw verkochte product waarbij iedere attribute/dimensie nieuw is
INSERT INTO `product_sold` (`id`, `price_total`, `quantity`, `pos`, `store`, `area`, `area_lon`, `area_lat`, `employee_firstname`, `employee_surname`, `employee_function`, `customer_firstname`, `customer_surname`, `customer_iban`, `customer_postalcode`, `product_name`, `product_has_upc`, `product_upc`, `product_category`) VALUES (7, 100, 52, 'zelfscan kassa1', 'Dirk van der Broek', 'Den Haag', 2.5235623, 5.352643, 'Ryan', 'Rietberg', 'cashier', 'Jose', 'Anders', NULL, '5325BS', 'salami', 0, NULL, 'worst');
--duur van de query: 0,359 sec 

--Het toevoegen van een verkocht product waarbij iedere attribute/dimensie al bestaat
-- kan niet

--Het verwijderen van een verkocht product
DELETE FROM `product_sold` WHERE `id`=7;
--duur van de query: 0,156 sec

--update
UPDATE `product_sold` SET `id`=5, `price_total`=3, `quantity`=1, `pos`='service balie', `store`='plus', `area`='Groningen', `area_lon`=2.5235626, `area_lat`=5.21623, `employee_firstname`='Jeroen', `employee_surname`='de Brug', `employee_function`='clerk', `customer_firstname`='Anja', `customer_surname`='de Put', `customer_iban`=NULL, `customer_postalcode`='3261AB', `product_name`='bloemkool', `product_has_upc`=0, `product_upc`=NULL, `product_category`='vegables' WHERE `id`=5;

