-- Veri Temizleme Scripti

INSERT INTO clean_cafe_sales (
    transaction_id, item_name, quantity, price_per_unit, total_spent, payment_method, location, transaction_date
)
SELECT
    TRIM(transaction_id) AS transaction_id,


    INITCAP(TRIM(COALESCE(
        NULLIF(NULLIF(NULLIF(item, 'ERROR'), 'UNKNOWN'), ''),
        'Unknown Item'
    ))) AS item_name,


    CASE
        WHEN quantity ~ '^[0-9]+$' THEN quantity::INT
        ELSE 1
    END AS quantity,


    CASE
        WHEN price_per_unit ~ '^[0-9]+(\.[0-9]+)?$' THEN price_per_unit::DECIMAL(10,2)
        ELSE 0.00
    END AS price_per_unit,


    CASE
        WHEN total_spent ~ '^[0-9]+(\.[0-9]+)?$' THEN total_spent::DECIMAL(10,2)
        ELSE (
            CASE WHEN quantity ~ '^[0-9]+$' 
            THEN quantity::INT ELSE 1 END * CASE WHEN price_per_unit ~ '^[0-9]+(\.[0-9]+)?$'
            THEN price_per_unit::DECIMAL(10,2) ELSE 0.00 END
        )
    END AS total_spent,


    CASE
        WHEN TRIM(payment_method) IN ('ERROR', 'UNKNOWN') OR payment_method IS NULL 
        THEN 'Not Specified'
        ELSE INITCAP(TRIM(payment_method))
    END AS payment_method,


    CASE
        WHEN TRIM(location) IN ('ERROR', 'UNKNOWN') OR location IS NULL THEN 'Unknown'
        ELSE INITCAP(TRIM(location))
    END AS location,


    CASE
        WHEN transaction_date ~ '^[0-9]{4}-[0-9]{2}-[0-9]{2}$' THEN transaction_date::DATE
        ELSE '2023-01-01'::DATE
    END AS transaction_date

FROM staging_cafe_sales
WHERE transaction_id IS NOT NULL AND TRIM(transaction_id) != '';