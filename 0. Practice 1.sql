/*Working with the “employees” table, use the LIKE operator to select the data
 about all individuals, whose first name starts with “Mar”; specify that the 
 name can be succeeded by any sequence of characters.*/
 
 USE employees;
 
SELECT 
    *
FROM
    employees
WHERE
    first_name LIKE ('Mar%');
  
##Only for letters:

SELECT 
    *
FROM
    employees
WHERE
    first_name LIKE ('Mar_');
    
/*Retrieve a list with all employees who have been hired in the year 2000.*/

SELECT 
    *
FROM
    employees
WHERE
    YEAR(hire_date) = 2000;
    
SELECT 
    *
FROM
    employees
WHERE
    hire_date LIKE ('2000%');
    
SELECT 
    *
FROM
    employees
WHERE
    hire_date LIKE ('2000-%-%');
    
SELECT 
    *
FROM
    employees
WHERE
    hire_date LIKE ('2000-__-__');
    
/*Retrieve a list with all employees whose employee number
 is written with 5 characters, and starts with “1000”*/
 
 SELECT 
    *
FROM
    employees
WHERE
    emp_no LIKE ('1000_');
    
/*Obtain a list with all different “hire dates” from the “employees” table.
 To make sure your output will contain no more than 1000 rows, expand this 
 list and click on “Limit to 1000 rows”. This way you will set the limit of
 the displayed output rows back to the default of 1000.*/
 
SELECT DISTINCT
    hire_date
FROM
    employees
LIMIT 1000;

/*Select all data from the “employees” table, ordering it by “hire date” in descending order.*/

SELECT 
    *
FROM
    employees
ORDER BY hire_date DESC;

/*How many annual contracts with a value higher than $100,000 have been registered in the salaries table?*/

SELECT 
    COUNT(emp_no)
FROM
    salaries
WHERE
    salary > 100000;
    
/*How many managers do we have in the “employees” database? Use the star symbol (*) in your code to solve this exercise.*/

SELECT 
    COUNT(*)
FROM
    dept_manager;
    
/*Select all the information from the “salaries” table regarding contracts from 66,000 to 70,000 dollars per year.*/

SELECT 
    *
FROM
    salaries
WHERE
    salary BETWEEN 66000 AND 70000;
    
/*Retrieve a list with all individuals whose employee number is not between ‘10004’ and ‘10012’.*/

SELECT 
    *
FROM
    employees
WHERE
    emp_no NOT BETWEEN 10004 AND 10012;

/*Select the names of all departments with numbers between ‘d003’ and ‘d006’*/

SELECT 
    dept_name, dept_no
FROM
    departments
WHERE
    dept_no BETWEEN 'd003' AND 'd006'
ORDER BY dept_no;

/*Retrieve a list with data about all female employees who were hired in 
the year 2000 or after. Hint: If you solve the task correctly, SQL should 
return 7 rows.*/ #son 8 porque stella parkinson fue agregada en los ejercicios posteriores

SELECT 
    *
FROM
    employees
WHERE
    gender = 'F' AND YEAR(hire_date) >= 2000;
    
/*Extract a list with all employees’ salaries higher than $150,000 per annum*/

SELECT 
    *
FROM
    salaries
WHERE
    salary >= 150000;
    
/*Write a query that obtains an output whose first column must contain
 annual salaries higher than 80,000 dollars. The second column, renamed
 to “emps_with_same_salary”, must show the number of employee contracts 
 signed with this salary.*/
 
SELECT 
    salary, COUNT(emp_no) AS emp_with_same_salary
FROM
    salaries
WHERE
    salary > 80000
GROUP BY salary;


SELECT 
    salary, COUNT(emp_no) AS emp_with_same_salary
FROM
    salaries
GROUP BY salary
HAVING salary > 80000;

/*Select all employees whose average salary is higher than $120,000 per annum. Hint: You should obtain 101 records.*/

SELECT 
    emp_no, AVG(salary) AS avg_salary
FROM
    salaries
GROUP BY emp_no
HAVING avg_salary > 120000
ORDER BY avg_salary;

/*Select the employee numbers of all individuals who have signed more
 than 1 contract after the 1st of January 2000. Hint: To solve this
 exercise, use the “dept_emp” table.*/
 
SELECT 
    emp_no, COUNT(from_date) AS n_of_contracts
FROM
    dept_emp
