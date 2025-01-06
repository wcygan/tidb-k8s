SELECT
    c.name,
    o.order_id,
    COUNT(oi.item_id) as items_count,
    SUM(oi.quantity * oi.unit_price) as calculated_total
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY c.name, o.order_id
HAVING calculated_total > 100;