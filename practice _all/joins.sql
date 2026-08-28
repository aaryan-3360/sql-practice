-- Q1 — Employee Name, Bonus Amount & Bonus Date
select employees.employee_name,bonuses.bonus_amount,bonuses.bonus_date
from employees 
join bonuses
on employees.employee_id =bonuses.employee_id;

-- Q2 — Employee Name, Project Name & Role
select e.employee_name,p.project_name,ep.role
from employees as e
join employee_projects as ep
on e.employee_id = ep.employee_id
join projects as p
on ep.project_id = p.project_id;

-- Q3 — Employees with Bonus Greater than ₹10,000
select e.employee_name,e.email,b.bonus_amount
from employees as e
join bonuses as b
on e.employee_id = b.employee_id
where b.bonus_amount >10000; 
-- Q4 — Employees On Leave with Their Manager Names
SELECT e.employee_name  as employeName, m.employee_name  as managerName, e.employment_status
FROM employees e
INNER JOIN employees m ON e.manager_id = m.employee_id
WHERE e.employment_status = 'On Leave';

-- Q5 — Employees Who Never Received a Bonus
select e.employee_name,b.bonus_id,b.bonus_amount
from employees as e
left join bonuses as b
on e.employee_id=b.employee_id
where b.bonus_amount is null;

-- Q6 — Employees Working on More Than One Project
select e.employee_name,count(ep.project_id) as total_project
from employees as e
join employee_projects as ep
on e.employee_id = ep.employee_id
group by e.employee_name
having total_project > 1;

-- Q7 — Employees Not Assigned to Any Project
select e.employee_name,ep.project_id 
from employees as e
left join employee_projects as ep
on  e.employee_id = ep.employee_id
group by e.employee_name
having ep.project_id is null;

-- Q8 — Projects with No Employees Assigned
SELECT p.project_id,
       p.project_name
FROM projects p
LEFT JOIN employee_projects ep ON p.project_id = ep.project_id
WHERE ep.project_id IS NULL;

-- Q9 — Clients with Total Number of Orders
select c.client_name,count(c.client_id) as total_order
from clients as c  
left join orders_data o ON c.client_id = o.client_id
GROUP BY c.client_id;