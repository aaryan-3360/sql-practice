-- Q1 — Retrieve all employee details
select * from employees;

-- Q2 — Retrieve name, department, and salary only
select employee_name,department,salary
from employees;

-- Q3 — Find all unique departments
select distinct department
from employees
where department is not null;

-- Q4 — Employees in the IT department
select *
from employees
where department="IT" ;

-- Q5 — Employees earning more than ₹80,000
select *
from employees
where salary > 80000;

-- Q6 — IT employees earning more than ₹80,000
select * 
from employees
where department="IT" and salary > 80000;

-- Q7 — Employees in IT or Finance
select * 
from employees
where department ="IT" or department ="Finance";

-- Q8 — Employees who are NOT Active
select * 
from employees
where employment_status <> "Active"; 

-- Q9 — Employees in IT, HR, or Finance
select *
from employees
where department in ("IT","HR","Finance");

-- Q10 — Employees with salary between ₹50,000 and ₹80,000
select *
from employees
where salary between 50000 and 80000;

-- Q11 — Employees whose name starts with 'A'
select *
from employees
where employee_name like "A%";

-- Q12 — Employees with a Gmail address
select * 
from employees
where email like "%@gmail.com";

-- Q13 — Active employees whose name starts with 'S'
select *
from employees
where employment_status = "Active"
and employee_name like "S%";

-- Q14 — Employees with no manager assigned
select * 
from employees
where manager_id is null;

-- Q15 — Employees with an email on record
select *
from employees
where email is not null;

-- Q16 — Sort by salary (lowest to highest)
select *
from employees
where salary is not null
order by salary asc;

-- Q17 — Sort by salary (highest to lowest)
select *
from employees
where salary is not null
order by salary desc;

-- Q18 — Sort by department, then salary descending
select * 
from employees
where department is not null
order by department asc ,salary desc;

-- Q19 — Top 5 highest-paid employees
select * 
from employees
order by salary desc
limit 5;

-- Q20 — Top 3 highest-paid IT/Finance employees earning ₹70K–₹1L
select *
from employees
where department in ("IT","Finance")
and salary between 70000 and 100000
order by salary desc
limit 3;
