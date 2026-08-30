-- Q1. Create a Single-Column Index
CREATE INDEX idx_employee_email
ON employees(email);

-- Q2. Create a Composite Index
create index employee_department
on employees(employee_id,department);

-- Q3. Create a UNIQUE Index
CREATE UNIQUE INDEX idx_project_unique
ON projects(project_name);

-- Q4. Create a Prefix Index
CREATE INDEX idx_email_prefix
ON employees(email(5));
SHOW INDEXES FROM employees;

-- Q5. Remove an Index
drop index idx_employee_email
on employees;

-- Q6. Check Existing Indexes
SHOW INDEXES FROM employees;

-- Q7. Check Query Performance with EXPLAIN
EXPLAIN
SELECT *
FROM employees
WHERE employee_name = 'Neha Joshi' AND department = 'Marketing';

-- Q8. Measure Real Performance with EXPLAIN ANALYZE
EXPLAIN ANALYZE
SELECT *
FROM employees
WHERE employee_name = 'Neha Joshi' AND department = 'Marketing';
