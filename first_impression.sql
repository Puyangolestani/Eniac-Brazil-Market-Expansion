USE magist;
SELECT #How many orders are there in the dataset?
    COUNT(order_id)
FROM
    orders;
#SELECT DISTINCT(order_status) FROM orders ORDER BY  order_status  DESC; 
 SELECT #Are orders actually delivered? 
    order_status, COUNT(*) AS orders
FROM
    orders
GROUP BY order_status
; 
 SELECT #Is Magist having user growth?
    YEAR(order_purchase_timestamp) AS year_,
    MONTH(order_purchase_timestamp) AS month_
    ,COUNT(customer_id)
FROM
    orders
GROUP BY year_ , month_
ORDER BY year_ , month_; 

 SELECT #How many products are there on the products table? 
    COUNT(DISTINCT product_id) AS products_count
FROM
    products;
    
 SELECT #Which are the categories with the most products? 
    COUNT(DISTINCT product_id) AS n_products,
    product_category_name
FROM
    products
GROUP BY product_category_name
ORDER BY n_products DESC; 

 SELECT #How many of those products were present in actual transactions? 
	count(DISTINCT product_id) AS n_products
FROM
	order_items;

SELECT #What’s the price for the most expensive and cheapest products?
    MIN(price) AS cheapest, MAX(price) AS most_expensive
FROM
    order_items; 
    
SELECT # Maximum someone has paid for an order:
    ROUND(SUM(payment_value) , 2) AS highest_order
FROM
    order_payments GROUP BY order_id
ORDER BY highest_order DESC
LIMIT 1;

SELECT #Highest and lowest payment values:
	MAX(payment_value) as highest,
    MIN(payment_value) as lowest
FROM
	order_payments;
    




