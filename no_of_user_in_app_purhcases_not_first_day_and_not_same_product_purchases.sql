use day1;

-- To find out the no of users made additional in-app-purchases but not count on one or multiple pruchases on first day and same product purchased later day

CREATE TABLE in_app_purchases (
    created_at DATETIME,
    price BIGINT,
    product_id BIGINT,
    quantity BIGINT,
    user_id BIGINT
);

INSERT INTO in_app_purchases (created_at, price, product_id, quantity, user_id) VALUES
    ('2024-12-01 10:00:00', 500, 101, 1, 1),
    ('2024-12-02 11:00:00', 700, 102, 1, 1),
    ('2024-12-01 12:00:00', 300, 103, 1, 2),
    ('2024-12-03 14:00:00', 400, 103, 1, 2),
    ('2024-12-02 09:30:00', 200, 104, 1, 3),
    ('2024-12-04 15:30:00', 600, 105, 2, 3),
    ('2024-12-01 08:00:00', 800, 106, 1, 4),
    ('2024-12-05 18:00:00', 500, 107, 1, 4),
    ('2024-12-06 16:00:00', 700, 108, 1, 5);
    
select * from in_app_purchases order by created_at asc;


with first_purchase as(
select user_id,product_id, min(date(created_at)) as min_date from in_app_purchases group by user_id,product_id
),
unique_purchases as(
select i.user_id from in_app_purchases i join first_purchase f on f.user_id=i.user_id and i.created_at>f.min_date where f.product_id!=i.product_id
)

select count(*) as successful_purchases_count from unique_purchases;

