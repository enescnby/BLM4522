-- Tabloyu Oluşturma

DROP TABLE IF EXISTS performance_test;

CREATE TABLE performance_test (
    id SERIAL PRIMARY KEY,
    customer_name VARCHAR(100),
    order_amount DECIMAL(10,2),
    order_status VARCHAR(50),
    order_date TIMESTAMP
);

-- 500.000 Satırlık Rastgele Veri Üretme ve Tabloya Yazma

INSERT INTO performance_test (
    customer_name,
    order_amount,
    order_status,
    order_date)
SELECT
    'Customer_' || i AS customer_name,
    (random() * 1000)::DECIMAL(10,2) AS order_amount,
    (ARRAY['Completed', 'Pending', 'Cancelled', 'Shipped'])
    [floor(random() * 4) + 1] AS order_status,
    NOW() - (random() * INTERVAL '365 days') AS order_date
FROM generate_series(1, 500000) s(i);

-- Analiz ve Index Scriptleri

EXPLAIN ANALYZE
SELECT * FROM performance_test
WHERE customer_name = 'Customer_452200';

CREATE INDEX idx_performance_customer_name
ON performance_test(customer_name);

EXPLAIN ANALYZE
SELECT * FROM performance_test
WHERE order_status = 'Completed'
ORDER BY order_date DESC LIMIT 100;

CREATE INDEX idx_status_date
ON performance_test(order_status, order_date DESC);