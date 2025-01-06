CREATE DATABASE IF NOT EXISTS tidb_test;
USE tidb_test;

CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status ENUM('active', 'inactive', 'suspended') DEFAULT 'active'
);

CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total_amount DECIMAL(10,2),
    status VARCHAR(20),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE order_items (
    item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    product_name VARCHAR(100),
    quantity INT,
    unit_price DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

INSERT INTO customers (name, email) VALUES
    ('John Doe', 'john@example.com'),
    ('Jane Smith', 'jane@example.com'),
    ('Bob Wilson', 'bob@example.com'),
    ('Alice Brown', 'alice@example.com');

INSERT INTO orders (customer_id, total_amount, status) VALUES
    (1, 150.00, 'completed'),
    (2, 250.50, 'pending'),
    (1, 75.25, 'completed'),
    (3, 420.00, 'processing');

INSERT INTO order_items (order_id, product_name, quantity, unit_price) VALUES
    (1, 'Widget A', 2, 25.00),
    (1, 'Widget B', 1, 100.00),
    (2, 'Widget C', 5, 50.10),
    (3, 'Widget A', 3, 25.25),
    (4, 'Widget D', 4, 105.00);