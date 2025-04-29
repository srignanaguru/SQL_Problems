use day1;


-- To find out the list of exchange rate for various currencies to USD dollars for the first half of 2020 and second half of 2020
CREATE TABLE sf_exchange_rates (
    date DATETIME,
    exchange_rate FLOAT,
    source_currency VARCHAR(10),
    target_currency VARCHAR(10)
);

INSERT INTO sf_exchange_rates (date, exchange_rate,source_currency, target_currency) 
VALUES 
    ('2020-01-01', 1.12, 'EUR', 'USD'),
    ('2020-01-01', 1.31, 'GBP', 'USD'),
    ('2020-01-01', 109.56, 'JPY', 'USD'),
    ('2020-07-01', 1.17, 'EUR', 'USD'),
    ('2020-07-01', 1.29, 'GBP', 'USD'),
    ('2020-07-01', 109.66, 'JPY', 'USD'),
    ('2020-01-01', 0.75, 'AUD', 'USD'),
    ('2020-07-01', 0.73, 'AUD', 'USD'),
    ('2020-01-01', 6.98, 'CNY', 'USD'),
    ('2020-07-01', 7.05, 'CNY', 'USD');

select date(date), exchange_rate, source_currency, target_currency from sf_exchange_rates;

with cte as(
select date(date), exchange_rate, source_currency, target_currency,
(lag(exchange_rate) over (partition by source_currency)) as lag_value
from sf_exchange_rates
)

select source_currency, round(exchange_rate - lag_value,4) as difference_echange_rate from cte where lag_value>0;
