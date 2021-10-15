-- Select the employee number, last name, first name, sex, and salary of all employees, ordered by employee number
SELECT e.emp_no, last_name, first_name, sex, salary
FROM employees e
JOIN salaries ON e.emp_no = salaries.emp_no
ORDER BY e.emp_no;

-- Select the first name, last name, and hiring date for all employees hired in 1986 
SELECT first_name, last_name, hire_date
FROM employees
WHERE date_part('year', hire_date) = 1986;

-- Select the department number, department name, employee number, last name, and first name of all managers of each department
SELECT d.dept_no, d.name, e.emp_no, e.last_name, e.first_name
FROM departments d
    JOIN dept_manager dm ON d.dept_no = dm.dep_no
    JOIN employees e ON dm.emp_no = e.emp_no;

-- Select the employee number, last name, first name, and department of each employee, ordered by employee number
SELECT e.emp_no, e.last_name, e.first_name, d.name
FROM employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    JOIN departments d ON d.dept_no = de.dep_no
ORDER BY e.emp_no;

-- Select first name, last name, birth date, and sex of all employees whose first name is "Hercules" and last name begins with a "B"
SELECT first_name, last_name, birth_date, sex
FROM employees
WHERE first_name = 'Hercules'
    AND LEFT(last_name, 1) = 'B';

-- Select employee number, last name, first name, and department name of all employees in the Sales department, ordered by employee number
SELECT e.emp_no, e.last_name, e.first_name, d.name
FROM employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    JOIN departments d ON d.dept_no = de.dep_no
WHERE d.name = 'Sales'
ORDER BY e.emp_no;

-- Select employee number, last name, first name, and department name of all employees in the 'Sales' OR the 'Development' department, ordered by employee number
SELECT e.emp_no, e.last_name, e.first_name, d.name
FROM employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    JOIN departments d ON d.dept_no = de.dep_no
WHERE d.name = 'Sales'
    OR d.name = 'Development'
ORDER BY e.emp_no;

-- Count the number of employees, grouped by last name
SELECT last_name, COUNT(*)
FROM employees
GROUP BY last_name;