use day1;

-- To find out the totals selas, per quarter and first two quarters in year 2020

CREATE TABLE sf_exchange_rate (
    date DATE,
    exchange_rate FLOAT,
    source_currency VARCHAR(10),
    target_currency VARCHAR(10)
);

INSERT INTO sf_exchange_rate (date, exchange_rate, source_currency, target_currency) VALUES
    ('2020-01-15', 1.1, 'EUR', 'USD'),
    ('2020-01-15', 1.3, 'GBP', 'USD'),
    ('2020-02-05', 1.2, 'EUR', 'USD'),
    ('2020-02-05', 1.35, 'GBP', 'USD'),
    ('2020-03-25', 1.15, 'EUR', 'USD'),
    ('2020-03-25', 1.4, 'GBP', 'USD'),
    ('2020-04-15', 1.2, 'EUR', 'USD'),
    ('2020-04-15', 1.45, 'GBP', 'USD'),
    ('2020-05-10', 1.1, 'EUR', 'USD'),
    ('2020-05-10', 1.3, 'GBP', 'USD'),
    ('2020-06-05', 1.05, 'EUR', 'USD'),
    ('2020-06-05', 1.25, 'GBP', 'USD');

CREATE TABLE sf_sales_amount (
    currency VARCHAR(10),
    sales_amount BIGINT,
    sales_date DATE
);

INSERT INTO sf_sales_amount (currency, sales_amount, sales_date) VALUES
    ('USD', 1000, '2020-01-15'),
    ('EUR', 2000, '2020-01-20'),
    ('GBP', 1500, '2020-02-05'),
    ('USD', 2500, '2020-02-10'),
    ('EUR', 1800, '2020-03-25'),
    ('GBP', 2200, '2020-03-30'),
    ('USD', 3000, '2020-04-15'),
    ('EUR', 1700, '2020-04-20'),
    ('GBP', 2000, '2020-05-10'),
    ('USD', 3500, '2020-05-25'),
    ('EUR', 1900, '2020-06-05'),
    ('GBP', 2100, '2020-06-10');
    
select * from sf_exchange_rate;

select * from sf_sales_amount;

select * from sf_exchange_rate s1 right join sf_sales_amount s2 on s1.date=s2.sales_date;


select quarter(s1.sales_date) as per_quarter,
round(sum(case when s1.currency = 'USD' then s1.sales_amount else s1.sales_amount * s2.exchange_rate end)) as total_sales
from sf_sales_amount s1 join sf_exchange_rate s2 on s1.currency = s2.source_currency 
and s1.sales_date = s2.date and s2.target_currency = 'USD'
where quarter(s1.sales_date) <= 2 and year(s1.sales_date) = 2020
group by quarter(s1.sales_date)
order by per_quarter;
