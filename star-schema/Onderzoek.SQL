--Verkrijg alle data:

SELECT * FROM f_product_sold AS product 
JOIN d_area AS gebied ON product.Area_id= gebied.id
JOIN d_customer AS customer ON product.customer_id= customer.id
JOIN d_employee AS employee ON product.Employee_id= employee.id
JOIN d_pos AS pos ON product.POS_id= pos.id
JOIN d_sku AS sku ON product.SKU_id= sku.id
--duur van de query: 0,032 sec

--Het aantal verkochte producten per gebied:
SELECT SUM(product.quantity) AS "totaal verkochte producten", gebied.name FROM f_product_sold AS product 
JOIN d_area AS gebied ON product.Area_id= gebied.id
GROUP BY gebied.name
--duur van de query: 0,016 sec

--De totale omzet van de functie cashier:
SELECT SUM(product.quantity) AS "totaal verkochte producten", gebied.name FROM f_product_sold AS product 
JOIN d_area AS gebied ON product.Area_id= gebied.id
GROUP BY gebied.name
--duur van de query: 0,016 sec

