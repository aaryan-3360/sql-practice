-- ------------------- problem set-1 --------------------

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    city VARCHAR(50),
    signup_date DATE
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    order_status VARCHAR(20)
);

INSERT INTO customers VALUES
(1,'Ravi Kumar','Mumbai','2024-01-05'),
(2,'Anita Sharma','Delhi','2024-01-10'),
(3,'Vikram Singh','Pune','2024-01-15'),
(4,'Neha Joshi','Bangalore','2024-02-01'),
(5,'Suresh Rao','Chennai','2024-02-10'),
(6,'Priya Nair','Hyderabad','2024-02-15'),
(7,'Amit Verma','Mumbai','2024-03-01'),
(8,'Kavita Desai','Delhi','2024-03-05');

INSERT INTO orders VALUES
(101,1,'2024-01-20','DELIVERED'),
(102,2,'2024-01-25','DELIVERED'),
(103,1,'2024-02-05','CANCELLED'),
(104,4,'2024-02-10','DELIVERED'),
(105,5,'2024-02-20','DELIVERED');

-- Q1 — Customers who never placed an order
select c.customer_id,c.customer_name,o.order_id
from customers as c
left join orders as o
on c.customer_id = o.customer_id
where o.order_id is null;

-- approach 2
select c.customer_id
from customers as c
where not exists(
select 1
from orders o
where o.customer_id =c.customer_id
);

-- Q2 — Average delivery time per restaurant

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    restaurant_name VARCHAR(50),
    order_time DATETIME,
    delivery_time DATETIME  -- NULL means order is still in transit / undelivered
);

INSERT INTO orders VALUES
(1,'Spice Villa','2024-03-01 12:00:00','2024-03-01 12:45:00'),
(2,'Spice Villa','2024-03-01 13:00:00','2024-03-01 13:50:00'),
(3,'Pizza Hub','2024-03-01 12:10:00','2024-03-01 12:40:00'),
(4,'Pizza Hub','2024-03-01 13:15:00',NULL),
(5,'Pizza Hub','2024-03-01 14:00:00','2024-03-01 14:35:00'),
(6,'Curry House','2024-03-01 12:30:00','2024-03-01 13:20:00');

select restaurant_name,round(avg(TIMESTAMPDIFF(MINUTE, order_time, delivery_time)),2) as avg_delivery_time
from orders
group by restaurant_name;


-- Q3 — Running wallet balance per customer
CREATE TABLE wallet_transactions (
    txn_id INT PRIMARY KEY,
    customer_id INT,
    txn_date DATE,
    txn_type VARCHAR(10),   -- CREDIT or DEBIT
    amount DECIMAL(10,2)
);

INSERT INTO wallet_transactions VALUES
(1,1,'2024-01-01','CREDIT',1000.00),
(2,1,'2024-01-03','DEBIT',200.00),
(3,1,'2024-01-05','CREDIT',500.00),
(4,1,'2024-01-07','DEBIT',300.00),
(5,2,'2024-01-01','CREDIT',2000.00),
(6,2,'2024-01-04','DEBIT',700.00);

select customer_id, txn_date,txn_type,amount, 
sum(
case 
when txn_type = "CREDIT" then amount
else -amount
end
) over(partition by customer_id order by txn_date) as running_balance 
from wallet_transactions
;

-- Q4 — Distinct active users per month

CREATE TABLE watch_history (
    watch_id INT PRIMARY KEY,
    user_id INT,
    content_id INT,
    watch_date DATE
);

INSERT INTO watch_history VALUES
(1,1,101,'2024-01-05'),
(2,2,102,'2024-01-10'),
(3,1,103,'2024-01-20'),
(4,3,101,'2024-02-01'),
(5,1,104,'2024-02-15'),
(6,4,105,'2024-02-20'),
(7,2,101,'2024-03-01'),
(8,3,103,'2024-03-05');

select  date_format(watch_date,"%Y-%m") as month,count(distinct user_id) as active_user
from watch_history
group by date_format(watch_date,"%Y-%m");

-- Q5 — Trip cancellation rate per city
CREATE TABLE trips (
    trip_id INT PRIMARY KEY,
    city VARCHAR(30),
    rider_id INT,
    driver_id INT,
    trip_status VARCHAR(20)  -- COMPLETED, CANCELLED_BY_RIDER, CANCELLED_BY_DRIVER
);

INSERT INTO trips VALUES
(1,'Mumbai',1,10,'COMPLETED'),
(2,'Mumbai',2,11,'CANCELLED_BY_RIDER'),
(3,'Mumbai',3,10,'COMPLETED'),
(4,'Mumbai',4,12,'CANCELLED_BY_DRIVER'),
(5,'Delhi',5,13,'COMPLETED'),
(6,'Delhi',6,14,'COMPLETED'),
(7,'Delhi',7,13,'CANCELLED_BY_RIDER'),
(8,'Pune',8,15,'COMPLETED');

select city,count(trip_id)as total_trip,
sum(case when trip_status like 'CANCELLED%' THEN 1 ELSE 0 END) as cancelled_trip,
round(sum(CASE WHEN trip_status LIKE 'CANCELLED%' THEN 1 ELSE 0 END) * 100 / count(*),2) as cancelled_rate_pct
from trips
group by city;

-- Q6 — Double-booked (overlapping) rooms
CREATE TABLE bookings (
    booking_id INT PRIMARY KEY,
    room_id INT,
    guest_name VARCHAR(50),
    check_in DATE,
    check_out DATE
);

