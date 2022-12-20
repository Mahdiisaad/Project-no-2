use employees;
/* The first task is for  breakdown between
 the male and female employees working in the company each year, starting from 1990.*/
SELECT 
    YEAR(d.from_date) AS calendar_year,
    e.gender,    
    COUNT(e.emp_no) AS num_of_employees
FROM     
       employees e         
          JOIN    
       dept_emp d ON d.emp_no = e.emp_no
         join
		departments de on de.dept_no = de.dept_no

GROUP BY calendar_year, e.gender 
order by d.from_date;

/* obtain the average male
 and female salary per department within a certain salary range.
 Let this range be defined by two values the user can insert when calling the procedure. */
 
DROP PROCEDURE IF EXISTS salary_range;

DELIMITER $$
CREATE PROCEDURE salary_range (IN p_min_salary FLOAT, IN p_max_salary FLOAT)
BEGIN
SELECT 
    d.dept_name, e.gender, Round(AVG(s.salary), 2) as avg_salary, YEAR(de.from_date) AS calendar_year
FROM
    salaries s
        JOIN
    employees e ON s.emp_no = e.emp_no
        JOIN
    dept_emp de ON de.emp_no = e.emp_no
        JOIN
    departments d ON d.dept_no = de.dept_no
    WHERE s.salary BETWEEN p_min_salary AND p_max_salary
GROUP BY d.dept_no, e.gender
order by de.from_date;
END$$

DELIMITER ;

CALL salary_range(20000, 90000);

