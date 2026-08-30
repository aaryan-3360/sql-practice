-- Q1. Display all employee IDs who have received either a bonus or taken a leave.
SELECT employee_id AS id
FROM bonuses
UNION ALL
SELECT employee_id
FROM leaves_data;

-- Q2. Display the names of all employees and all clients in a single result set.
select employee_name as name, 'Employee' as type
from employees
union all
select  client_name as name, 'Client' as type
from clients ;