-- Q1. Using a CTE, find departments having more than 5 employees.
with department_query as(
select  distinct department,count(employee_id) over(partition by department) as Total_employee
from employees
)
select * from department_query
where Total_employee > 5;

-- Q2. Using Multiple CTEs, find departments whose average salary is greater than the company average salary.
with department_avg_salary as(select department,avg(salary) as average_salary
from employees
where department is not null
group by department
),
company_avg_salary as
(
select avg(salary) as company_avg_salary
from employees
)
select d.*,c.*
from department_avg_salary d
cross join company_avg_salary c
where d.average_salary > c.company_avg_salary;

-- Q3. Using a CTE, find employees who have received more than one bonus.
with bounses_count as(
select e.employee_id,count(b.bonus_id) as total_bounses
from employees e
join bonuses b
on e.employee_id =b.employee_id
group by e.employee_id
)
select *
from bounses_count
where total_bounses > 1;

-- Q4. Using a CTE, find the top 2 highest-paid employees from each department.
with highest_paid as(
select *,dense_rank() over(partition by department order by salary desc) as ranking
from employees
where department is not null
) 
select *
from highest_paid
where ranking <=2;

-- Q5. Using Multiple CTEs, find employees whose salary is greater than the average salary of their department, and display their department rank.
with department_average as(select *,avg(salary) over(partition by department) as average_salary
from employees
where department is not null
),
department_rank as(select *,rank() over(partition by department order by salary desc ) as department_ranking
from department_average
)
select *
from department_rank
where salary > average_salary;
