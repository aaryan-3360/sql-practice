-- Q1. Create a Stored Procedure to display all Active employees.
Delimiter $$
create procedure activeEmployees()
begin
select *
from employees
where employment_status ="Active";
end $$
Delimiter ;

call activeEmployees();

-- Q2. Create a Stored Procedure that accepts a department name and displays employees of that department.
delimiter $$

create procedure display_department(in dept_name varchar(100))
begin
select *
from employees
where department = dept_name;
end $$
delimiter ;

call display_department("Finance");

-- Q3. Create a Stored Procedure to add ₹1,000 to the salary of all employees in a department, then display the updated rows.
delimiter $$
create procedure display_inc_salary(in dept_name varchar(30))
begin
update employees
set salary = salary + 1000
where department = dept_name;

select *
from employees 
where department = dept_name;
end $$
delimiter ;

call display_inc_salary("IT");

-- Q4. Create a Stored Procedure to return the total number of employees.
Delimiter $$
create procedure total_employees(out total_count int)
begin
select count(*) into total_count
from employees;
end $$
delimiter ;

call total_employees(@total_count);
select @total_count;