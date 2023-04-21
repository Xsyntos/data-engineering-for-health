--Getting All the data:

SELECT * FROM f_product_sold AS product 
JOIN d_area AS gebied ON product.Area_id= gebied.id
JOIN d_customer AS customer ON product.customer_id= customer.id
JOIN d_employee AS employee ON product.Employee_id= employee.id
JOIN d_pos AS pos ON product.POS_id= pos.id
JOIN d_sku AS sku ON product.SKU_id= sku.id
--Duration on test database: 