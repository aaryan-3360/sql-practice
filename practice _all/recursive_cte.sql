-- Q1. Generate the numbers 1 to 10 using a Recursive CTE.
with recursive numbers as 
(
select 1 as num
union
select num + 1 
from numbers
where num < 10
)
select * from numbers;

-- Q2. Display the complete employee hierarchy.

CREATE TABLE organization (
    employee_id   INT PRIMARY KEY,
    employee_name VARCHAR(1000),
    designation   VARCHAR(50),
    manager_id    INT
);

INSERT INTO organization VALUES
(1, 'Raj Sharma',    'CEO',                 NULL),
(2, 'Sneha Kapoor',  'CTO',                 1),
(3, 'Amit Patel',    'HR Head',             1),
(4, 'Aarav Sharma',  'Engineering Manager', 2),
(5, 'Priya Mehta',   'Senior Developer',    4),
(6, 'Rohit Jain',    'Developer',           5),
(7, 'Anjali Verma',  'HR Executive',        3);



WITH RECURSIVE organization_hierarchy AS
(
    -- Anchor: the top of the tree (the person with no manager)
    SELECT
        employee_id,
        employee_name,
        designation,
        1 AS level,
        employee_name AS hierarchy_path
    FROM organization
    WHERE manager_id IS NULL

    UNION ALL

    -- Recursive: attach each employee to the manager already in the result
    SELECT
        o.employee_id,
        o.employee_name,
        o.designation,
        oh.level + 1,
        CONCAT(oh.hierarchy_path, ' -> ', o.employee_name)
    FROM organization o
    JOIN organization_hierarchy oh
        ON o.manager_id = oh.employee_id
)
SELECT *
FROM organization_hierarchy;