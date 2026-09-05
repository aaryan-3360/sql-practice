
-- ============================================
-- LEETCODE SQL SOLUTIONS - 19 PROBLEMS
-- ============================================

-- 1. Problem 619: Biggest Single Number
-- Find the biggest number that appears only once
SELECT MAX(num) AS num
FROM my_numbers
WHERE num IN (
    SELECT num 
    FROM my_numbers 
    GROUP BY num 
    HAVING COUNT(*) = 1
);


-- 2. Problem 1729: Find Followers Count
-- Count followers for each user
SELECT user_id, COUNT(*) AS followers_count
FROM followers
GROUP BY user_id
ORDER BY user_id;


-- 3. Problem 596: Classes With at Least 5 Students
-- Find classes with 5 or more students
SELECT class
FROM courses
GROUP BY class
HAVING COUNT(DISTINCT student) >= 5;


-- 4. Problem 1141: User Activity for the Past 30 Days I
-- Count activities per user in last 30 days
SELECT activity_date AS day, COUNT(DISTINCT user_id) AS active_users
FROM activity
WHERE activity_date BETWEEN DATE_SUB('2019-07-27', INTERVAL 29 DAY) AND '2019-07-27'
GROUP BY activity_date
ORDER BY activity_date;


-- 5. Problem 2356: Number of Unique Subjects Taught by Teachers
-- Count unique subjects per teacher
SELECT teacher_id, COUNT(DISTINCT subject_id) AS cnt
FROM teacher
GROUP BY teacher_id;


-- 6. Problem 1251: Average Selling Price
-- Calculate average price for each product
SELECT p.product_id, ROUND(SUM(p.price * u.units) / SUM(u.units), 2) AS average_price
FROM prices p
LEFT JOIN unitssold u ON p.product_id = u.product_id
WHERE u.purchase_date BETWEEN p.start_date AND p.end_date
   OR u.purchase_date IS NULL
GROUP BY p.product_id;


-- 7. Problem 620: Not Boring Movies
-- Find non-boring movies with odd ID, ordered by rating
SELECT *
FROM cinema
WHERE id % 2 = 1 AND description != 'boring'
ORDER BY rating DESC;


-- 8. Problem 1280: Students and Examinations
-- Count exams taken by each student in each subject
SELECT s.student_id, s.student_name, sub.subject_name, COUNT(e.subject_name) AS attended_exams
FROM students s
CROSS JOIN subjects sub
LEFT JOIN examinations e ON s.student_id = e.student_id AND sub.subject_name = e.subject_name
GROUP BY s.student_id, sub.subject_name
ORDER BY s.student_id, sub.subject_name;


-- 9. Problem 577: Employee Bonus
-- Show employees with bonus < 1000 or no bonus
SELECT e.name, b.bonus
FROM employee e
LEFT JOIN bonus b ON e.empid = b.empid
WHERE b.bonus IS NULL OR b.bonus < 1000;


-- 10. Problem 1661: Average Time of Process per Machine
-- Calculate average processing time per machine
SELECT machine_id, ROUND(AVG(processing_time), 3) AS average_time
FROM (
    SELECT 
        m1.machine_id,
        m2.timestamp - m1.timestamp AS processing_time
    FROM activity m1
    JOIN activity m2 ON m1.machine_id = m2.machine_id 
        AND m1.process_id = m2.process_id 
        AND m1.activity_type = 'start' 
        AND m2.activity_type = 'end'
) t
GROUP BY machine_id
ORDER BY machine_id;


-- 11. Problem 197: Rising Temperature
-- Find days where temperature is higher than previous day
SELECT w1.id
FROM weather w1
JOIN weather w2 ON DATEDIFF(w1.recordDate, w2.recordDate) = 1
WHERE w1.temperature > w2.temperature;


-- 12. Problem 1581: Customer Who Visited but Did Not Make Any Transactions
-- Find customers who visited but never transacted
SELECT DISTINCT v.customer_id, COUNT(*) AS count_no_trans
FROM visits v
LEFT JOIN transactions t ON v.visit_id = t.visit_id
WHERE t.visit_id IS NULL
GROUP BY v.customer_id;


-- 13. Problem 1068: Product Sales Analysis I
-- Show product name with sales info
SELECT p.product_name, s.year, s.price
FROM sales s
JOIN product p ON s.product_id = p.product_id;


-- 14. Problem 1378: Replace Employee ID With The Unique Identifier
-- Join employee and unique ID
SELECT u.unique_id, e.name
FROM employees e
LEFT JOIN employeeunis u ON e.id = u.id;


-- 15. Problem 1683: Invalid Tweets
-- Find tweets with content length > 15
SELECT tweet_id
FROM tweets
WHERE LENGTH(content) > 15;


-- 16. Problem 1148: Article Views I
-- Find authors who viewed their own articles
SELECT DISTINCT author_id AS id
FROM views
WHERE author_id = viewer_id
ORDER BY id;


-- 17. Problem 595: Big Countries
-- Find countries by area or population
SELECT name, population, area
FROM world
WHERE area >= 3000000 OR population >= 25000000;


-- 18. Problem 1280: Students and Examinations (Extended)
-- Alternative version with detailed stats
SELECT 
    s.student_id,
    s.student_name,
    COUNT(DISTINCT e.exam_id) AS total_exams,
    AVG(e.score) AS avg_score
FROM students s
LEFT JOIN exams e ON s.student_id = e.student_id
GROUP BY s.student_id, s.student_name;


-- 19. Problem 1729: Followers (Extended Analytics)
-- Followers with ranking
SELECT 
    user_id,
    COUNT(*) AS followers_count,
    RANK() OVER (ORDER BY COUNT(*) DESC) AS rank
FROM followers
GROUP BY user_id;

-- 20. leetcode.com/problems/list-the-products-ordered-in-a-period
select p.product_name,sum(o.unit) as unit
from products as p
join orders as o
on p.product_id = o.product_id
where o.order_date >= "2020-02-01" and 
o.order_date < "2020-03-01"
group by p.product_name
having unit >= 100
;

-- 21. Group Sold Products By The Date
--leetcode.com/problems/group-sold-products-by-the-date
SELECT sell_date,
       COUNT(DISTINCT product) AS num_sold,
       GROUP_CONCAT(DISTINCT product ORDER BY product) AS products
FROM Activities
GROUP BY sell_date
ORDER BY sell_date;

-- ============================================
-- TIPS FOR OPTIMIZATION
-- ============================================
/*
1. Use INNER JOIN for filtered results (faster)
2. Use LEFT JOIN when you need unmatched records
3. INDEX on foreign keys and frequently used columns
4. Use DATEDIFF() for date comparisons
5. Use DISTINCT sparingly - it slows queries
6. Aggregate functions: COUNT(), SUM(), AVG(), MIN(), MAX()
7. Window functions: ROW_NUMBER(), RANK(), DENSE_RANK()
8. Use HAVING for post-aggregation filtering
*/
