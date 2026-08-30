-- Q. Whenever an employee's salary is updated, automatically store the 
-- employee ID, old salary, new salary, increment date, and increment percentage in a salary_history table.

DELIMITER //

CREATE TRIGGER updateSalaryAndInsert
AFTER UPDATE ON employees
FOR EACH ROW
BEGIN
    IF OLD.salary <> NEW.salary THEN
        INSERT INTO salary_history (
            employee_id,
            old_salary,
            new_salary,
            increment_date,
            increment_pct
        )
        VALUES (
            OLD.employee_id,
            OLD.salary,
            NEW.salary,
            CURDATE(),
            ROUND(((NEW.salary - OLD.salary) / OLD.salary) * 100, 2)
        );
    END IF;
END //

DELIMITER ;

UPDATE employees
SET salary = salary + 5000
WHERE employee_id = 45;

SELECT * FROM salary_history;
