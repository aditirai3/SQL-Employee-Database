-- Data Analysis
-- 1. List employee number, last name, first name, sex, and salary for each employee
SELECT employees.emp_no, employees.last_name, employees.first_name, employees.sex, salaries.salary
FROM salaries
INNER JOIN employees on
employees.emp_no = salaries.emp_no;

-- 2. List first name, last name, and hire date for employees who were hired in 1986
SELECT first_name, last_name, hire_date from employees
WHERE hire_date >= '1986-01-01' and hire_date <= '1986-12-31'

-- 3. List the manager of each department: dep no., dep name, the manager's employee no., last name, first name
SELECT dept_manager.dept_no, departments.dept_name, employees.emp_no, employees.last_name, employees.first_name
FROM dept_manager JOIN employees
ON dept_manager.emp_no = employees.emp_no
JOIN departments ON
departments.dept_no = dept_manager.dept_no;

-- 4. List the department of each employee: employee number, last name, first name, and department name
SELECT employees.emp_no, employees.last_name, employees.first_name, dept_emp.dept_no, departments.dept_name
FROM dept_emp
JOIN employees on employees.emp_no = dept_emp.emp_no
JOIN departments on dept_emp.dept_no = departments.dept_no;

-- 5. List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."
SELECT first_name, last_name, sex from employees
where first_name = 'Hercules' and last_name LIKE 'B%';

-- 6. List all employees in the Sales department, including their employee number, last name, first name, and department name
SELECT employees.emp_no, employees.last_name, employees.first_name, dept_emp.dept_no, departments.dept_name
FROM dept_emp
JOIN employees on dept_emp.emp_no = employees.emp_no
JOIN departments on dept_emp.dept_no = departments.dept_no
WHERE dept_name = 'Sales';

-- 7. List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name
SELECT employees.emp_no, employees.last_name, employees.first_name, dept_emp.dept_no, departments.dept_name
FROM dept_emp
JOIN employees on dept_emp.emp_no = employees.emp_no
JOIN departments on dept_emp.dept_no = departments.dept_no
WHERE dept_name in ('Sales', 'Development');

-- 8. In descending order, list the frequency count of employee last names, i.e., how many employees share each last name
select last_name, count(last_name) as "Last name frequency" from employees
group by last_name
order by count(last_name) DESC;