WHERE
    from_date > '2000-01-01'
GROUP BY emp_no
HAVING n_of_contracts > 1
ORDER BY n_of_contracts;

/*How many departments are there in the “employees” database? 
Use the ‘dept_emp’ table to answer the question.*/

USE employees;

SELECT COUNT(DISTINCT dept_no) FROM dept_emp;

/*What is the total amount of money spent on salaries for all contracts starting after the 1st of January 1997?*/

SELECT 
    SUM(salary)
FROM
    salaries
WHERE
    from_date > '1997-01-01';

/*Which is the lowest employee number in the database?*/

SELECT 
    MIN(emp_no)
FROM
    employees;
    
/*Which is the highest employee number in the database?*/

SELECT MAX(emp_no) FROM employees;

/*What is the average annual salary paid to employees who started after the 1st of January 1997?*/

SELECT * FROM salaries;

##POR AÑO
SELECT 
    YEAR(from_date) AS years, AVG(salary)
FROM
    salaries
WHERE
    from_date > '1997-01-01'
GROUP BY years
ORDER BY years;
#############################
SELECT 
    *
FROM
    salaries
WHERE
    salary = 0;

##HABÍA UNA FILA CON SALARIO CERO ASIQ LA ELIMINÉ
DELETE FROM salaries 
WHERE
    salary = 0;
#########################################################
#PROMEDIO TOTAL
SELECT 
    AVG(salary)
FROM
    salaries
WHERE
    from_date > '1997-01-01';

/*Round the average amount of money spent on salaries for all contracts that started after 
the 1st of January 1997 to a precision of cents.*/

SELECT 
    ROUND(AVG(salary), 2)
FROM
    salaries
WHERE
    from_date > '1997-01-01';
    
/*Select the department number and name from the ‘departments_dup’
 table and add a third column where you name the department number (‘dept_no’) 
 as ‘dept_info’. If ‘dept_no’ does not have a value, use ‘dept_name’.*/
 
SELECT 
    dept_no, dept_name, IFNULL(dept_no, dept_name) AS dept_info
FROM
    departments_dup;
    
SELECT 
    dept_no,
    dept_name,
    COALESCE(dept_no, dept_name) AS dept_info
FROM
    departments_dup;

/*Modify the code obtained from the previous exercise in the following way. Apply the
 IFNULL() function to the values from the first and second column, so that ‘N/A’ is displayed
 whenever a department number has no value, and ‘Department name not provided’ is shown if there
 is no value for ‘dept_name’.*/
 
SELECT 
    IFNULL(dept_no, 'N/A') AS dept_no,
    IFNULL(dept_name,
            'Department name not provided') AS dept_name
FROM
    departments_dup;
    
SELECT 
    COALESCE(dept_no, 'N/A') AS dept_no,
    COALESCE(dept_name,
            'Department name not provided') AS dept_name
FROM
    departments_dup;
    
/*Extract a list containing information about all managers’ employee number, 
first and last name, department number, and hire date. */
    
SELECT 
    e.emp_no, e.first_name, e.last_name, d.dept_no, e.hire_date
FROM
    employees e
        JOIN
    dept_manager d ON e.emp_no = d.emp_no;

/*Join the 'employees' and the 'dept_manager' tables to return a
 subset of ALL the employees whose last name is Markovitch. See if
 the output contains a manager with that name. Hint: Create an output
 containing information corresponding to the following fields: ‘emp_no’,
 ‘first_name’, ‘last_name’, ‘dept_no’, ‘from_date’. Order by 'dept_no'
 descending, and then by 'emp_no'*/
 
 
 #DE ESTA FORMA LOS QUE TENGAN DEPT_NO Y FROM_DATE SE QUE VAN A SER MANAGERS
 SELECT 
    e.emp_no, e.first_name, e.last_name, d.dept_no, d.from_date
FROM
    employees e
        LEFT JOIN
    dept_manager d ON e.emp_no = d.emp_no
WHERE
    e.last_name = 'Markovitch'
ORDER BY d.dept_no DESC , emp_no;

/*------------------------------------------------------------------------------------------*/
#PARA VER EL DEPTO DE TODOS LOS EMPLEADOS Y SU TITULO
SELECT 
    e.emp_no,
    e.first_name,
    e.last_name,
    COALESCE(d.dept_no, de.dept_no) AS dept_no,
    COALESCE(d.from_date, de.from_date) AS from_date,
    t.title