INSERT INTO bookings VALUES
(1,101,'Ravi Kumar','2024-04-01','2024-04-05'),
(2,101,'Anita Sharma','2024-04-04','2024-04-08'),
(3,102,'Vikram Singh','2024-04-01','2024-04-03'),
(4,102,'Neha Joshi','2024-04-03','2024-04-06'),
(5,103,'Suresh Rao','2024-04-01','2024-04-02'),
(6,101,'Priya Nair','2024-04-10','2024-04-12');

select b.room_id , b.booking_id as boooking1 ,b.guest_name as guest1, b2.booking_id as booking2, b2.guest_name as guest2
from bookings as b
join bookings as b2
on b.room_id =b2.room_id
AND b.booking_id < b2.booking_id
    AND b.check_in  < b2.check_out
    AND b.check_out > b2.check_in;
    
-- Q7 — Top-selling product per category    
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    category VARCHAR(30)
);

CREATE TABLE sales (
    sale_id INT PRIMARY KEY,
    product_id INT,
    quantity_sold INT,
    sale_date DATE
);

INSERT INTO products VALUES
(1,'Colgate Toothpaste','Personal Care'),
(2,'Dove Soap','Personal Care'),
(3,'Tata Salt','Grocery'),
(4,'Aashirvaad Atta','Grocery'),
(5,'Lays Chips','Snacks'),
(6,'Kurkure','Snacks');

INSERT INTO sales VALUES
(1,1,50,'2024-01-01'),
(2,2,80,'2024-01-02'),
(3,3,120,'2024-01-03'),
(4,4,150,'2024-01-04'),
(5,5,200,'2024-01-05'),
(6,6,90,'2024-01-06'),
(7,1,30,'2024-01-07'),
(8,4,60,'2024-01-08');        

with total_quantity as 
(
select p.category , p.product_name ,sum(s.quantity_sold) as total_qty
from products as p
join sales as s
on p.product_id = s.product_id 
group by p.category ,p.product_name
)
select category,product_name,total_qty
from (
SELECT category,product_name,total_qty,
ROW_NUMBER() OVER (PARTITION BY category ORDER BY total_qty DESC) AS ranking
FROM total_quantity
) as t
where ranking= 1;


-- Q8 Find patients who booked more than one appointment on the same day.
CREATE TABLE appointments (
    appointment_id INT PRIMARY KEY,
    patient_id INT,
    doctor_id INT,
    appointment_date DATE
);

INSERT INTO appointments VALUES
(1,1,10,'2024-05-01'),
(2,1,11,'2024-05-01'),
(3,2,10,'2024-05-01'),
(4,3,12,'2024-05-02'),
(5,3,12,'2024-05-02'),
(6,4,13,'2024-05-03'),
(7,1,10,'2024-05-04');

select patient_id,appointment_date,count(appointment_id) as count
from appointments
group by patient_id, appointment_date
having count > 1;

-- Q9 Find customers who downgraded from a paid plan (BASIC/PRO) to the free plan.
CREATE TABLE subscriptions (
    subscription_id INT PRIMARY KEY,
    customer_id INT,
    plan_type VARCHAR(20),   -- FREE, BASIC, PRO
    start_date DATE,
    end_date DATE
);

INSERT INTO subscriptions VALUES
(1,1,'BASIC','2024-01-01','2024-02-01'),
(2,1,'FREE','2024-02-01',NULL),
(3,2,'PRO','2024-01-01','2024-03-01'),
(4,2,'PRO','2024-03-01',NULL),
(5,3,'FREE','2024-01-01','2024-02-01'),
(6,3,'BASIC','2024-02-01',NULL);

SELECT
    customer_id,
    from_plan,
    next_plan AS to_plan,
    downgrade_date
FROM (
    SELECT
        customer_id,
        plan_type AS from_plan,
        LEAD(plan_type)  OVER (PARTITION BY customer_id ORDER BY start_date) AS next_plan,
        LEAD(start_date) OVER (PARTITION BY customer_id ORDER BY start_date) AS downgrade_date
    FROM subscriptions
) t
WHERE from_plan IN ('BASIC', 'PRO')
  AND next_plan = 'FREE';
  
  
  -- Q10 Find the number of likes, comments, and shares for each post.
  CREATE TABLE posts (
    post_id INT PRIMARY KEY,
    user_id INT,
    post_date DATE
);

CREATE TABLE engagements (
    engagement_id INT PRIMARY KEY,
    post_id INT,
    engagement_type VARCHAR(10)  -- LIKE, COMMENT, SHARE
);

INSERT INTO posts VALUES
(1,101,'2024-06-01'),
(2,102,'2024-06-02'),
(3,101,'2024-06-03');

INSERT INTO engagements VALUES
(1,1,'LIKE'),(2,1,'LIKE'),(3,1,'COMMENT'),(4,1,'SHARE'),
(5,2,'LIKE'),(6,2,'COMMENT'),(7,2,'COMMENT'),
(8,3,'LIKE');



select p.post_id ,
sum(
case when e.engagement_type ="LIKE" then 1
else 0 end
) as likes,
sum(
case when e.engagement_type ="COMMENT" then 1
else 0 end
) as Comments,
sum(
case when e.engagement_type ="SHARE" then 1
else 0 end 
) as Shares
from engagements as e
join posts as p
on e.post_id = p.post_id
group by p.post_id;

