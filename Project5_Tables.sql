-- Staging Tablosu Oluşturma

DROP TABLE IF EXISTS staging_cafe_sales;

CREATE TABLE staging_cafe_sales (
    transaction_id VARCHAR(50),
    item VARCHAR(100),
    quantity VARCHAR(50),
    price_per_unit VARCHAR(50),
    total_spent VARCHAR(50),
    payment_method VARCHAR(100),
    location VARCHAR(100),
    transaction_date VARCHAR(50)
);

-- CSV Dosyasından Veri Kopyalama

COPY staging_cafe_sales (
    transaction_id,
    item, quantity,
    price_per_unit, total_spent,
    payment_method,
    location,
    transaction_date)
FROM 'C:/Users/Enes/Desktop/dirty_cafe_sales.csv'
WITH (FORMAT CSV, HEADER TRUE, DELIMITER ',');

-- Temiz Verileri İçerecek Tabloyu Oluşturma

DROP TABLE IF EXISTS clean_cafe_sales;

CREATE TABLE clean_cafe_sales (
    transaction_id VARCHAR(50) PRIMARY KEY,
    item_name VARCHAR(100) NOT NULL,
    quantity INT NOT NULL,
    price_per_unit DECIMAL(10,2) NOT NULL,
    total_spent DECIMAL(10,2) NOT NULL,
    payment_method VARCHAR(50) DEFAULT 'Not Specified',
    location VARCHAR(50) DEFAULT 'Unknown',
    transaction_date DATE NOT NULL
);