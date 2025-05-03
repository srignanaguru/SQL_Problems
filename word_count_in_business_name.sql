use day1;

-- To find out the word count in the business name avoid the special characters

CREATE TABLE sf_restaurant_health_violations (
    business_address VARCHAR(255),
    business_city VARCHAR(100),
    business_id BIGINT,
    business_latitude FLOAT,
    business_location VARCHAR(255),
    business_longitude FLOAT,
    business_name VARCHAR(255),
    business_phone_number BIGINT,
    business_postal_code VARCHAR(20),
    business_state VARCHAR(50),
    inspection_date DATETIME,
    inspection_id VARCHAR(100),
    inspection_score FLOAT,
    inspection_type VARCHAR(100),
    risk_category VARCHAR(100),
    violation_description VARCHAR(255),
    violation_id VARCHAR(100)
);

INSERT INTO sf_restaurant_health_violations (
    business_address, business_city, business_id, business_latitude,
    business_location, business_longitude, business_name,
    business_phone_number, business_postal_code, business_state,
    inspection_date, inspection_id, inspection_score, inspection_type,
    risk_category, violation_description, violation_id
) VALUES
    ('123 Main St', 'San Francisco', 101, 37.7749,
     '123 Main St, San Francisco, CA', -122.4194, 'John''s Pizza & Grill',
     4151234567, '94103', 'CA', '2024-12-20', '1101', 85.5,
     'Routine Inspection', 'Low Risk', 'Cleanliness issue', 'V101'),
    ('456 Market St', 'San Francisco', 102, 37.7741,
     '456 Market St, San Francisco, CA', -122.4202, 'Sushi-Hub',
     4159876543, '94104', 'CA', '2024-12-15', '1102', 90.0,
     'Routine Inspection', 'Moderate Risk', 'Improper food storage', 'V102'),
    ('789 Mission St', 'San Francisco', 103, 37.7753,
     '789 Mission St, San Francisco, CA', -122.4175, 'The Good Cafe',
     4155551212, '94105', 'CA', '2024-12-10', '1103', 88.5,
     'Follow-Up Inspection', 'High Risk', 'Cross-contamination issue', 'V103'),
    ('321 Broadway', 'San Francisco', 104, 37.7764,
     '321 Broadway, San Francisco, CA', -122.4188, 'Burger Palace & More',
     4152223333, '94106', 'CA', '2024-12-05', '1104', 80.0,
     'Routine Inspection', 'Low Risk', 'Expired food', 'V104'),
    ('654 Polk St', 'San Francisco', 105, 37.7775,
     '654 Polk St, San Francisco, CA', -122.4167, 'Quick_&_Fresh',
     4154445555, '94107', 'CA', '2024-12-01', '1105', 75.0,
     'Routine Inspection', 'Moderate Risk', 'Improper sanitation', 'V105');

select * from sf_restaurant_health_violations;

with cte as(
select business_name, regexp_replace(business_name,'[^a-zA-Z0-9'']',' ') as business from sf_restaurant_health_violations
),
cte1 as(
select business_name, regexp_replace(business, '\\s+', ' ') as trim_business from cte
)

select business_name, length(trim_business) - length(replace(trim(trim_business),' ',''))+1 as word_count from cte1;




