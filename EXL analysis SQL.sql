create database exl_project;
use exl_project;

create table cases (
    case_id varchar(20) primary key,
    department varchar(50),
    region varchar(20),
    priority varchar(20),
    channel varchar(20),
    customer_type varchar(20),
    created_date date not null,
    closed_date date null,              -- can be null (open cases)
    sla_days int not null,
    resolution_hours int not null,
    status varchar(30) not null,
    sla_breach tinyint null,            -- can be null for open cases
    agent_id varchar(20) not null,
    reopen_flag tinyint not null,
    customer_rating decimal(3,2) null,  -- can be null for open/no-rating
    resolution_days int null            -- null for open cases
);


select * from cases;
select count(*) as total_rows from cases;

-- pure business reporting & aggregation on closed cases

-- SLA BREACH PERCENTAGE (OVERALL)
-- Out of all closed cases, what percentage were delayed beyond the SLA?
select 
    round(sum(sla_breach) * 100.0 / count(*), 2) as sla_breach_percent
from cases;
-- The SLA breach rate in the SQL dataset is 0%, indicating that all imported closed cases were resolved within the defined SLA. 
-- This suggests that the SQL layer contains only clean, on-time closure records, 
-- while breach and backlog analysis is handled separately in Python using the full dataset.

-- Average Resolution Days
select round(avg(resolution_days) , 2) as avg_resolution_days
from cases;
--  The overall average resolution time is 1.54 days, 
-- indicating a highly efficient service operation with quick turnaround for case closures.

-- DEPARTMENT-WISE PERFORMANCE
select 
    department,
    count(*) as total_cases,
    round(avg(resolution_days), 2) as avg_resolution_days,
    round(sum(sla_breach) * 100.0 / count(*), 2) as sla_breach_percent
from cases
group by department
order by avg_resolution_days;
-- Performed department-wise performance analysis and identified Policy Update as the fastest unit (1.51 days avg resolution) and 
-- Claims Processing as the slowest (1.59 days), 
-- with 0% SLA breach across all departments.

-- REGION-WISE PERFORMANCE
select 
    region,
    count(*) as total_cases,
    round(avg(resolution_days), 2) as avg_resolution_days,
    round(sum(sla_breach) * 100.0 / count(*), 2) as sla_breach_percent
from cases
group by region
order by avg_resolution_days;

-- Conducted region-wise performance analysis and identified West and Central as the fastest regions (1.53 days avg),
--  with consistent 0% SLA breach across all regions.

-- AGENT PERFORMANCE (TOP & BOTTOM)
select 
    agent_id,
    count(*) as total_cases,
    round(avg(customer_rating), 2) as avg_rating,
    round(avg(resolution_days), 2) as avg_resolution_days
from cases
where customer_rating is not null
group by agent_id
having count(*) >= 20
order by avg_rating desc, avg_resolution_days asc
limit 10;

-- Identified top-performing service agents based on customer ratings and resolution efficiency,
--  with AGT-241 emerging as the fastest high-rated agent (1.27 days avg resolution).

select 
    agent_id,
    count(*) as total_cases,
    round(avg(resolution_days), 2) as avg_resolution_days,
    round(avg(customer_rating), 2) as avg_rating
from cases
where customer_rating is not null
group by agent_id
having count(*) >= 20
order by avg_resolution_days desc
limit 10;

-- Identified low-performing agents based on slower resolution times and lower customer ratings, 
-- highlighting clear opportunities for targeted training and process improvement.


-- Overall Average Customer Rating
select 
    round(avg(customer_rating), 2) as avg_customer_rating
from cases
where customer_rating is not null;

-- The overall average customer rating is 3.65, indicating a generally positive customer experience with 
-- scope for further improvement through faster resolution and consistent service quality.

-- DEPARTMENT-WISE CUSTOMER RATING
select 
    department,
    round(avg(customer_rating), 2) as avg_rating,
    count(*) as rated_cases
from cases
where customer_rating is not null
group by department
order by avg_rating desc;

-- Performed department-wise customer satisfaction analysis and identified Claims Processing as the top-rated department (3.68/5), 
-- with consistent service quality across all business units.






