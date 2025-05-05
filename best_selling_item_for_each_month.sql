use day1;

-- To find out the best selling iitem for each month

CREATE TABLE online_retails (
    country VARCHAR(10),
    customerid FLOAT,
    description VARCHAR(10),
    invoicedate DATETIME,
    invoiceno VARCHAR(10),
    quantity BIGINT,
    stockcode VARCHAR(10),
    unitprice FLOAT
);

INSERT INTO online_retails (
    country, customerid, description, invoicedate, invoiceno, quantity, stockcode, unitprice
) VALUES 
    ('USA', 12345, 'Product Α', '2025-01-01 12:00:00', 'INV001', 5, 'A123', 10.50),
    ('UK', 67890, 'Product B', '2025-01-02 14:30:00', 'INV002', 2, 'B456', 20.75),
    ('Canada', 11223, 'Product C', '2025-01-03 16:45:00', 'INV003', 10, 'C789', 15.00);

WITH invoice_totals AS (
    SELECT 
        invoiceno,
        MONTH(invoicedate) AS month,
        SUM(unitprice * quantity) AS invoice_total
    FROM online_retails
    GROUP BY invoiceno, MONTH(invoicedate)
),
max_invoice_per_month AS (
    SELECT 
        month,
        MAX(invoice_total) AS max_total
    FROM invoice_totals
    GROUP BY month
),
joined_data AS (
    SELECT 
        o.invoicedate,
        MONTH(o.invoicedate) AS month,
        o.description,
        o.unitprice * o.quantity AS amount_paid,
        i.invoice_total
    FROM online_retails o
    JOIN invoice_totals i ON o.invoiceno = i.invoiceno
),
filtered_data AS (
    SELECT 
        j.month,
        j.description,
        SUM(j.amount_paid) AS total_amount_paid
    FROM joined_data j
    JOIN max_invoice_per_month m  
        ON j.month = m.month AND j.invoice_total = m.max_total
    GROUP BY j.month, j.description
),
best_selling_per_month AS (
    SELECT 
        month,
        description,
        total_amount_paid,
        RANK() OVER (PARTITION BY month ORDER BY total_amount_paid DESC) AS rnk
    FROM filtered_data
)
SELECT 
    month,
    description,
    total_amount_paid AS amount_paid
FROM best_selling_per_month
WHERE rnk = 1;
