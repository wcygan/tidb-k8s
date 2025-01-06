SELECT
    c.name,
    o.order_id,
    o.total_amount,
    o.status
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
WHERE o.total_amount > 100;