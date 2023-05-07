--Verkrijg alle data:
SELECT * FROM L_product_sold
JOIN H_customer AS c ON H_employee_id=c.id
JOIN S_customer_details AS cd ON c.S_customer_details_id=cd.id
JOIN S_postalcode AS pc ON c.S_postalcode_id=pc.id

JOIN H_employee AS e ON H_employee_id=e.id
JOIN S_employee_details AS ed ON e.S_employee_details_id=ed.id
JOIN S_function AS f ON e.S_function_id=f.id

JOIN H_order_details AS o ON o.id=H_order_details_id
JOIN S_receipt AS r ON r.id=o.S_receipt_id

JOIN H_pos AS p ON p.id=H_pos_id
JOIN S_pos_detail AS pd ON pd.id=p.S_pos_detail_id
JOIN S_area AS a ON a.id=p.S_area_id
JOIN S_shop AS s ON p.S_shop_id=s.id
--duur van de query: 0,328 sec

--Het aantal verkochte producten per gebied:
SELECT SUM(r.quantity), a.name FROM L_product_sold

JOIN H_order_details AS o ON o.id=H_order_details_id
JOIN S_receipt AS r ON r.id=o.S_receipt_id

JOIN H_pos AS p ON p.id=H_pos_id
JOIN S_area AS a ON a.id=p.S_area_id
GROUP BY a.name

--duur van de query: 0,016 sec

--De totale omzet van de functie cashier:

--duur van de query: 0,015 sec

--Het toevoegen van een nieuw verkochte product waarbij iedere attribute/dimensie nieuw is


--duur van de query: 1,530 sec 

--Het toevoegen van een verkocht product waarbij iedere attribute/dimensie al bestaat
--duur van de query: 0,225 sec

--Het verwijderen van een verkocht product
--duur van de query: 0,359 sec

--Het updaten van een fact