FROM
    dept_emp de
        RIGHT JOIN
    employees e ON de.emp_no = e.emp_no
        LEFT JOIN
    titles t ON e.emp_no = t.emp_no
        LEFT JOIN
    dept_manager d ON e.emp_no = d.emp_no
WHERE
    e.last_name = 'Markovitch'
GROUP BY emp_no
ORDER BY dept_no , title;


/*Extract a list containing information about all managers’ employee number,
 first and last name, department number, and hire date. Use the old type of 
 join syntax to obtain the result.*/

#NEW SYNTAX 
 SELECT 
    e.emp_no, e.first_name, e.last_name, d.dept_no, e.hire_date
FROM
    employees e
        JOIN
    dept_manager d ON e.emp_no = d.emp_no;

#OLD SYNTAX    
SELECT 
    e.emp_no, e.first_name, e.last_name, d.dept_no, e.hire_date
FROM
    employees e,
    dept_manager d
WHERE
    e.emp_no = d.emp_no;
    
/*Select the first and last name, the hire date, and the job title of all employees
 whose first name is “Margareta” and have the last name “Markovitch”.*/
 
SELECT 
    e.first_name, e.last_name, e.hire_date, t.title
FROM
    employees e
        JOIN
    titles t ON e.emp_no = t.emp_no
WHERE
    last_name = 'Markovitch'
        AND first_name = 'Margareta';
        
/*Use a CROSS JOIN to return a list with all possible combinations
 between managers from the dept_manager table and department number 9.*/
 
 SELECT * FROM dept_manager;
 
 SELECT * FROM departments;  # hay un depto mal escrito Business Análisis en vez de Analysis
 
##LO CAMBIO
UPDATE departments 
SET 
    dept_name = 'Business Analysis'
WHERE
    dept_no = 'd010';
COMMIT;
 
## EL EJERCICIO:
 SELECT 
    dm.*, d.*
FROM
    dept_manager dm
        CROSS JOIN
    departments d
WHERE
    d.dept_no = 'd009'
ORDER BY emp_no , d.dept_no; 

/*Return a list with the first 10 employees with all the departments 
they can be assigned to. Hint: Don’t use LIMIT; use a WHERE clause.*/

SELECT 
    e.emp_no, d.dept_no, d.dept_name
FROM
    employees e
        CROSS JOIN
    departments d
WHERE
    emp_no < 10011
ORDER BY dept_no , e.emp_no;

/*Select all managers’ first and last name, hire date, job title, start date, and department name.*/

SELECT 
    e.first_name,
    e.last_name,
    e.hire_date,
    t.title,
    t.from_date,
    d.dept_name
FROM
    employees e
        JOIN
    titles t ON e.emp_no = t.emp_no
        JOIN
    dept_manager dm ON t.emp_no = dm.emp_no
        JOIN
    departments d ON dm.dept_no = d.dept_no
WHERE
    t.title = 'Manager';
    
/*How many male and how many female managers do we have in the ‘employees’ database?*/

SELECT 
    e.gender, COUNT(e.emp_no)
FROM
    employees e
        JOIN
    dept_manager dm ON e.emp_no = dm.emp_no
GROUP BY e.gender;

/*Devolver la unión de la tabla empleados con la condición de que
 sean de apellido Denis, más la tabla completa de managers que son 24.*/
 
SELECT 
    emp_no,
    birth_date,
    first_name,
    last_name,
    gender,
    hire_date,
    NULL AS dept_no,
    NULL AS from_date,
    NULL AS to_date
FROM
    employees
WHERE
    last_name = 'Denis' 
UNION SELECT 
    emp_no,
    NULL AS birth_date,
    NULL AS first_name,
    NULL AS last_name,
    NULL AS gender,
    NULL AS hire_date,
    dept_no,
    from_date,
    to_date
FROM
    dept_manager;
    
/*Extract the information about all department managers who were hired between the 1st of January 1990 and the 1st of January 1995.*/

USE employees;

SELECT 
    e.emp_no,
    e.first_name,
    e.last_name,
    e.gender,
    e.hire_date,
    d.dept_no,
    d.from_date,
    d.to_date
FROM
    employees e
        JOIN
    dept_manager d ON e.emp_no = d.emp_no
WHERE
    hire_date BETWEEN '1990-01-01' AND '1995-01-01';
    
