BEGIN;
INSERT INTO customers (name, email) VALUES ('Test User', 'test@example.com');
INSERT INTO orders (customer_id, total_amount, status)
    VALUES (LAST_INSERT_ID(), 999.99, 'pending');
COMMIT;