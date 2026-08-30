-- Q1. Create a view to display all Active employees.
create view employee_active_status as
select *
from employees
where employees.employment_status = "Active";

select *
from employee_active_status;

-- Q2. Create a view to display employee name, department, and salary of employees earning more than ₹70,000.
create view employee_detail as
select employee_name,department,salary
from employees
where salary > 70000;

select * from employee_detail;

-- Q3. Create a view to display each employee along with their manager's name.
create  view employee_manager as 
select e.employee_name as employee_name,m.employee_name as manager_name
from employees as e
inner join employees as m
on e.manager_id =m.employee_id;

select *
from employee_manager;

-- Q4. Create a view to display the total number of employees in each department.
create view total_department_employees as
select department,count(*)
from employees
where department is not null
group by department
order by 2 desc;

select *
from total_department_employees;

-- Q5. Create a view to display the highest-paid employee from each department.
create view highest_paid_employee_department as
select * from
(select *,
rank() over(partition by department order by salary desc) as ranking
from employees
where department is not null
) as t
where ranking <= 2;

select * from highest_paid_employee_department;