/*Compare the number of male managers to the number of female managers from
 different departments for each year, starting from 1990.*/
 
USE employees_mod;

SELECT 
    *
FROM
    t_dept_manager
GROUP BY emp_no;
/*-----------------------------------------------------------------------------------------*/
SELECT 
    YEAR(from_date) AS calendar_year
FROM
    t_dept_manager
GROUP BY calendar_year 
UNION SELECT 
    YEAR(to_date) AS calendar_year
FROM
    t_dept_manager
GROUP BY calendar_year;
/*---------------------------------------------------------------------------------------*/

SELECT 
    a.*,
    d.dept_name,
    e.gender,
    COUNT(DISTINCT dm.emp_no) AS number_of_managers
FROM
    t_employees e
        JOIN
    t_dept_manager dm ON e.emp_no = dm.emp_no
        JOIN
    t_departments d ON dm.dept_no = d.dept_no
        CROSS JOIN
    (SELECT 
        YEAR(from_date) AS calendar_year
    FROM
        t_dept_manager
    GROUP BY calendar_year UNION SELECT 
        YEAR(to_date) AS calendar_year
    FROM
        t_dept_manager
    GROUP BY calendar_year) AS a
WHERE
    a.calendar_year BETWEEN YEAR(dm.from_date) AND YEAR(dm.to_date)
GROUP BY calendar_year , dept_name , gender
HAVING calendar_year BETWEEN 1990 AND YEAR(SYSDATE())
ORDER BY calendar_year , dept_name;
