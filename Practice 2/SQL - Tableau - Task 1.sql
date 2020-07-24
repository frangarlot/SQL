/*Create a visualization that provides a breakdown between the male and 
female employees working in the company each year, starting from 1990.*/

USE employees_mod;

/*------------------------------------------------------------------------------------------*/
##Total employees per year in the company

SELECT 
    a.*, COUNT(DISTINCT d.emp_no) AS num_employees
FROM
    t_dept_emp d
        JOIN
    t_employees e ON d.emp_no = e.emp_no
        CROSS JOIN
    (SELECT 
        YEAR(from_date) AS calendar_year
    FROM
        t_dept_emp
    GROUP BY calendar_year UNION SELECT 
        YEAR(to_date) AS calendar_year
    FROM
        t_dept_emp
    GROUP BY calendar_year) a
WHERE
    calendar_year BETWEEN YEAR(d.from_date) AND YEAR(d.to_date)
GROUP BY calendar_year
HAVING calendar_year BETWEEN 1990 AND YEAR(SYSDATE())
ORDER BY calendar_year;

/*---------------------------------------------------------------------------*/
#Total employees per year per gender in the company

SELECT 
    a.*, e.gender, COUNT(DISTINCT d.emp_no) AS num_employees
FROM
    t_dept_emp d
        JOIN
    t_employees e ON d.emp_no = e.emp_no
        CROSS JOIN
    (SELECT 
        YEAR(from_date) AS calendar_year
    FROM
        t_dept_emp
    GROUP BY calendar_year UNION SELECT 
        YEAR(to_date) AS calendar_year
    FROM
        t_dept_emp
    GROUP BY calendar_year) a
WHERE
    calendar_year BETWEEN YEAR(d.from_date) AND YEAR(d.to_date)
GROUP BY calendar_year , gender
HAVING calendar_year BETWEEN 1990 AND YEAR(SYSDATE())
ORDER BY calendar_year;
