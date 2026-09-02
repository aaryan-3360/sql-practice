-- Q1. Find employees whose salary is greater than the average salary of the company.
select * 
from employees
where salary > (select avg(salary) from employer_database.employees);

-- Q2. Find employees earning the highest salary in the company.
select *
from employees
where salary =(
select max(salary) 
from employees
);
-- Q3. Find employees who work in the same department as 'Aarav Sharma'.

select *
from employees
where department in (
select department
from employees
where employee_name="Aarav Sharma"
);

-- Q4. Find employees whose salary is greater than all employees in the Support department.

select *
from employees
where salary > All(
select salary 
from employees
where department ="Support"
);
-- Q5. Find employees working in departments where at least one employee is currently on leave
select *
from employees
where department  in(
select department 
from employees
where employment_status = "On Leave"
);
-- Q6. Find employees who have received bonuses
select e.employee_id, e.employee_name,b.bonus_amount
from employees as e
inner join bonuses as b
on e.employee_id =b.employee_id;

-- using subqueries
select *
from employees
where employee_id  in(
select distinct employee_id
from bonuses
);

-- using exists
select *
from employees as e
where exists(
select *
from bonuses b
where b.employee_id = e.employee_id
);

-- Q7. Find employees who never received any bonus
select employee_name,b.bonus_id
from employees as e
left join bonuses as b
on e.employee_id =b.employee_id
where b.bonus_id is null;

-- Q8. Find employees whose salary is greater than the average salary of their own department

select *
from employees e
where salary > 
(select avg(salary) as average_salary
from employees e1
where e1.department = e.department
);

-- Q9. Find employees who are assigned to at least one project
select *  
from employees e
where  exists(
select 1
from employer_database.employee_projects as ep
where ep.employee_id = e.employee_id
);

-- using inner join
select e.employee_name,ep.project_id
from employees as e
inner join employee_projects as ep
on e.employee_id =ep.employee_id;

-- Q10. Find employees who earn more than their manager
select *
from employees e
where salary > (
select ep.salary
from employees ep
where ep.employee_id = e.manager_id
);

-- 11.find the second highest salary in the employees table
select max(salary) as second_highest
from employees
where salary <
(select max(salary)
from employees
);

-- 12.Find employees who earn more then the average salary of their department
select * 
from employees 
where salary >
(select round(avg(salary),2)
from employees
);

-- 13. department average greater than company's average
select department
from employees
group by department
having avg(salary) >
(select avg(salary)
from employees
);

-- 14.employee with the third highest salary
select max(salary) as third_highest
from employees 
where salary <
(
select max(salary) 
from employees
where salary < 
(select max(salary)
from employees) 
);

-- 15.employees who have the same salary as at least one employee from the it department
select * 
from employees
where salary in 
(
select salary 
from employees 
where department="IT"
);

-- 16.find employees whoose salary is higher than the average salary and is active.

select *
from employees
where salary >
(select avg(salary)
from employees
)
and employment_status = "Active";

-- 


