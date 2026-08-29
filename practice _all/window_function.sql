-- Q1. Assign a unique row number to each employee based on salary.
select *,row_number() over(order by salary desc)
from employees;

-- Q2. Rank employees based on salary using RANK().
select *, RANK() over(order by salary desc)
from employees;

-- Q3. Rank employees based on salary using DENSE_RANK().
select *, dense_rank() over(order by salary desc)
from employees;

-- Q4. Compare ROW_NUMBER vs RANK vs DENSE_RANK side by side.
select *, rank() over(order by salary desc) as rank_ranking,
dense_rank() over(order by salary desc) as denseRanking,
row_number() over(order by salary desc) as row_number_ranking
from employees;

-- Q5. Find the employee with the 2nd highest salary.


select * 
from 
(select *,rank() over(order by salary desc) as ranking
from employees
)as t2
where ranking =2;

-- Q6. Display each employee's rank within their department based on salary.
select *,rank() over(partition by department order by salary desc) as ranking
from employees
where department is not null;

-- Q7. Find the highest-paid employee from each department.

select *
from
(
select  *,rank() over(partition by department order by salary) as ranking
from employees
where department is not null
) as t2
where ranking=1;

-- Q8. Find employees earning more than the previous employee.
select *
from
(select *, lag(salary) over(order by employee_id) as previous_salary 
from employees
) as t2
where salary > previous_salary;

-- Q9. Find employees earning less than the next employee.

select *
from 
(
select *,lead(salary) over(order by employee_id) as next_employee_salary
from employees
) as t2
where salary < next_employee_salary;

-- Q10. Display the salary difference between each employee and the previous employee.
select *,salary - lag(salary) over(order by employee_id) as salary_difference
from employees;

-- Q11. LAG vs LEAD — side-by-side comparison.
select *,lag(employee_name) over(order by employee_id) as previous_employee,
lead(employee_name) over(order by employee_id) as next_employee
from employees;

-- Q12. GROUP BY vs PARTITION BY — side-by-side comparison.
select department
from employees
where department is not null
group by department;

-- partiton by
select *,rank() over(partition by department) as ranking 
from employees
where department is not null;

-- Q13. Find departments where multiple employees share the same salary rank.

-- Q14. Display each employee along with the total salary expense of their department.
select *,sum(salary) over(partition by department) as total_salary_expense
from employees
where department is not null;

-- Q15. Display a running total of salaries within each department.
select *,sum(salary) over(partition by department order by employee_id) as running_total
from employees;

-- Q16. Find employees earning more than the average salary of their department.
select *
from (
select *,avg(salary) over(partition by department ) as average_salary_department
from employees
) as t2
where salary > average_salary_department
;