/*Select the entire information for all employees whose job title is
 “Assistant Engineer”. Hint: To solve this exercise, use the 'employees' table.*/
 
 USE employees;
 
SELECT 
    e.*
FROM
    employees e
        JOIN
    titles t ON e.emp_no = t.emp_no
WHERE
    t.title = 'Assistant Engineer'
GROUP BY emp_no;

/*Obtain a result set containing the employee number, first name, and last name 
of all employees with a number higher than 109990. Create a fourth column in the 
query, indicating whether this employee is also a manager, according to the data 
provided in the dept_manager table, or a regular employee.*/

SELECT 
    e.emp_no,
    e.first_name,
    e.last_name,
    CASE
        WHEN
            e.emp_no IN (SELECT 
                    d.emp_no
                FROM
                    dept_manager d)
        THEN
            'Manager'
        ELSE 'Regular employee'
    END AS is_manager
FROM
    employees e
WHERE
    emp_no > 109990
GROUP BY emp_no
ORDER BY is_manager;




/*ASIGNAR 20 empleados y su depto correspondiente a dos managers con código: el 110022 y el 110039*/

SELECT * FROM dept_emp;
SELECT * FROM dept_manager;

SELECT 
    dm.emp_no
FROM
    dept_manager dm
WHERE
    dm.emp_no = 110022 OR dm.emp_no = 110039;
/*-------------------------------------------------------------------------------------------------*/

SELECT 
    d.emp_no, d.dept_no, d.from_date
FROM
    dept_emp d
        JOIN
    (SELECT 
        emp_no, MAX(from_date) AS from_date
    FROM
        dept_emp
    GROUP BY emp_no) a ON d.emp_no = a.emp_no
        AND d.from_date = a.from_date
WHERE
    d.emp_no < 10011;

## or WHERE d.emp_no BETWEEN 10011 AND 10021;

/*-------------------------------------------------------------------------------------------------*/

SELECT 
    d.emp_no, d.dept_no, dm.emp_no AS Manager_ID
FROM
    dept_emp d
        JOIN
    (SELECT 
        emp_no, MAX(from_date) AS from_date
    FROM
        dept_emp
    GROUP BY emp_no) a ON d.emp_no = a.emp_no
        AND d.from_date = a.from_date
        CROSS JOIN
    (SELECT 
        emp_no
    FROM
        dept_manager
    WHERE
        emp_no = 110022) dm
WHERE
    d.emp_no < 10021 
UNION SELECT 
    d.emp_no, d.dept_no, dm.emp_no AS Manager_ID
FROM
    dept_emp d
        JOIN
    (SELECT 
        emp_no, MAX(from_date) AS from_date
    FROM
        dept_emp
    GROUP BY emp_no) a ON d.emp_no = a.emp_no
        AND d.from_date = a.from_date
        CROSS JOIN
    (SELECT 
        emp_no
    FROM
        dept_manager
    WHERE
        emp_no = 110039) dm
WHERE
    d.emp_no BETWEEN 10021 AND 10040;
    
/*Create a view that will extract the average salary of all managers registered in the database.
 Round this value to the nearest cent. If you have worked correctly, after executing the view from 
 the “Schemas” section in Workbench, you should obtain the value of 66924.27.*/
 
 USE employees;
 
CREATE OR REPLACE VIEW v_manager_avg_salary AS
    SELECT 
        ROUND(AVG(s.salary), 2)
    FROM
        salaries s
            JOIN
        dept_manager dm ON s.emp_no = dm.emp_no; 
        
/*Create a procedure that will provide the average salary of all employees. Then, call the procedure.*/

USE employees;

DELIMITER $$
CREATE PROCEDURE avg_salary()
BEGIN
	SELECT ROUND(AVG(salary),2) 
    FROM salaries;
END $$
DELIMITER ;

CALL avg_salary();
CALL average_salary();

DROP PROCEDURE avg_salary;

/*Create a procedure called ‘emp_info’ that uses as parameters the first and the last name of an individual,
 and returns their employee number.*/

DELIMITER $$ 
CREATE PROCEDURE emp_info(in p_first_name VARCHAR(255), in p_last_name VARCHAR(255))
BEGIN
	SELECT 
		emp_no
	FROM
		employees
	WHERE
		first_name = p_first_name
			AND last_name = p_last_name;
END $$
DELIMITER ;

