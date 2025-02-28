USE magist; 
SELECT 
    product_size, 
    COUNT(*) AS late_delivery_count,
    subquery.product_category_name,  -- Specify table alias
    pc.product_category_name_english,
    COUNT(DISTINCT subquery.product_id) AS products_count  -- Specify table alias
FROM
    (SELECT 
        CASE 
            WHEN o.order_delivered_customer_date > o.order_estimated_delivery_date THEN 'out of control'
            ELSE 'In control'
        END AS delivered_on_time,
        CASE 
            WHEN p.product_length_cm > 30 AND p.product_weight_g > 2276 AND p.product_height_cm > 17 THEN 'Large'
            WHEN p.product_length_cm BETWEEN 7 AND 30 AND p.product_weight_g BETWEEN 2 AND 2276 AND p.product_height_cm BETWEEN 2 AND 17 THEN 'Medium'
            ELSE 'Small'
        END AS product_size,
        p.product_id,
        p.product_category_name  -- Keep this for join with translation table
    FROM orders AS o
    LEFT JOIN order_items AS oi USING (order_id)
    LEFT JOIN products AS p USING (product_id)) subquery
LEFT JOIN product_category_name_translation AS pc 
   USING(product_category_name)
WHERE 
    delivered_on_time = 'out of control'
    AND pc.product_category_name_english IN ('computers_accessories', 
        'watches_gifts', 'telephony',
        'electronics',
        'consoles_games',
        'audio', 'dvds_blu_ray',
        'computers',
        'tablets_printing_image',
        'pc_gamer',
        'cds_dvds_musicals')
GROUP BY product_size, subquery.product_category_name, pc.product_category_name_english
ORDER BY products_count DESC ,  late_delivery_count DESC;
