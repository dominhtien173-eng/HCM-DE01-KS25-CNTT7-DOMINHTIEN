SET SQL_SAFE_UPDATES = 0;

DROP DATABASE IF EXISTS SalesManagement;
CREATE DATABASE SalesManagement;
USE SalesManagement;

CREATE TABLE Product (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL,
    hang_san_xuat VARCHAR(100),
    price DECIMAL(12,2),
    stock_quantity INT
);

CREATE TABLE Customer (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(255),
    email VARCHAR(255),
    phone VARCHAR(20),
    address VARCHAR(255)
);

CREATE TABLE Orders (
    order_id VARCHAR(10) PRIMARY KEY,
    order_date DATE,
    total_amount DECIMAL(12,2),
    customer_id INT,
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
);

CREATE TABLE Order_Detail (
    order_id VARCHAR(10),
    product_id INT,
    quantity INT,
    price_at_time DECIMAL(12,2),
    PRIMARY KEY (order_id, product_id),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Product(product_id)
);

ALTER TABLE Orders ADD note TEXT;

ALTER TABLE Product CHANGE COLUMN hang_san_xuat nha_san_xuat VARCHAR(100);

INSERT INTO Product (product_name, nha_san_xuat, price, stock_quantity) VALUES
('MacBook Air M2', 'Apple', 25000000, 10),
('iPhone 14', 'Apple', 20000000, 15),
('Dell XPS 13', 'Dell', 22000000, 8),
('Asus ROG', 'Asus', 30000000, 5),
('Logitech Mouse', 'Logitech', 500000, 50);

INSERT INTO Customer (full_name, email, phone, address) VALUES
('Nguyen Van A', 'a@gmail.com', '0123456789', 'HN'),
('Tran Thi B', 'b@gmail.com', NULL, 'HCM'),
('Le Van C', 'c@gmail.com', '0987654321', 'DN'),
('Pham Thi D', 'd@gmail.com', '0111111111', 'HP'),
('Hoang Van E', 'e@gmail.com', NULL, 'CT');

INSERT INTO Orders (order_id, order_date, total_amount, customer_id) VALUES
('SST1', '2024-01-01', 45000000, 1),
('SST2', '2024-01-02', 20000000, 2),
('SST3', '2024-01-03', 30000000, 3),
('SST4', '2024-01-04', 500000, 4),
('SST5', '2024-01-05', 25000000, 1);

INSERT INTO Order_Detail (order_id, product_id, quantity, price_at_time) VALUES
('SST1', 1, 1, 25000000),
('SST2', 2, 1, 20000000),
('SST3', 2, 1, 20000000),
('SST4', 4, 1, 30000000),
('SST5', 5, 1, 500000);

UPDATE Product
SET price = price * 1.1
WHERE nha_san_xuat = 'Apple';

DELETE od FROM Order_Detail od
JOIN Orders o ON od.order_id = o.order_id
JOIN Customer c ON o.customer_id = c.customer_id
WHERE c.phone IS NULL;

DELETE o FROM Orders o
JOIN Customer c ON o.customer_id = c.customer_id
WHERE c.phone IS NULL;

DELETE FROM Customer
WHERE phone IS NULL;

SET SQL_SAFE_UPDATES = 1;

SELECT *
FROM Product
WHERE price BETWEEN 10000000 AND 20000000;

SELECT p.product_name
FROM Product p
JOIN Order_Detail od ON p.product_id = od.product_id
WHERE od.order_id = 'SST1';

SELECT DISTINCT c.full_name
FROM Customer c
JOIN Orders o ON c.customer_id = o.customer_id
JOIN Order_Detail od ON o.order_id = od.order_id
JOIN Product p ON od.product_id = p.product_id
WHERE p.product_name = 'MacBook Air M2';