CALL emp_info('Margareta', 'Markovitch');

DROP PROCEDURE emp_info3;

/*Create a variable, called ‘v_emp_no’, where you will store the output of the procedure 
you created in the last exercise. Call the same procedure, inserting the values ‘Aruna’ and 
‘Journel’ as a first and last name respectively. Finally, select the obtained output.*/

DELIMITER $$ 
CREATE PROCEDURE emp_info_out(in p_first_name VARCHAR(255), in p_last_name VARCHAR(255), out v_last_name INT)
BEGIN
	SELECT 
		emp_no INTO v_last_name
	FROM
		employees
	WHERE
		first_name = p_first_name
			AND last_name = p_last_name;
END $$
DELIMITER ;

CALL emp_info_out('Aruna', 'Journel', @v_emp_no);
SELECT @v_emp_no;

/*Create a function called ‘emp_info’ that takes for parameters the first and last name 
of an employee, and returns the salary from the newest contract of that employee. Hint: 
In the BEGIN-END block of this program, you need to declare and use two variables: 
v_max_from_date that will be of the DATE type, and v_salary, that will be of the 
DECIMAL (10,2) type. Finally, select this function.*/

USE employees;
/*-----------------------------------------------------------------------------------------------------------------------------*/
SELECT * FROM salaries;
SELECT * FROM employees WHERE emp_no = 10001;

SELECT 
    MAX(s.from_date)  
FROM
    salaries s
        JOIN
    employees e ON s.emp_no = e.emp_no
WHERE
    e.first_name = 'Georgi'
        AND e.last_name = 'Facello';
/*-----------------------------------------------------------------------------------------------------------------------------*/
DELIMITER $$
CREATE FUNCTION emp_info3 (p_first_name VARCHAR(255), p_last_name VARCHAR (255)) RETURNS DECIMAL(10,2)
DETERMINISTIC NO SQL READS SQL DATA
BEGIN
DECLARE v_max_from_date DATE;
DECLARE v_salary DECIMAL(10,2);

SELECT 
    MAX(s.from_date) INTO v_max_from_date 
FROM
    salaries s
        JOIN
    employees e ON s.emp_no = e.emp_no
WHERE
    e.first_name = p_first_name
        AND e.last_name = p_last_name;

SELECT 
    s.salary INTO v_salary 
FROM
    salaries s
        JOIN
    employees e ON s.emp_no = e.emp_no
WHERE
    e.first_name = p_first_name
        AND e.last_name = p_last_name
        AND s.from_date = v_max_from_date;

RETURN v_salary;
END $$
DELIMITER ;

SELECT emp_info3('Georgi', 'Facello');

/*Extract a dataset containing the following information about the managers:
 employee number, first name, and last name. Add two columns at the end – one showing 
 the difference between the maximum and minimum salary of that employee, and another 
 one saying whether this salary raise was higher than $30,000 or NOT.*/

USE employees;

SELECT * FROM dept_manager;
SELECT * FROM salaries;

SELECT 
    e.emp_no,
    e.first_name,
    e.last_name,
    MAX(s.salary) - MIN(s.salary) AS salary_difference,
    CASE
        WHEN MAX(s.salary) - MIN(s.salary) > 30000 THEN 'Salary raise is higher than 30.000'
        ELSE 'Raise Lower than 30.000'
    END AS raise_higher_than_30K
FROM
    employees e
        JOIN
    salaries s ON e.emp_no = s.emp_no
        JOIN
    dept_manager dm ON s.emp_no = dm.emp_no
GROUP BY emp_no
ORDER BY salary_difference DESC;

/*Extract the employee number, first name, and last name of the first 100 employees,
 and add a fourth column, called “current_employee” saying “Is still employed” if the
 employee is still working in the company, or “Not an employee anymore” if they aren’t. 
 Hint: You’ll need to use data from both the ‘employees’ and the ‘dept_emp’ table to solve 
 this exercise.*/
 
 USE employees;
 
SELECT 
    e.emp_no,
    e.first_name,
    e.last_name,
    d.to_date,
    CASE
        WHEN d.to_date > SYSDATE() THEN 'Is still employed'
        ELSE 'Not an employee anymore'
    END AS current_employee
FROM
    employees e
        JOIN
    dept_emp d ON e.emp_no = d.emp_no
WHERE
    e.emp_no < 10101
GROUP BY emp_no;
    


