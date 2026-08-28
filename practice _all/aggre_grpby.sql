-- Q1: Find the total number of employees in the company.
select count(*) as total_employees
from employees;

-- Q2: Find how many employees have a manager assigned.
select  count(*) as total_manager_assigned
from employees
where manager_id is not null;

-- Q3: Understanding COUNT(*) vs COUNT(column) vs COUNT(1)
select count(*),count(employees.manager_id),count(1) 
from employees;

-- Q4: Find the total salary expense of the company.
select sum(salary) as total_expense
from employees;

-- Q5: Find the average salary of employees.
select avg(salary) average_salary
from employees;

-- Q6: Find the highest and lowest salary in the company.
select min(salary) as Lowest_salary, max(salary) as Highest_salary
from employees;

-- Q7: Find the total number of employees in each department.
select department,count(*) 
from employees
where department is not null
group by department; 

-- Q8: Find the average salary of employees in each city.
select city,round(avg(salary),2) as average_salary
from employees
where city is not null
group by city;

-- Q9: Find the total number of Active employees in each department.
select department,count(*) as active_employees
from employees
where department is not null
and employment_status = "Active"
group by department;

-- Q10: Find the total salary expense of employees working in Mumbai for each department.
select department, sum(salary) as total_salary_expense
from employees
where city ="Mumbai"
group by department;


-- Q11: Find departments having more than 5 employees.
select department , count(*) as total_employees
from employees
group by department
having total_employees > 5;

-- Q12: Find cities whose average salary is greater than ₹70,000.
select city,avg(salary) as average_salary
from employees
where city is not null 
group by city
having average_salary > 70000;

-- Q13: Find departments whose average salary lies between ₹60,000 and ₹80,000.
select department,avg(salary) as average_salary
from employees
where department is not null
group by department
having average_salary between 60000 and 80000;

 -- Q14: Find departments having at least 4 employees who are currently Active.
select department,count(*) as total_employee
from employees
where employees.employment_status = "Active"
group by department 
having total_employee >= 4;

-- Q15: Find Duplicate Records By Email
SELECT email, COUNT(*) AS duplicate_email_count
FROM employees
GROUP BY email
HAVING duplicate_email_count > 1;


